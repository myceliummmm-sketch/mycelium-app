import { Router, Response } from 'express';
import prisma from '../utils/prisma';
import { authMiddleware, AuthRequest } from '../middleware/auth';

const router = Router();
router.use(authMiddleware);

/**
 * POST /tests/:testType/submit
 * Submit test results and update metaskills
 */
router.post('/:testType/submit', async (req: AuthRequest, res: Response) => {
  try {
    const { testType } = req.params;
    const { answers, results, sphereScores, metaskillUpdates } = req.body;

    // Validate test type
    const validTypes = ['disc', 'bigfive', 'enneagram', 'values'];
    if (!validTypes.includes(testType)) {
      return res.status(400).json({ error: 'Invalid test type' });
    }

    // Create test result
    const testResult = await prisma.testResult.create({
      data: {
        userId: req.userId!,
        testType,
        answers: answers || {},
        results: results || {},
        sphereScores: sphereScores || {},
      },
    });

    // Update metaskills if provided
    if (metaskillUpdates && Array.isArray(metaskillUpdates)) {
      for (const update of metaskillUpdates) {
        await prisma.metaskill.updateMany({
          where: {
            userId: req.userId,
            domain: update.domain,
            skill: update.skill,
          },
          data: {
            score: update.score,
          },
        });
      }
    }

    // Award MYC tokens for completing test
    await prisma.user.update({
      where: { id: req.userId },
      data: {
        mycTokens: { increment: 50 },
      },
    });

    res.json({
      testResult,
      tokensEarned: 50,
    });
  } catch (error) {
    console.error('Submit test error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /tests/results
 * Get all test results for current user
 */
router.get('/results', async (req: AuthRequest, res: Response) => {
  try {
    const results = await prisma.testResult.findMany({
      where: { userId: req.userId },
      orderBy: { completedAt: 'desc' },
    });

    res.json(results);
  } catch (error) {
    console.error('Get test results error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /tests/results/:testType
 * Get test results by type
 */
router.get('/results/:testType', async (req: AuthRequest, res: Response) => {
  try {
    const results = await prisma.testResult.findMany({
      where: {
        userId: req.userId,
        testType: req.params.testType,
      },
      orderBy: { completedAt: 'desc' },
    });

    res.json(results);
  } catch (error) {
    console.error('Get test results error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
