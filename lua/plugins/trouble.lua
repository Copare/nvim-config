require("trouble").setup {
  position = "bottom", -- Положение окна (bottom, top, left, right)
  height = 10, -- Высота окна для позиций top/bottom
  width = 50, -- Ширина окна для позиций left/right
  -- icons = true, -- Показывать иконки файлов (требует nvim-web-devicons)
  mode = "workspace_diagnostics", -- Режим по умолчанию. Другие варианты: 
                                  -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", 
                                  -- "quickfix", "lsp_references", "loclist"
  fold_open = "", -- Иконка открытой группы (Unicode)
  fold_closed = "", -- Иконка закрытой группы (Unicode)
  group = true, -- Группировать результаты по файлам
  padding = true, -- Добавлять пустую строку вверху списка
  action_keys = { -- Настройка клавиш для управления
    close = "q", -- Закрыть окно Trouble
    cancel = "<esc>", -- Отмена действия/возврат
    refresh = "r", -- Обновить список
    jump = {"<cr>", "<tab>"}, -- Перейти к элементу или свернуть/развернуть группу
    open_split = { "<c-x>" }, -- Открыть в горизонтальном разделении
    open_vsplit = { "<c-v>" }, -- Открыть в вертикальном разделении
    open_tab = { "<c-t>" }, -- Открыть в новой вкладке
    jump_close = {"o"}, -- Перейти к элементу и закрыть Trouble
    toggle_mode = "m", -- Переключить режим (например, workspace/document)
    toggle_preview = "P", -- Переключить предпросмотр
    hover = "K", -- Показать полное сообщение диагностики
    preview = "p", -- Предпросмотр местоположения
    close_folds = {"zM", "zm"}, -- Закрыть все группы
    open_folds = {"zR", "zr"}, -- Открыть все группы
    toggle_fold = {"zA", "za"}, -- Переключить текущую группу
    previous = "k", -- Перейти к предыдущему элементу
    next = "j" -- Перейти к следующему элементу
  },
  indent_lines = true, -- Показывать линии отступа под иконками групп
  auto_open = false, -- Автоматически открывать при наличии диагностик
  auto_close = false, -- Автоматически закрывать при отсутствии диагностик
  auto_preview = true, -- Автоматически показывать предпросмотр (Esc для закрытия)
  auto_fold = false, -- Автоматически сворачивать группы при создании
  auto_jump = {"lsp_definitions"}, -- Автопереход если результат единственный
  icons = { -- Иконки для типов диагностик
    error = "",
    warning = "",
    hint = "󰋗",
    information = "",
    other = ""
  },
  use_lsp_diagnostic_signs = false -- Использовать знаки диагностики из LSP (false = использовать кастомные выше)
}
