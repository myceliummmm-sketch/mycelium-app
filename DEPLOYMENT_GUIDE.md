# 🚀 Mycelium Deployment Guide

У тебя есть 3 простых способа задеплоить backend:

## 1️⃣ Railway (Рекомендуется) - Самый быстрый

### Способ A: Через веб-интерфейс (2 минуты)
1. Зайди на [railway.app](https://railway.app)
2. Нажми **"New Project"**
3. Выбери **"Deploy from GitHub repo"** → `mycelium_app`
4. Railway автоматически найдет backend
5. Добавь PostgreSQL: нажми **"+ New"** → **"Database"** → **"PostgreSQL"**
6. В настройках сервиса добавь переменные:
   ```
   TELEGRAM_BOT_TOKEN=7730788181:AAH6WcpygeX1HhmB-qTi1AzNx8odOVnjjlk
   JWT_SECRET=my-super-secret-jwt-key-2024
   PORT=3000
   NODE_ENV=production
   ```
7. В **Settings → Deploy** укажи **Root Directory**: `server`
8. Railway задеплоит за 2-3 минуты!
9. Скопируй URL и обнови `.env` в Flutter

### Способ B: Через Railway CLI
```bash
# 1. Авторизуйся в браузере
railway login

# 2. Создай новый проект
cd server
railway init

# 3. Добавь PostgreSQL
railway add

# 4. Задеплой
railway up

# 5. Открой настройки
railway open
```

Добавь переменные окружения через веб-интерфейс Railway.

---

## 2️⃣ Render.com - Бесплатный tier

1. Зайди на [render.com](https://render.com)
2. Нажми **"New +"** → **"Blueprint"**
3. Подключи свой GitHub репозиторий
4. Render автоматически найдет `render.yaml`
5. Добавь **TELEGRAM_BOT_TOKEN** в переменные окружения
6. Нажми **"Apply"**
7. Подожди 5-10 минут (бесплатный tier медленнее)

**Примечание**: Render бесплатно засыпает после 15 минут неактивности.

---

## 3️⃣ GitHub Actions (Автоматический деплой)

Если у тебя уже есть Railway аккаунт, можно настроить автодеплой:

### Шаг 1: Получить токены Railway

```bash
# Зайди на Railway
railway login

# Получи токен
railway whoami
```

Или зайди на [railway.app/account/tokens](https://railway.app/account/tokens)

### Шаг 2: Добавить секреты в GitHub

1. Зайди в **Settings** репозитория
2. **Secrets and variables** → **Actions**
3. Добавь секреты:
   - `RAILWAY_TOKEN` - твой Railway API token
   - `RAILWAY_PROJECT_ID` - ID проекта (найди в URL проекта)

### Шаг 3: Запустить деплой

Workflow уже настроен в `.github/workflows/deploy-railway.yml`!

Каждый push в `main` с изменениями в `server/` автоматически задеплоит.

Или запусти вручную: **Actions** → **Deploy to Railway** → **Run workflow**

---

## 📱 После деплоя

Обнови `.env` в Flutter проекте:

```env
API_URL=https://твой-проект.up.railway.app
# или
API_URL=https://твой-проект.onrender.com
```

Закоммить и запушить:
```bash
git add .env
git commit -m "Update API URL"
git push
```

---

## 🐛 Troubleshooting

### Railway: "Build failed"
- Проверь, что Root Directory = `server`
- Убедись, что `package.json` правильный
- Посмотри логи: Settings → Deployments → последний деплой

### Render: "Database connection failed"
- Подожди 1-2 минуты после создания БД
- Проверь, что `DATABASE_URL` правильно подключен

### Общие проблемы:
- **"Module not found"**: Запусти `npm install` локально, проверь `package.json`
- **"Port already in use"**: Измени `PORT` в env переменных
- **"Database error"**: Запусти миграцию: Settings → Terminal → `npx prisma db push`

---

## 💰 Стоимость

| Платформа | Бесплатно | Платный план |
|-----------|-----------|--------------|
| Railway   | $5 в месяц | $5/месяц + usage |
| Render    | ✅ Free tier | $7/месяц |
| Vercel    | ❌ (только frontend) | - |

**Рекомендация**: Railway проще и быстрее для full-stack приложений.
