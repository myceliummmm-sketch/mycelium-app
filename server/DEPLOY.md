# Деплой Mycelium API на Railway

## Быстрый старт с Railway

Railway - это самый простой способ задеплоить API с автоматической PostgreSQL базой.

### 1. Создать аккаунт на Railway

Зайди на [railway.app](https://railway.app) и зарегистрируйся через GitHub.

### 2. Создать новый проект

1. Нажми **"New Project"**
2. Выбери **"Deploy from GitHub repo"**
3. Выбери репозиторий `mycelium_app`
4. Railway автоматически определит Node.js проект

### 3. Добавить PostgreSQL

1. В проекте нажми **"+ New"**
2. Выбери **"Database" → "PostgreSQL"**
3. Railway создаст базу и автоматически сгенерирует `DATABASE_URL`

### 4. Настроить переменные окружения

В настройках сервиса (Settings → Variables) добавь:

```env
DATABASE_URL=${{Postgres.DATABASE_URL}}
TELEGRAM_BOT_TOKEN=7730788181:AAH6WcpygeX1HhmB-qTi1AzNx8odOVnjjlk
JWT_SECRET=your-super-secret-jwt-key-here
PORT=3000
NODE_ENV=production
ALLOWED_ORIGINS=https://gabil-tagiev.github.io,http://localhost:3000
```

> **Важно:** Railway автоматически подставит `DATABASE_URL` из PostgreSQL сервиса.

### 5. Настроить Root Directory

Так как проект в папке `server/`:

1. Перейди в **Settings**
2. В разделе **Build** найди **Root Directory**
3. Укажи: `server`

### 6. Deploy!

Railway автоматически:
- Установит зависимости (`npm install`)
- Сгенерирует Prisma Client (`prisma generate`)
- Скомпилирует TypeScript (`npm run build`)
- Запустит сервер (`npm start`)

После деплоя ты получишь URL типа: `https://mycelium-production.up.railway.app`

### 7. Инициализировать базу данных

После первого деплоя нужно создать таблицы:

1. Открой **Railway CLI** в проекте или используй Railway web terminal
2. Запусти миграцию:
```bash
npx prisma db push
```

## Проверка работы

```bash
# Проверь health endpoint
curl https://your-app.up.railway.app/health

# Должен вернуть:
# {"status":"ok","timestamp":"2024-01-01T00:00:00.000Z"}
```

## Обновление кода

Railway автоматически редеплоит при каждом push в `main` ветку GitHub.

## Мониторинг

Railway предоставляет:
- **Logs** - логи приложения в реальном времени
- **Metrics** - CPU, память, трафик
- **Deployments** - история деплоев

## Стоимость

- PostgreSQL: $5/месяц
- API сервис: от $5/месяц (зависит от нагрузки)
- Первые $5 бесплатно каждый месяц

## Альтернатива: Render

Если хочешь попробовать другой сервис:

1. [render.com](https://render.com)
2. Создай **Web Service** из GitHub
3. Укажи build command: `cd server && npm install && npm run build`
4. Укажи start command: `cd server && npm start`
5. Добавь PostgreSQL из раздела "New +"

## Локальная разработка

Если хочешь запустить локально:

```bash
# 1. Установи Docker Desktop
# https://www.docker.com/products/docker-desktop

# 2. Запусти PostgreSQL
docker compose up -d

# 3. Установи зависимости
cd server && npm install

# 4. Инициализируй БД
npm run db:push

# 5. Запусти dev сервер
npm run dev
```

Сервер будет доступен на `http://localhost:3000`
