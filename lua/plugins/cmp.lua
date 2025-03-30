local cmp = require 'cmp'

-- Основная настройка автодополнения
cmp.setup({
    snippet = {
        -- Здесь подключается движок сниппетов (раскомментируйте нужный)
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- Для пользователей vsnip
            -- require('luasnip').lsp_expand(args.body) -- Для пользователей luasnip
            -- require('snippy').expand_snippet(args.body) -- Для пользователей snippy
            -- vim.fn["UltiSnips#Anon"](args.body) -- Для пользователей ultisnips
        end
    },
    window = {
        completion = cmp.config.window.bordered(), -- Окно автодополнения с рамкой
        documentation = cmp.config.window.bordered() -- Окно документации с рамкой
    },
    mapping = cmp.mapping.preset.insert({
        -- Горячие клавиши для управления автодополнением
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Прокрутка документации вверх
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Прокрутка документации вниз
        ['<C-Space>'] = cmp.mapping.complete(), -- Открыть меню автодополнения
        ['<C-e>'] = cmp.mapping.abort(), -- Закрыть меню автодополнения
        ['<CR>'] = cmp.mapping.confirm({select = true}), -- Подтвердить выбор (с автоматическим выбором первого варианта)
        
        -- Улучшенная навигация по списку
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item() -- Перейти к следующему элементу
            else
                fallback() -- Обычное поведение Tab
            end
        end, {"i", "s"}), -- Работает в режимах Insert и Select
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item() -- Перейти к предыдущему элементу
            else
                fallback() -- Обычное поведение Shift+Tab
            end
        end, {"i", "s"})
    }),
    sources = cmp.config.sources({
        -- Источники автодополнения с высоким приоритетом
        {name = 'nvim_lsp'}, -- Данные от LSP-серверов
        {name = 'vsnip'} -- Сниппеты (требует установки плагина vsnip)
    }, {
        -- Источники с низким приоритетом
        {name = 'buffer'}, -- Слова из текущего файла
        {name = 'nvim_lsp_signature_help'} -- Помощь с сигнатурами функций
    })
})

-- Специальные настройки для git-коммитов
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        {name = 'cmp_git'} -- Git-специфичные подсказки (требует установки cmp-git)
    }, {
        {name = 'buffer'} -- Стандартные подсказки из буфера
    })
})

-- Настройки для поиска по тексту (/ и ?)
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(), -- Стандартные мэппинги
    sources = {{name = 'buffer'}} -- Используем только буфер
})

-- Настройки для командной строки (:)
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {{name = 'path'}}, -- Подсказки путей
        {{name = 'cmdline'}} -- Подсказки команд
    )
})

-- Интеграция с LSP-серверами
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['ts_ls'].setup {
    capabilities = capabilities -- Передаем возможности автодополнения в LSP
}
