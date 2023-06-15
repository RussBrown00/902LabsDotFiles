-- Just an example, supposed to be placed in /lua/custom/

local M = {}

M.mappings = require("custom.mappings")

-- local plugin_overrides = require("custom.plugins.override")

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
--

M.plugins = require "custom.plugins"

-- M.plugins = {
--   user = require "custom.plugins",
--   override = {
--     ["nvim-treesitter/nvim-treesitter"] = plugin_overrides.treesitter,
--     ["williamboman/mason.nvim"] = plugin_overrides.mason,
--     ["hrsh7th/nvim-cmp"] = {
--       sources = {
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "buffer" },
--         { name = "nvim_lua" },
--         { name = "path" },
--         { name = "cmp-tabnine" },
--       },
--     },
--   },
-- }

M.nvimtree = {
   actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = false
      }
    }
   },
}

M.options = {
   clipboard = "unnamedplus",
   cmdheight = 1,
   copy_cut = true, -- copy cut text ( x key ), visual and normal mode
   copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
   hidden = true,
   ignorecase = true,
   insert_nav = true, -- navigation in insertmode
   mapleader = ",",
}

M.ui = {
  theme_toggle = { "chadracula", "one_light" },
  theme = "one_light", -- default theme
}

M.mappings = require "custom.mappings"

return M
