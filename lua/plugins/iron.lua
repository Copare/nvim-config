local iron = require("iron.core")

iron.setup {
  config = {
    -- Удалять REPL при закрытии (true) или сохранять в фоне (false)
    scratch_repl = true,
    
    -- Настройки REPL для разных языков программирования
    repl_definition = {
      sh = {
        -- Команда для запуска shell REPL
        command = {"zsh"}
      },
      python = {
        -- Команда для запуска Python REPL
        command = { "python" },
      }
      -- Можно добавить другие языки по аналогии
    },

    -- Настройка отображения окна REPL (60% ширины справа)
    repl_open_cmd = require("iron.view").right(60),
  },
  
  -- Настройка клавиатурных сокращений
  keymaps = {
    send_motion = "<space>dc", -- Отправить движение в REPL
    visual_send = "<space>dc", -- Отправить выделение в REPL
    send_file = "<space>df",   -- Отправить весь файл в REPL
    send_line = "<space>dl",   -- Отправить текущую строку
    send_mark = "<space>dm",   -- Отправить помеченный код
    mark_motion = "<space>dmc",-- Пометить область для отправки
    mark_visual = "<space>dmc",-- Пометить визуальное выделение
    remove_mark = "<space>dmd",-- Удалить метку
    cr = "<space>d<cr>",       -- Новая строка в REPL
    interrupt = "<space>d<space>", -- Прервать выполнение
    exit = "<space>dq",        -- Выйти из REPL
    clear = "<space>dx",       -- Очистить вывод REPL
  },
  
  -- Стиль подсветки (курсив)
  highlight = {
    italic = true
  },
  
  -- Игнорировать пустые строки при отправке кода
  ignore_blank_lines = true,
}

-- Дополнительные клавиатурные сокращения
vim.keymap.set("n", "<space>ds", "<cmd>IronRepl<cr>")  -- Открыть/закрыть REPL
vim.keymap.set("n", "<space>dr", "<cmd>IronRestart<cr>") -- Перезапустить REPL
vim.keymap.set("n", "<space>dF", "<cmd>IronFocus<cr>") -- Перейти в окно REPL
vim.keymap.set("n", "<space>dh", "<cmd>IronHide<cr>")  -- Скрыть окно REPL
