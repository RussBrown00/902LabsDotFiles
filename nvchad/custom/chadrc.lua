-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.options = {
   clipboard = "unnamedplus",
   cmdheight = 1,
   copy_cut = true, -- copy cut text ( x key ), visual and normal mode
   copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
   expandtab = true,
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
M.plugins = {
  user = require "custom.plugins"
}

return M
