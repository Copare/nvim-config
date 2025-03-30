-- plugins/lsp.lua

-- Подключение модуля настройки LSP-серверов
local lspconfig = require('lspconfig')

-- Настройка Pyright (Python LSP-сервер)
lspconfig.pyright.setup {
	  on_attach = function(client)	
		client.server_capabilities.positionEncoding = "utf-8"		
	  end,
  settings = {
    pyright = {
      -- Отключаем встроенную организацию импортов (будем использовать Ruff)
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Игнорируем все файлы для анализа (полагаемся на Ruff для линтинга)
        ignore = { '*' },
      },
    },
  },  
}

-- Настройка TypeScript/JavaScript LSP-сервера (без дополнительных настроек)
lspconfig.ts_ls.setup({})

-- Настройка Rust Analyzer (Rust LSP-сервер)
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {}, -- Можно добавить специфичные для Rust настройки
  },
}

-- Настройка Ruff Linter (линтер для Python)
lspconfig.ruff.setup {
	  on_attach = function(client)
		client.server_capabilities.positionEncoding = "utf-8"
	  end,
  init_options = {
    settings = {
      args = {
        "--select=E,F,UP,N,I,ASYNC,S,PTH", -- Коды ошибок для проверки
        "--line-length=79", -- Максимальная длина строки
        "--respect-gitignore", -- Игнорировать файлы из .gitignore
        "--target-version=py311" -- Целевая версия Python
      },
    }
  }
}

-- Глобальные горячие клавиши для диагностики (работают во всех файлах)
-- Открыть плавающее окно с ошибкой под курсором
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

-- Переход к предыдущей ошибке
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)

-- Переход к следующей ошибке
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Автоматические действия при подключении LSP-сервера к буферу
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Включение автодополнения по <C-x><C-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Локальные горячие клавиши (только для текущего буфера)
    local opts = { buffer = ev.buf }
    
    -- [НАВИГАЦИЯ] --
    -- lD - Перейти к объявлению (Declaration)
    vim.keymap.set('n', 'lD', vim.lsp.buf.declaration, opts)
    
    -- ld - Перейти к определению (Definition)
    vim.keymap.set('n', 'ld', vim.lsp.buf.definition, opts)
    
    -- lk - Показать документацию (Hover)
    vim.keymap.set('n', 'lk', vim.lsp.buf.hover, opts)
    
    -- i - Перейти к реализации (Implementation)
    vim.keymap.set('n', 'i', vim.lsp.buf.implementation, opts)
    
    -- <Cntr+k> - Показать сигнатуру функции (Signature Help)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    
    -- [РЕФАКТОРИНГ] --
    -- <space>r - Быстрые исправления (Code Action)
    vim.keymap.set({ 'n', 'v' }, '<space>r', vim.lsp.buf.code_action, opts)
    
    -- gr - Поиск ссылок (References)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- <space>f - Форматирование кода (Format)
vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true } -- Асинхронное форматирование
    end, opts)
  end,
})

-- Комментарий к TODO: это временная настройка, планируется удаление
-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
