import { Router, Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import prisma from '../utils/prisma';
import {
  validateTelegramWebAppData,
  parseTelegramWebAppData,
  isTelegramAuthFresh,
} from '../utils/telegram-auth';

const router = Router();

/**
 * POST /auth/telegram
 * Authenticate user via Telegram Web App initData
 */
router.post('/telegram', async (req: Request, res: Response) => {
  try {
    const { initData } = req.body;

    if (!initData) {
      return res.status(400).json({ error: 'initData is required' });
    }

    // Validate Telegram signature
    const isValid = validateTelegramWebAppData(
      initData,
      process.env.TELEGRAM_BOT_TOKEN!
    );

    if (!isValid) {
      return res.status(401).json({ error: 'Invalid Telegram data' });
    }

    // Parse user data
    const { user, auth_date } = parseTelegramWebAppData(initData);

    if (!user || !auth_date) {
      return res.status(400).json({ error: 'Invalid user data' });
    }

    // Check if auth is fresh (within 24 hours)
    if (!isTelegramAuthFresh(auth_date)) {
      return res.status(401).json({ error: 'Auth data is too old' });
    }

    // Find or create user
    let dbUser = await prisma.user.findUnique({
      where: { telegramId: BigInt(user.id) },
    });

    if (!dbUser) {
      // Create new user with initial metaskills
      dbUser = await prisma.user.create({
        data: {
          telegramId: BigInt(user.id),
          username: user.username,
          firstName: user.first_name,
          lastName: user.last_name,
          photoUrl: user.photo_url,
          // Initialize default metaskills
          metaskills: {
            create: [
              // Cognitive domain
              { domain: 'cognitive', skill: 'criticalThinking', score: 0.5 },
              { domain: 'cognitive', skill: 'creativity', score: 0.5 },
              { domain: 'cognitive', skill: 'systemsThinking', score: 0.5 },
              { domain: 'cognitive', skill: 'learning', score: 0.5 },
              // Social domain
              { domain: 'social', skill: 'communication', score: 0.5 },
              { domain: 'social', skill: 'collaboration', score: 0.5 },
              { domain: 'social', skill: 'leadership', score: 0.5 },
              { domain: 'social', skill: 'empathy', score: 0.5 },
              // Emotional domain
              { domain: 'emotional', skill: 'selfAwareness', score: 0.5 },
              { domain: 'emotional', skill: 'emotionalRegulation', score: 0.5 },
              { domain: 'emotional', skill: 'resilience', score: 0.5 },
              { domain: 'emotional', skill: 'motivation', score: 0.5 },
              // Practical domain
              { domain: 'practical', skill: 'adaptability', score: 0.5 },
              { domain: 'practical', skill: 'planning', score: 0.5 },
              { domain: 'practical', skill: 'decisionMaking', score: 0.5 },
              { domain: 'practical', skill: 'execution', score: 0.5 },
            ],
          },
        },
      });
    } else {
      // Update last active
      await prisma.user.update({
        where: { id: dbUser.id },
        data: { lastActiveAt: new Date() },
      });
    }

    // Generate JWT
    const token = jwt.sign(
      {
        userId: dbUser.id,
        telegramId: Number(dbUser.telegramId),
      },
      process.env.JWT_SECRET!,
      { expiresIn: '30d' }
    );

    // Return user data and token
    res.json({
      token,
      user: {
        id: dbUser.id,
        telegramId: Number(dbUser.telegramId),
        username: dbUser.username,
        firstName: dbUser.firstName,
        lastName: dbUser.lastName,
        photoUrl: dbUser.photoUrl,
        mycTokens: dbUser.mycTokens,
        level: dbUser.level,
        levelProgress: dbUser.levelProgress,
        streakDays: dbUser.streakDays,
      },
    });
  } catch (error) {
    console.error('Auth error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

export default router;
