-- Настройка плагина для работы с TODO-комментариями
require("todo-comments").setup{
  -- Показывать иконки на полях (вместе с номерами строк)
  signs = true,
  -- Приоритет значков (влияет на порядок отображения относительно других плагинов)
  sign_priority = 8,

  -- Список ключевых слов для поиска
  keywords = {
    -- FIX-комментарии
    FIX = {
      icon = " ",         -- Иконка для метки
      color = "error",     -- Цвет подсветки (можно использовать hex-код)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Альтернативные названия тега
    },
    -- TODO-комментарии
    TODO = { 
      icon = " ", 
      color = "info" 
    },
    -- HACK-комментарии
    HACK = { 
      icon = " ", 
      color = "warning" 
    },
    -- WARN-комментарии
    WARN = { 
      icon = " ", 
      color = "warning", 
      alt = { "WARNING", "XXX" } 
    },
    -- PERF-комментарии (оптимизация)
    PERF = { 
      icon = " ", 
      alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } 
    },
    -- NOTE-комментарии
    NOTE = { 
      icon = " ", 
      color = "hint", 
      alt = { "INFO" } 
    },
  },

  -- Объединять пользовательские ключевые слова со стандартными
  merge_keywords = true,

  -- Настройки подсветки
  highlight = {
    before = "",       -- Подсветка перед ключевым словом (пусто = отключено)
    keyword = "wide",  -- Подсветка самого ключевого слова (wide = с фоном)
    after = "fg",      -- Подсветка текста после ключевого слова
    -- Шаблон для поиска (KEYWORDS будет заменено на список ключевых слов)
    pattern = [[.*<(KEYWORDS)\s*:]],
    -- Искать только в комментариях (использует treesitter)
    comments_only = true,
    -- Игнорировать строки длиннее 400 символов
    max_line_len = 400,
    -- Исключить определенные типы файлов
    exclude = {},
  },

  -- Цвета для разных типов комментариев
  colors = {
    error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },    -- Красный
    warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" }, -- Желтый
    info = { "LspDiagnosticsDefaultInformation", "#2563EB" },           -- Синий
    hint = { "LspDiagnosticsDefaultHint", "#10B981" },                  -- Зеленый
    default = { "Identifier", "#7C3AED" },                              -- Фиолетовый
  },

  -- Настройки поиска TODO-комментариев
  search = {
    command = "rg",    -- Использовать ripgrep для поиска
    args = {           -- Аргументы для ripgrep
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- Регулярное выражение для поиска (KEYWORDS будет заменено)
    pattern = [[\b(KEYWORDS):]],
  },
}
