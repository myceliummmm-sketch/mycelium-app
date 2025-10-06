# Mycelium Backend API

Node.js + Express + Prisma + PostgreSQL backend для Mycelium приложения с Telegram авторизацией.

## 🚀 Быстрый старт

### 1. Установить зависимости
```bash
cd server
npm install
```

### 2. Запустить PostgreSQL
```bash
# Из корня проекта
docker-compose up -d
```

### 3. Настроить БД
```bash
# Создать миграцию и применить схему
npm run db:push

# Опционально: открыть Prisma Studio для просмотра БД
npm run db:studio
```

### 4. Запустить сервер
```bash
# Development mode с hot reload
npm run dev

# Production build
npm run build
npm start
```

Сервер будет доступен на `http://localhost:3000`

## 📡 API Endpoints

### Authentication
- `POST /api/auth/telegram` - Авторизация через Telegram Web App

### Users
- `GET /api/users/me` - Получить свой профиль (требует auth)
- `GET /api/users/:id` - Получить профиль пользователя (требует auth)

### Metaskills
- `GET /api/metaskills` - Все метаскилы текущего юзера (требует auth)
- `GET /api/metaskills/domain/:domain` - Метаскилы по домену (требует auth)
- `PATCH /api/metaskills/:id` - Обновить score (требует auth)

### Tests
- `POST /api/tests/:testType/submit` - Отправить результаты теста (disc, bigfive, enneagram, values)
- `GET /api/tests/results` - Все результаты тестов текущего юзера
- `GET /api/tests/results/:testType` - Результаты по типу теста

### P2P Calls
- `POST /api/p2p/match` - Найти P2P пару
- `POST /api/p2p/:callId/complete` - Завершить звонок и отправить фидбек
- `GET /api/p2p/history` - История P2P звонков

### Leaderboard
- `GET /api/leaderboard/tokens` - Лидерборд по MYC токенам
- `GET /api/leaderboard/level` - Лидерборд по уровням
- `GET /api/leaderboard/metaskills/:domain/:skill` - Лидерборд по метаскилу

## 🔑 Environment Variables

Скопируй `.env.example` в `.env` и заполни:

```env
DATABASE_URL="postgresql://mycelium:mycelium_dev_password@localhost:5432/mycelium_db"
TELEGRAM_BOT_TOKEN="your_bot_token"
JWT_SECRET="your_secret"
PORT=3000
```

## 🗄️ Изменение схемы БД

1. Отредактируй `prisma/schema.prisma`
2. Запусти миграцию:
```bash
npm run db:migrate
# Или для быстрого прототипа:
npm run db:push
```

## 📊 Prisma Studio

Просмотр и редактирование БД через веб-интерфейс:
```bash
npm run db:studio
```

Откроется на `http://localhost:5555`

## 🚀 Деплой

Полная инструкция по деплою на Railway: [DEPLOY.md](./DEPLOY.md)

**Быстрый старт:**
1. Создай проект на [railway.app](https://railway.app)
2. Добавь PostgreSQL базу
3. Задай переменные окружения
4. Railway автоматически задеплоит API

После деплоя обнови `.env` в Flutter приложении с URL твоего API.
