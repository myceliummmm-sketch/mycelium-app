# 🔐 Ключи и Токены Mycelium

> ⚠️ Это пример файла. Реальные ключи хранятся в `KEYS_AND_TOKENS.md` (не коммитится в Git)

## Telegram Bot
```
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
```

## GitHub
```
GitHub Username: your_username
GitHub Token: your_github_token_here
Repository: https://github.com/your_username/your_repo
```

## Netlify
```
Email: your_email@example.com
Team: your_team_name
Status: Logged in and authenticated
```

## Deployment URLs

### Production
- **GitHub Pages**: https://your_username.github.io/your_repo/
- **Telegram Bot**: открывается через кнопку "🧬 Open Mycelium"

### Backend (когда будет задеплоен)
- **Vercel/Railway**: TBD
- **Database**: TBD

## JWT Secret (для backend)
```
JWT_SECRET=your_super_secret_jwt_key_here
```

## Важные команды

### Деплой на GitHub Pages
```bash
# 1. Закоммитить изменения
git add -A
git commit -m "Описание версии"

# 2. Запушить в main (автоматический деплой через GitHub Actions)
git push origin main

# 3. Подождать ~3-4 минуты, проверить деплой:
gh run list --limit 1
```

### Обновить Telegram Bot Menu Button
```bash
curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setChatMenuButton" \
  -H "Content-Type: application/json" \
  -d '{
    "menu_button": {
      "type": "web_app",
      "text": "🧬 Open Mycelium",
      "web_app": {
        "url": "https://your_username.github.io/your_repo/"
      }
    }
  }'
```

### Проверить версию на проде
```bash
curl -s "https://your_username.github.io/your_repo/version.json?t=$(date +%s)"
```

## Troubleshooting

### Если на проде старая версия
1. Проверить что изменения закоммичены: `git status`
2. Проверить что запушено в main: `git push origin main`
3. Проверить GitHub Actions: `gh run list --limit 3`
4. Подождать 3-4 минуты пока GitHub Pages обновится
5. Проверить версию с cache bypass: `curl -s "https://your_username.github.io/your_repo/version.json?t=$(date +%s)"`

### Если Vercel требует логин
Используй Netlify или GitHub Pages - там уже залогинены.

### Если нужно быстро задеплоить без ожидания Actions
НЕТ - GitHub Actions быстрее всего. Netlify и Vercel требуют интерактивного логина.

---

## Как использовать этот файл

1. Скопируй этот файл в `KEYS_AND_TOKENS.md`
2. Замени все плейсхолдеры на реальные значения
3. `KEYS_AND_TOKENS.md` автоматически игнорируется Git
