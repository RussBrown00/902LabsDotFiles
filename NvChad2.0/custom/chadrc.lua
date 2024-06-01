-- Just an example, supposed to be placed in /lua/custom/

local M = {}

M.mappings = require("custom.mappings")

-- local plugin_overrides = require("custom.plugins.override")

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
--

M.plugins = "custom.plugins"

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
  theme_toggle = { "doomchad", "one_light" },
  theme = "one_light", -- default theme
}

-- dark themes we like
-- one_light

-- dark themes we like
-- chadracula
-- bearded-arc
-- doomchad
-- tomorrow_night
-- 
-- 

M.mappings = require "custom.mappings"

return M
