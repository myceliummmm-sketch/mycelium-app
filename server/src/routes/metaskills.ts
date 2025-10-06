import { Router, Response } from 'express';
import prisma from '../utils/prisma';
import { authMiddleware, AuthRequest } from '../middleware/auth';

const router = Router();
router.use(authMiddleware);

/**
 * GET /metaskills
 * Get all metaskills for current user
 */
router.get('/', async (req: AuthRequest, res: Response) => {
  try {
    const metaskills = await prisma.metaskill.findMany({
      where: { userId: req.userId },
      orderBy: [{ domain: 'asc' }, { skill: 'asc' }],
    });

    // Group by domain
    const grouped = metaskills.reduce((acc, skill) => {
      if (!acc[skill.domain]) {
        acc[skill.domain] = [];
      }
      acc[skill.domain].push(skill);
      return acc;
    }, {} as Record<string, typeof metaskills>);

    res.json({ metaskills, grouped });
  } catch (error) {
    console.error('Get metaskills error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /metaskills/domain/:domain
 * Get metaskills by domain
 */
router.get('/domain/:domain', async (req: AuthRequest, res: Response) => {
  try {
    const metaskills = await prisma.metaskill.findMany({
      where: {
        userId: req.userId,
        domain: req.params.domain,
      },
    });

    res.json(metaskills);
  } catch (error) {
    console.error('Get domain metaskills error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * PATCH /metaskills/:id
 * Update metaskill score
 */
router.patch('/:id', async (req: AuthRequest, res: Response) => {
  try {
    const { score } = req.body;

    if (score === undefined || score < 0 || score > 1) {
      return res.status(400).json({ error: 'Score must be between 0 and 1' });
    }

    const metaskill = await prisma.metaskill.update({
      where: {
        id: req.params.id,
        userId: req.userId,
      },
      data: { score },
    });

    res.json(metaskill);
  } catch (error) {
    console.error('Update metaskill error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
