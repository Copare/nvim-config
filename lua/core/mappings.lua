-- Устанавливаем клавишу-лидер (пробел)
vim.g.mapleader = " "

-- Выход из Neovim
-- Нажать: Ctrl + q
vim.keymap.set('n', '<C-q>', '<cmd>:q<CR>', { desc = "Закрыть Neovim" })

-- Копировать весь текст буфера
-- Нажать: Ctrl + a
vim.keymap.set('n', '<C-a>', '<cmd>%y+<CR>', { desc = "Скопировать весь текст" })

-- Сохранить файл
-- В режиме вставки: Ctrl + s
-- В обычном режиме: Ctrl + s
vim.keymap.set('i', '<C-s>', '<cmd>:w<CR>', { desc = "Сохранить файл (из режима вставки)" })
vim.keymap.set('n', '<C-s>', '<cmd>:w<CR>', { desc = "Сохранить файл" })

-- Normal/Visual режимы:
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y') -- Копирование в системный буфер
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p') -- Вставка из системного буфера

-- Файловый менеджер NvimTree
-- Нажать: Пробел + t
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = "Показать/скрыть файловое дерево" })
-- Нажать: Пробел + t + f
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>', { desc = "Фокусировка на файловом дереве" })

-- Управление вкладками BufferLine
-- Переключить следующую вкладку: Tab
vim.keymap.set('n','<Tab>', ':BufferLineCycleNext<CR>', { desc = "Следующая вкладка" })
-- Переключить предыдущую вкладку: Shift + Tab
vim.keymap.set('n','<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Предыдущая вкладка" })
-- Закрыть другие вкладки: Ctrl + l
vim.keymap.set('n', '<C-l>', ':BufferLineCloseOthers<CR>', { desc = "Закрыть другие вкладки" })

-- Поиск задач (TODO, FIXME и т.д.)
-- Нажать: Пробел + n + l
vim.keymap.set('n', '<leader>nl', ':TodoTelescope<CR>', { desc = "Найти задачи (TODOs)" })

-- Плавающий терминал
-- Нажать: Пробел + s
vim.keymap.set('n', '<leader>s', ':ToggleTerm direction=float<CR>', { desc = "Открыть плавающий терминал" })
