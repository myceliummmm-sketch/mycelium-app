# 🤖 Настройка Telegram Mini App для Mycelium

## Шаг 1: Деплой Backend на Vercel

### 1.1 Залогиниться в Vercel
```bash
cd server
npx vercel login
```

### 1.2 Задеплоить проект
```bash
npx vercel --prod
```

Vercel автоматически:
- Определит настройки из `vercel.json`
- Подключится к Supabase PostgreSQL
- Задеплоит API

### 1.3 Получить URL
После деплоя ты получишь URL типа:
```
https://mycelium-server.vercel.app
```

### 1.4 Применить схему БД к Supabase
```bash
# В server/.env временно укажи DATABASE_URL из vercel.json:
DATABASE_URL="postgresql://postgres:1Globusfrost2@db.qglmebqnyrauqcamhwio.supabase.co:5432/postgres"

# Примени схему
npm run db:push
```

## Шаг 2: Настроить Telegram Bot

### 2.1 Открыть BotFather
В Telegram найди [@BotFather](https://t.me/BotFather)

### 2.2 Создать Mini App
```
/mybots
→ Выбери своего бота
→ Bot Settings
→ Menu Button
→ Configure Menu Button
```

### 2.3 Указать URL Mini App

**Для деплоя Flutter на Vercel/Netlify:**
```bash
cd ..  # вернись в корень mycelium_app
flutter build web
```

Задеплой папку `build/web` на:
- **Vercel:** `npx vercel build/web --prod`
- **Netlify:** перетащи папку в Netlify Drop
- **GitHub Pages:** push в gh-pages ветку

После деплоя получишь URL типа:
```
https://mycelium-app.vercel.app
```

### 2.4 Установить URL в BotFather
```
/mybots
→ Выбери бота
→ Bot Settings
→ Menu Button
→ Edit Menu Button URL
→ Введи: https://mycelium-app.vercel.app
```

### 2.5 Настроить кнопку
```
→ Edit Menu Button Text
→ Введи: 🧬 Open Mycelium
```

## Шаг 3: Обновить Flutter .env

Обнови `mycelium_app/.env`:
```env
# Production API URL
API_URL=https://mycelium-server.vercel.app

# Telegram Bot Token
TELEGRAM_BOT_TOKEN=7730788181:AAH6WcpygeX1HhmB-qTi1AzNx8odOVnjjlk
```

## Шаг 4: Пересобрать и задеплоить Flutter

```bash
flutter build web
npx vercel build/web --prod
```

## Шаг 5: Тестирование

1. Открой своего бота в Telegram
2. Нажми на кнопку меню (☰) внизу
3. Выбери "🧬 Open Mycelium"
4. Приложение откроется как Telegram Mini App!

## Настройки Telegram Mini App (опционально)

### Включить полноэкранный режим
```
/mybots → Bot Settings → Configure Mini App Settings
→ Enable Compact Mode: OFF
```

### Добавить описание
```
/mybots → Edit Bot → Edit Description
```

Текст:
```
Mycelium - твой персональный тренер метанавыков.

🧠 Развивай навыки мышления, коммуникации и эмоционального интеллекта
🎯 Проходи тесты и получай персонализированную аналитику
💬 Практикуй навыки в P2P звонках с AI фидбеком
📊 Отслеживай прогресс в реальном времени

Начни свой путь развития прямо сейчас!
```

### Добавить команды
```
/mybots → Edit Bot → Edit Commands
```

```
start - Начать использование
profile - Мой профиль
tests - Пройти тесты
skills - Мои метаскилы
practice - P2P практика
leaderboard - Рейтинг пользователей
help - Помощь
```

## Проверка работы

### Проверить Backend
```bash
curl https://mycelium-server.vercel.app/health
```

Должен вернуть:
```json
{"status":"ok","timestamp":"2024-..."}
```

### Проверить аутентификацию
1. Открой Mini App в Telegram
2. AuthProvider автоматически получит `initData` из Telegram
3. Отправит на `/api/auth/telegram`
4. Получит JWT токен и данные пользователя

## Мониторинг

### Vercel Dashboard
- Логи: https://vercel.com/dashboard
- Metrics: CPU, память, запросы
- Deployments: история деплоев

### Supabase Dashboard
- Database: https://supabase.com/dashboard
- Table Editor: просмотр данных
- SQL Editor: выполнение запросов

## Troubleshooting

### Ошибка "Invalid Telegram data"
- Проверь что `TELEGRAM_BOT_TOKEN` в `vercel.json` правильный
- Убедись что Mini App открывается через Telegram (не в браузере напрямую)

### Ошибка подключения к БД
- Проверь `DATABASE_URL` в Supabase Dashboard
- Убедись что IP whitelisting выключен в Supabase

### CORS ошибки
- Добавь URL Flutter app в `ALLOWED_ORIGINS` в vercel.json
- Пример: `"ALLOWED_ORIGINS": "https://mycelium-app.vercel.app"`

## Готово! 🎉

Теперь твой Telegram Mini App полностью настроен и работает!

Пользователи могут:
1. Открыть бота в Telegram
2. Нажать кнопку меню
3. Использовать полнофункциональное приложение Mycelium прямо в Telegram!
