-- Подключение плагина lualine для кастомной статусной строки
local lualine = require('lualine')

-- Палитра цветов для оформления
-- stylua: ignore (отключение форматирования для этой секции)
local colors = {
  bg       = '#202328',     -- фон статусной строки
  fg       = '#bbc2cf',     -- основной цвет текста
  yellow   = '#ECBE7B',     -- желтый для предупреждений
  cyan     = '#008080',     -- бирюзовый для информации
  darkblue = '#081633',     -- темно-синий фон
  green    = '#98be65',     -- зеленый для успешных операций
  orange   = '#FF8800',     -- оранжевый для модификаций
  violet   = '#a9a1e1',     -- фиолетовый для веток Git
  magenta  = '#c678dd',     -- пурпурный для LSP
  blue     = '#51afef',     -- синий акцентный
  red      = '#ec5f67',     -- красный для ошибок
}

-- Условия для отображения компонентов
local conditions = {
  -- Проверка что буфер не пустой
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  
  -- Проверка ширины окна (скрывать компоненты в узких окнах)
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  
  -- Проверка что мы в Git-репозитории
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Основная конфигурация lualine
local config = {
  options = {
    -- Настройка разделителей (пустые для минималистичного вида)
    component_separators = '',
    section_separators = '',
    
    -- Цветовая тема для разных состояний
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },    -- активное окно
      inactive = { c = { fg = colors.fg, bg = colors.bg } },  -- неактивное окно
    },
  },
  
  -- Секции для активного окна
  sections = {
    lualine_a = {}, -- левая секция (обычно режим редактора)
    lualine_b = {}, 
    lualine_y = {}, -- правая секция
    lualine_z = {},
    lualine_c = {}, -- центральная левая
    lualine_x = {}, -- центральная правая
  },
  
  -- Секции для неактивных окон
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {}, -- содержимое файла
    lualine_x = {}, -- техническая информация
  },
}

-- Вспомогательные функции для добавления компонентов
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Левая часть статусной строки --

-- Синий разделитель слева
ins_left {
  function() return '▊' end,
  color = { fg = colors.blue },
  padding = { left = 0, right = 1 },
}

-- Иконка текущего режима редактора
ins_left {
  function() return '' end, -- Иконка режима
  color = function()
    -- Автоматический цвет в зависимости от режима
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

-- Размер файла (только если файл не пустой)
ins_left {
  'filesize',
  cond = conditions.buffer_not_empty,
}

-- Имя файла с подсветкой
ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

-- Текущая позиция курсора
ins_left { 'location' }

-- Прогресс просмотра файла
ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

-- Диагностика (ошибки, предупреждения, информация)
ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Разделитель между левой и правой частями
ins_left {
  function() return '%=' end, -- Специальный символ для выравнивания
}

-- Информация о LSP-серверах
ins_left {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Правая часть статусной строки --

-- Кодировка файла (только при достаточной ширине)
ins_right {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

-- Формат файла (UNIX/Windows)
ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = 'bold' },
}

-- Ветка Git
ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

-- Изменения в Git
ins_right {
  'diff',
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

-- Синий разделитель справа
ins_right {
  function() return '▊' end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Инициализация плагина с нашей конфигурацией
lualine.setup(config)
