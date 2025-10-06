import { Router, Response } from 'express';
import prisma from '../utils/prisma';
import { authMiddleware, AuthRequest } from '../middleware/auth';

const router = Router();
router.use(authMiddleware);

/**
 * POST /p2p/match
 * Request P2P call matching
 */
router.post('/match', async (req: AuthRequest, res: Response) => {
  try {
    const { preferredSkills, duration } = req.body;

    // Get current user with metaskills
    const currentUser = await prisma.user.findUnique({
      where: { id: req.userId },
      include: { metaskills: true },
    });

    if (!currentUser) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Find potential matches based on metaskills
    // (In production, implement more sophisticated matching algorithm)
    const potentialMatches = await prisma.user.findMany({
      where: {
        id: { not: req.userId },
      },
      include: { metaskills: true },
      take: 10,
    });

    // Simple matching: find user with complementary skills
    const bestMatch = potentialMatches[0]; // Placeholder logic

    if (!bestMatch) {
      return res.status(404).json({ error: 'No matches found' });
    }

    // Create P2P call record
    const p2pCall = await prisma.p2PCall.create({
      data: {
        user1Id: req.userId!,
        user2Id: bestMatch.id,
        duration: duration || 30,
        status: 'scheduled',
      },
    });

    res.json({
      match: {
        id: bestMatch.id,
        username: bestMatch.username,
        firstName: bestMatch.firstName,
        photoUrl: bestMatch.photoUrl,
        metaskills: bestMatch.metaskills,
      },
      callId: p2pCall.id,
    });
  } catch (error) {
    console.error('Match P2P error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * POST /p2p/:callId/complete
 * Complete P2P call and submit feedback
 */
router.post('/:callId/complete', async (req: AuthRequest, res: Response) => {
  try {
    const { rating, feedback, skillsObserved } = req.body;

    // Update P2P call
    const p2pCall = await prisma.p2PCall.update({
      where: { id: req.params.callId },
      data: {
        status: 'completed',
        rating,
        feedback,
      },
    });

    // Award tokens to both participants
    await prisma.user.update({
      where: { id: p2pCall.user1Id },
      data: { mycTokens: { increment: 30 } },
    });
    await prisma.user.update({
      where: { id: p2pCall.user2Id },
      data: { mycTokens: { increment: 30 } },
    });

    // Update observed skills if provided
    if (skillsObserved && Array.isArray(skillsObserved)) {
      const otherUserId = p2pCall.user1Id === req.userId
        ? p2pCall.user2Id
        : p2pCall.user1Id;

      for (const skill of skillsObserved) {
        await prisma.metaskill.updateMany({
          where: {
            userId: otherUserId,
            domain: skill.domain,
            skill: skill.skill,
          },
          data: {
            score: { increment: skill.improvement || 0.05 },
          },
        });
      }
    }

    res.json({
      p2pCall,
      tokensEarned: 30,
    });
  } catch (error) {
    console.error('Complete P2P error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

/**
 * GET /p2p/history
 * Get P2P call history
 */
router.get('/history', async (req: AuthRequest, res: Response) => {
  try {
    const calls = await prisma.p2PCall.findMany({
      where: {
        OR: [
          { user1Id: req.userId },
          { user2Id: req.userId },
        ],
      },
      include: {
        user1: {
          select: {
            id: true,
            username: true,
            firstName: true,
            photoUrl: true,
          },
        },
        user2: {
          select: {
            id: true,
            username: true,
            firstName: true,
            photoUrl: true,
          },
        },
      },
      orderBy: { scheduledAt: 'desc' },
    });

    res.json(calls);
  } catch (error) {
    console.error('Get P2P history error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
