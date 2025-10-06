import crypto from 'crypto';

/**
 * Validates Telegram Web App initData signature
 * Based on official Telegram documentation
 */
export function validateTelegramWebAppData(
  initData: string,
  botToken: string
): boolean {
  try {
    const urlParams = new URLSearchParams(initData);
    const hash = urlParams.get('hash');

    if (!hash) {
      return false;
    }

    urlParams.delete('hash');

    // Sort parameters and create check string
    const dataCheckString = Array.from(urlParams.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([key, value]) => `${key}=${value}`)
      .join('\n');

    // Create secret key
    const secret = crypto
      .createHmac('sha256', 'WebAppData')
      .update(botToken)
      .digest();

    // Calculate hash
    const calculatedHash = crypto
      .createHmac('sha256', secret)
      .update(dataCheckString)
      .digest('hex');

    return calculatedHash === hash;
  } catch (error) {
    console.error('Error validating Telegram data:', error);
    return false;
  }
}

/**
 * Parses Telegram Web App initData
 */
export function parseTelegramWebAppData(initData: string): {
  user?: {
    id: number;
    first_name: string;
    last_name?: string;
    username?: string;
    photo_url?: string;
    language_code?: string;
  };
  auth_date?: number;
  hash?: string;
} {
  try {
    const urlParams = new URLSearchParams(initData);
    const userParam = urlParams.get('user');
    const authDate = urlParams.get('auth_date');
    const hash = urlParams.get('hash');

    if (!userParam) {
      return {};
    }

    const user = JSON.parse(decodeURIComponent(userParam));

    return {
      user,
      auth_date: authDate ? parseInt(authDate) : undefined,
      hash: hash || undefined,
    };
  } catch (error) {
    console.error('Error parsing Telegram data:', error);
    return {};
  }
}

/**
 * Checks if Telegram auth data is not too old (default: 24 hours)
 */
export function isTelegramAuthFresh(authDate: number, maxAgeSeconds = 86400): boolean {
  const now = Math.floor(Date.now() / 1000);
  return (now - authDate) <= maxAgeSeconds;
}
