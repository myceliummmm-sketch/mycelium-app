import { Router, Response } from 'express';
import prisma from '../utils/prisma';
import { authMiddleware, AuthRequest } from '../middleware/auth';

const router = Router();
router.use(authMiddleware);

/**
 * GET /leaderboard/tokens
 * Get leaderboard by MYC tokens
 */
router.get('/tokens', async (req: AuthRequest, res: Response) => {
  try {
    const limit = parseInt(req.query.limit as string) || 100;

    const topUsers = await prisma.user.findMany({
      orderBy: { mycTokens: 'desc' },
      take: limit,
      select: {
        id: true,
        username: true,
        firstName: true,
        lastName: true,
        photoUrl: true,
        mycTokens: true,
        level: true,
        _count: {
          select: {
            testResults: true,
            achievements: true,
          },
        },
      },
    });

    // Get current user rank
    const currentUser = await prisma.user.findUnique({
      where: { id: req.userId },
    });

    const userRank = currentUser
      ? await prisma.user.count({
          where: {
            mycTokens: { gt: currentUser.mycTokens },
          },
        }) + 1
      : null;

    res.json({
      leaderboard: topUsers.map((user, index) => ({
        rank: index + 1,
        ...user,
      })),
      currentUserRank: userRank,
    });
  } catch (error) {
    console.error('Get tokens leaderboard error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /leaderboard/metaskills/:domain/:skill
 * Get leaderboard by specific metaskill
 */
router.get('/metaskills/:domain/:skill', async (req: AuthRequest, res: Response) => {
  try {
    const { domain, skill } = req.params;
    const limit = parseInt(req.query.limit as string) || 100;

    const topMetaskills = await prisma.metaskill.findMany({
      where: { domain, skill },
      orderBy: { score: 'desc' },
      take: limit,
      include: {
        user: {
          select: {
            id: true,
            username: true,
            firstName: true,
            lastName: true,
            photoUrl: true,
            mycTokens: true,
            level: true,
          },
        },
      },
    });

    // Get current user rank
    const currentUserMetaskill = await prisma.metaskill.findFirst({
      where: {
        userId: req.userId,
        domain,
        skill,
      },
    });

    const userRank = currentUserMetaskill
      ? await prisma.metaskill.count({
          where: {
            domain,
            skill,
            score: { gt: currentUserMetaskill.score },
          },
        }) + 1
      : null;

    res.json({
      leaderboard: topMetaskills.map((metaskill, index) => ({
        rank: index + 1,
        user: metaskill.user,
        score: metaskill.score,
        domain: metaskill.domain,
        skill: metaskill.skill,
      })),
      currentUserRank: userRank,
      currentUserScore: currentUserMetaskill?.score,
    });
  } catch (error) {
    console.error('Get metaskills leaderboard error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /leaderboard/level
 * Get leaderboard by level
 */
router.get('/level', async (req: AuthRequest, res: Response) => {
  try {
    const limit = parseInt(req.query.limit as string) || 100;

    const topUsers = await prisma.user.findMany({
      orderBy: [
        { level: 'desc' },
        { levelProgress: 'desc' },
      ],
      take: limit,
      select: {
        id: true,
        username: true,
        firstName: true,
        lastName: true,
        photoUrl: true,
        mycTokens: true,
        level: true,
        levelProgress: true,
        _count: {
          select: {
            testResults: true,
            achievements: true,
          },
        },
      },
    });

    // Get current user rank
    const currentUser = await prisma.user.findUnique({
      where: { id: req.userId },
    });

    const userRank = currentUser
      ? await prisma.user.count({
          where: {
            OR: [
              { level: { gt: currentUser.level } },
              {
                AND: [
                  { level: currentUser.level },
                  { levelProgress: { gt: currentUser.levelProgress } },
                ],
              },
            ],
          },
        }) + 1
      : null;

    res.json({
      leaderboard: topUsers.map((user, index) => ({
        rank: index + 1,
        ...user,
      })),
      currentUserRank: userRank,
    });
  } catch (error) {
    console.error('Get level leaderboard error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
