import { Router, Response } from 'express';
import prisma from '../utils/prisma';
import { authMiddleware, AuthRequest } from '../middleware/auth';

const router = Router();

// All routes require authentication
router.use(authMiddleware);

/**
 * GET /users/me
 * Get current user profile
 */
router.get('/me', async (req: AuthRequest, res: Response) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.userId },
      include: {
        metaskills: true,
        _count: {
          select: {
            testResults: true,
            p2pCallsUser1: true,
            p2pCallsUser2: true,
            achievements: true,
          },
        },
      },
    });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({
      id: user.id,
      telegramId: Number(user.telegramId),
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      photoUrl: user.photoUrl,
      mycTokens: user.mycTokens,
      level: user.level,
      levelProgress: user.levelProgress,
      streakDays: user.streakDays,
      metaskills: user.metaskills,
      stats: {
        testsCompleted: user._count.testResults,
        p2pCalls: user._count.p2pCallsUser1 + user._count.p2pCallsUser2,
        achievements: user._count.achievements,
      },
    });
  } catch (error) {
    console.error('Get user error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /users/:id
 * Get user by ID
 */
router.get('/:id', async (req: AuthRequest, res: Response) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.params.id },
      select: {
        id: true,
        username: true,
        firstName: true,
        lastName: true,
        photoUrl: true,
        mycTokens: true,
        level: true,
        streakDays: true,
        metaskills: true,
        _count: {
          select: {
            testResults: true,
            achievements: true,
          },
        },
      },
    });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(user);
  } catch (error) {
    console.error('Get user error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
