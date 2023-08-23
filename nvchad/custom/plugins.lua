local plugin_overrides = require("custom.configs.overrides")

local edit_events =
  { "TextChanged", "TextChangedI", "BufEnter", "BufWinEnter", "BufLeave", "InsertEnter", "InsertChange", "InsertLeave" }

--@type NvPluginSpec[]
local plugins = {
  {
    "klen/nvim-config-local",
    config = function()
    require('config-local').setup {
      config_files = { ".nvim.lua", ".nvimrc" },

      -- Where the plugin keeps files data
      hashfile = vim.fn.stdpath("data") .. "/config-local",

      autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
      commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
      silent = false,             -- Disable plugin messages (Config loaded/ignored)
      lookup_parents = true,     -- Lookup config files in parent directories
    }
    end
  },
  { "puremourning/vimspector" },
  { "sbdchd/neoformat" },
  { "neovim/nvim-lspconfig" },
  {
    "neovim/nvim-lspconfig",
    event = edit_events,
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "codota/tabnine-nvim",
    event = edit_events,
    -- lazy = false,
    config = function()
      require("tabnine").setup {
        -- disable_auto_comment = true,
        accept_keymap = "<C-q>",
        sort = true;
        run_on_every_keystroke = true;
        dismiss_keymap = "<Esc>",
        debounce_ms = 800,
        suggestion_color = { gui = "#872657", cterm = 5 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
        -- log_file_path = "/tmp/tabnine.log"
      }
    end,
    build = "./dl_binaries.sh",
    run = "./dl_binaries.sh",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    after = "telescope.nvim",
    run = "make",
    config = function()
      require "custom.configs.fzf"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = plugin_overrides.treesitter,
  },
  {
    "williamboman/mason.nvim",
    opts = plugin_overrides.mason,
  },
  { "direnv/direnv.vim" },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvim_lsp" },
        { name = "cmp_tabnine" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
    }
  },
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
