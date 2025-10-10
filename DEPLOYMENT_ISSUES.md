# 🐛 Решённые Проблемы Деплоя

## Проблема #1: На проде версия 1.0.0 вместо 1.0.11

### Дата: 2025-10-10

### Симптомы
- Локально `build/web/version.json` показывает 1.0.11
- На https://myceliummmm-sketch.github.io/mycelium-app/version.json показывает 1.0.0
- `git subtree push` выполнился успешно, но старая версия

### Причина
Изменения версии 1.0.11 **не были закоммичены в main**. Git subtree отправил старый коммит в gh-pages.

### Решение
```bash
# 1. Закоммитить все изменения в main
git add -A
git commit -m "v1.0.11 - описание"

# 2. Запушить в main (автоматически триггерит GitHub Actions)
git push origin main

# 3. GitHub Actions соберёт и задеплоит автоматически
gh run list --limit 1  # проверить статус
```

### Урок
**ВСЕГДА** сначала коммитить в main, потом пушить. GitHub Actions сделает всё остальное.

---

## Проблема #2: Vercel требует интерактивный логин

### Дата: 2025-10-10

### Симптомы
```
npx vercel --prod
Error: The specified token is not valid. Use `vercel login` to generate a new token.
```

### Попытки решения
- `vercel login` требует открыть браузер - не работает в CLI автоматически
- Токена Vercel нет в файлах проекта

### Решение
Использовать **GitHub Pages** вместо Vercel:
- Уже настроен автоматический деплой через `.github/workflows/deploy.yml`
- Деплоится за 3-4 минуты
- Не требует интерактивного логина

### Урок
Для Flutter Web лучше использовать GitHub Pages - проще и быстрее.

---

## Проблема #3: Netlify требует интерактивный выбор проекта

### Дата: 2025-10-10

### Симптомы
```
netlify deploy --prod --dir=build/web
? What would you like to do?
  ⇄  Link this directory to an existing project
  +  Create & configure a new project
```

### Попытки решения
- `netlify init --manual` требует интерактивного выбора
- `pkill -f netlify` не помогает - процесс продолжает запрашивать ввод

### Решение
Использовать **GitHub Pages** - автоматический деплой без вопросов.

### Урок
Netlify хорош для drag-and-drop, но для автоматизации лучше GitHub Actions.

---

## Проблема #4: git subtree push заливает весь проект вместо build/web

### Дата: 2025-10-10

### Симптомы
В gh-pages попали файлы:
- `.dart_tool/`
- `android/`
- `ios/`
- `lib/`
- `server/`

Вместо только:
- `index.html`
- `main.dart.js`
- `assets/`
- и т.д.

### Причина
Использовал `git checkout --orphan gh-pages-new` и скопировал `build/web/*` **в текущую директорию**, где уже был весь проект.

### Решение
Не использовать ручной push в gh-pages. GitHub Actions делает это правильно через workflow:
```yaml
- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./build/web
```

### Урок
Доверять автоматизации. GitHub Actions правильно публикует только `build/web`.

---

## Проблема #5: Неправильный tap detection в Life Wheel

### Дата: 2025-10-10

### Симптомы
Клик на сектор "Здоровье" открывает модалку сферы "Карьера"

### Причина
Расчёт угла в `_handleTap()` не совпадал с расчётом в `_drawAxis()`:
- Drawing использует: `angle = -π/2 + i * angleStep`
- Tap detection использовал: `angle = angle + π/2`

### Решение
```dart
// Было:
angle += math.pi / 2;

// Стало:
angle = angle - (-math.pi / 2);  // Совпадает с drawing логикой
```

### Урок
Координатные системы должны совпадать между drawing и hit detection.

---

## Проблема #6: P2P текст обрезается кнопками

### Дата: 2025-10-10

### Симптомы
Длинный `question` или `description` уходит за кнопки "ДА" / "НЕТ"

### Причина
Не было ограничения на количество строк и overflow handling

### Решение
```dart
Text(
  scenario.question,
  maxLines: 3,  // Добавлено
  overflow: TextOverflow.ellipsis,  // Добавлено
)
```

Также уменьшены размеры шрифтов и padding.

### Урок
Всегда добавлять `maxLines` и `overflow` для динамического контента.

---

## Шаблон для новых проблем

```markdown
## Проблема #X: Название проблемы

### Дата: YYYY-MM-DD

### Симптомы
- Что происходит?
- Какая ошибка?

### Причина
Почему это происходит?

### Решение
```bash
# Команды или код
```

### Урок
Что запомнить на будущее?
```
