local g = vim.g
local opt = vim.opt -- autocmds
local autocmd = vim.api.nvim_create_autocmd

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

vim.g.mapleader = ","
-- vim.g.neoformat_try_node_exe = 1

opt.swapfile = false
opt.spellfile = "~/.vim/spell/en.utf-8.add"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

require("neogit").setup {
  integrations = {
    diffview = true,
  },
  process_spinner = true,
  floating = {
    relative = "editor",
    width = 0.8,
    height = 0.7,
    style = "minimal",
    border = "rounded",
  },
}

local options = {
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    lua = { "stylua" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

vim.opt.completeopt = { "menu", "popup", "noselect" }

-- Auto-reload theme based on macOS appearance
local timer = vim.loop.new_timer()
timer:start(0, 5000, vim.schedule_wrap(function()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  local new_theme = result:match("Dark") and "tomorrow_night" or "one_light"
  local chadrc = require("chadrc")
  local current_theme = chadrc.base46.theme
  if new_theme ~= current_theme then
    require("nvchad.themes.utils").reload_theme(new_theme)
    -- Update in-memory chadrc
    chadrc.base46.theme = new_theme
    chadrc.ui.theme = new_theme
  end
end))
