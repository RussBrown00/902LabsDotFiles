local plugin_overrides = require("custom.configs.overrides")

local edit_events =
  { "TextChanged", "TextChangedI", "BufEnter", "BufWinEnter", "BufLeave", "InsertEnter", "InsertChange", "InsertLeave" }

--@type NvPluginSpec[]
local plugins = {
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
        -- accept_keymap = "<Right>",
        sort = true;
        run_on_every_keystroke = true;
        dismiss_keymap = "<Esc>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
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
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = {
  --     sources = {
  --       { name = "nvim_lsp" },
  --       { name = "cmp_tabnine" },
  --       { name = "luasnip" },
  --       { name = "buffer" },
  --       { name = "nvim_lua" },
  --       { name = "path" },
  --     },
  --   }
  -- },
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
