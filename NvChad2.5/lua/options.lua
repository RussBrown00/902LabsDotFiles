require "nvchad.options"

local opt = vim.opt
local o = vim.o
-- local g = vim.g

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local tabs_config = function()
  -- print("Loading JS File tab preferences (tabs)")
  o.shiftwidth = 2
  o.tabstop = 2
  o.expandtab = false
  o.smartindent = true
  o.autoindent = true
end

local spaces_config = function()
  -- print("Loading JS File tab preferences (spaces)")
  opt.shiftwidth = 2
  opt.tabstop = 2
  opt.expandtab = true
  opt.smartindent = true
  opt.autoindent = true
end

local load_tab_prefs = function()
  local buf_name = vim.api.nvim_buf_get_name(0)

  if string.find(buf_name, "/photivo/") then
    tabs_config()
  else
    spaces_config()
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "vue", "javascriptreact" },
  callback = load_tab_prefs,
})

-- function reload_config()
--   require("lazy").setup "~/.config/nvim/init.lua"
--   -- dofile(vim.env.MYVIMRC) -- MYVIMRC should point to your init.lua file
-- end
--
-- vim.api.nvim_create_user_command("ReloadConfig", reload_config, { desc = "Reload Neovim configuration" })
