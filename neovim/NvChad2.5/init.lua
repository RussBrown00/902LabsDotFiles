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

-- require("tabnine").setup {
--   accept_keymap = "<S-RIGHT>",
--   codelens_color = { gui = "#808080", cterm = 244 },
--   codelens_enabled = true,
--   debounce_ms = 800,
--   disable_auto_comment = false,
--   dismiss_keymap = "<C-]>",
--   exclude_filetypes = { "TelescopePrompt", "NvimTree" },
--   log_file_path = nil,
--   suggestion_color = { gui = "#808080", cterm = 244 },
-- }

require("CopilotChat").setup {
  prompts = {
    JSDocs = {
      prompt = "> /COPILOT_GENERATE\n\nWrite JSDocs for the selected code. Objects should be broken out.",
    },
  },
  mappings = {
    reset = "<C-Bslash>",
  },
}

vim.opt.completeopt = { "menu", "popup", "noselect" }
