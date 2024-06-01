-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {
  options = {
    clipboard = "unnamedplus",
    cmdheight = 1,
    copy_cut = true, -- copy cut text ( x key ), visual and normal mode
    copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
    hidden = true,
    ignorecase = true,
    insert_nav = true, -- navigation in insertmode
    mapleader = ",",
  },
  ui = {
    theme_toggle = { "tomorrow_night", "one_light" },
    theme = "one_light", -- default theme
  },
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

return M