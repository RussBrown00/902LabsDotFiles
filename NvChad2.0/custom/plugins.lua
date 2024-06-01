local plugin_overrides = require("custom.configs.overrides")

local edit_events = {
	"TextChanged",
	"TextChangedI",
	"BufEnter",
	"BufWinEnter",
	"BufLeave",
	"InsertEnter",
	"InsertChange",
	"InsertLeave",
}

--@type NvPluginSpec[]
local plugins = {
	{
		"klen/nvim-config-local",
		"lambdalisue/vim-pyenv",
		config = function()
			require("config-local").setup({
				config_files = { ".nvim.lua", ".nvimrc" },

				-- Where the plugin keeps files data
				hashfile = vim.fn.stdpath("data") .. "/config-local",

				autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
				commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
				silent = false, -- Disable plugin messages (Config loaded/ignored)
				lookup_parents = true, -- Lookup config files in parent directories
			})
		end,
	},
	{ "puremourning/vimspector" },
	{
		"sbdchd/neoformat",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("custom.configs.neoformat")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = edit_events,
		dependencies = {
			-- format & linting
			-- {
			--   "mfussenegger/nvim-lint",
			--   event = "VeryLazy",
			--   config = function()
			--     require "custom.configs.lint"
			--   end,
			-- },
			-- {
			-- 	"stevearc/conform.nvim",
			-- 	event = "BufWritePre",
			-- 	keys = {
			-- 		{
			-- 			-- Customize or remove this keymap to your liking
			-- 			"<leader>fm",
			-- 			function()
			-- 				require("conform").format({ async = true, lsp_fallback = true })
			-- 			end,
			-- 			mode = "",
			-- 			desc = "Format buffer",
			-- 		},
			-- 	},
			-- 	config = function()
			-- 		require("custom.configs.conform")
			-- 	end,
			-- },
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{
		"wsdjeg/vim-todo",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- { "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"heavenshell/vim-jsdoc",
		-- for = {'javascript', 'javascript.jsx', 'typescript'},
		ft = "javascript javascript.jsx typescript",
		build = "make clean; make install",
		run = "make install",
	},
	{
		"codota/tabnine-nvim",
		event = edit_events,
		-- lazy = false,
		config = function()
			require("custom.configs.tabnine")
		end,
		build = "./dl_binaries.sh",
		run = "./dl_binaries.sh",
	},
	-- {
	--   "nvim-telescope/telescope-fzf-native.nvim",
	--   after = "telescope.nvim",
	--   run = "make",
	--   config = function()
	--     require "custom.configs.fzf"
	--   end,
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = plugin_overrides.treesitter,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = plugin_overrides.nvimtree,
	},
	{
		"williamboman/mason.nvim",
		opts = plugin_overrides.mason,
	},
	{ "direnv/direnv.vim" },
	{ "ray-x/go.nvim" },
}

return plugins

-- return {
--   ["tzachar/cmp-tabnine"] = {
--     after = "cmp-path",
--     config = function()
--        require "custom.plugins.tabnine"
--     end,
--     run='./install.sh',
--   },
-- }
