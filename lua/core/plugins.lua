local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'neovim/nvim-lspconfig' },
		
	-- **Автодополнение (CMP)**
	  {
		"hrsh7th/nvim-cmp",
		version = false, -- Использует последний коммит
		event = "InsertEnter",
		dependencies = {
		  "hrsh7th/cmp-nvim-lsp",
		  "hrsh7th/cmp-buffer",
		  "hrsh7th/cmp-path",
		  "hrsh7th/cmp-cmdline",
		  "hrsh7th/cmp-vsnip",    -- Исправлено: было 'cmp-vsnip' -> 'cMP-vsnip'
		  "hrsh7th/vim-vsnip",
		},
	  }, -- Закрывающая скобка для nvim-cmp

	  -- { 'SirVer/ultisnips' },
	  -- { 'quangnguyen30192/cmp-nvim-ultisnips' }, 
	
	
	{ 'williamboman/mason.nvim' },
	
	{
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
          dependencies = { 'nvim-lua/plenary.nvim' }
    },
    
	{
	  'nvimdev/dashboard-nvim',
	  event = 'VimEnter',		
	  config = function()
		require('dashboard').setup {
		  -- config
		}
	  end,
	  dependencies = { {'nvim-tree/nvim-web-devicons'}}
	},
	
	{ 'Eandrju/cellular-automaton.nvim' },
	{ 'norcalli/nvim-colorizer.lua' },
	
	
	{
	    'nvim-lualine/lualine.nvim',
	    dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	
	{
	  "folke/todo-comments.nvim",
	  dependencies = { "nvim-lua/plenary.nvim" },
	  opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
	  }
	},
	
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true,},
	  {
	    "catppuccin/nvim",
	    name = "catppuccin",
	    priority = 1000,
	    config = function()
	      require("catppuccin").setup({
		flavour = "mocha", -- mocha, macchiato, frappe или latte
		transparent_background = false,
		--[[integrations = {
		  telescope = true,
		  mason = true,
		  which_key = true,
		}
		--]]
	      })
	    end
	  },
	  
--[[	{
	  "max397574/better-escape.nvim",
	  config = function()
  	    require("better_escape").setup({
  	    	mapping = {"jk"},
  	    	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    	    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    	    keys = "<Esc>",
  	    })
  	  end
	},
	--]]
	{
	  "max397574/better-escape.nvim",
	  config = function()
		require("better_escape").setup()
	  end,
	},
	
	{
		'numToStr/Comment.nvim',
		opts = {
		    -- add any options here
		}
	},
	
	{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
	
	{
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  lazy = false,
	  dependencies = {
	    "nvim-tree/nvim-web-devicons",
	  },
	  config = function()
	    require("nvim-tree").setup {}
	  end,
	},
	
	{
	    'dense-analysis/ale',
	    config = function()
	        -- Configuration goes here.
	        local g = vim.g
	
	        g.ale_linters = {
	        	python = {'mypy'},
	            lua = {'lua_language_server'}
	        }
	    end
	},
	
	{ 'RRethy/vim-illuminate' },
	
	{
	    "vhyrro/luarocks.nvim",
	    priority = 1001, -- this plugin needs to run before anything else
	    opts = {
	        rocks = { "magick" },
	    },
	},
	
	{
	 "folke/trouble.nvim",
	 dependencies = { "nvim-tree/nvim-web-devicons" },
	 opts = {
	  -- your configuration comes here
	  -- or leave it empty to use the default settings
	  -- refer to the configuration section below
	 },
	},
	
	{'akinsho/toggleterm.nvim', version = "*", config = true},
	
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  init = function()
	    vim.o.timeout = true
	    vim.o.timeoutlen = 300
	  end,
	  opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
	  }
	},
	
	-- Выравнивание и перемещение текста
	-- Автоматическое открытие фигурных скобок, кавычек и т.д
	{ 'echasnovski/mini.nvim', version = false },
	{ 'echasnovski/mini.move', version = false },
	{ 'echasnovski/mini.pairs', version = false },  
	
	
	-- python
	{ 'hkupty/iron.nvim', },
  -- Здесь можно добавлять другие плагины
})
