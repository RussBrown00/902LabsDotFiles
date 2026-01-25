-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

-- Function to detect macOS appearance
local function get_system_theme()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  if result:match("Dark") then
    return "palenight"  -- Dark theme
  else
    return "one_light"       -- Light theme
  end
end

local system_theme = get_system_theme()

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
    theme_toggle = { "palenight", "one_light" },
    theme = system_theme,
  },
  base46 = {
    theme = system_theme,
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
