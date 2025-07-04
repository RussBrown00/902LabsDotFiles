-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- BUFFERS
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- TABS
map("n", "<C-h>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
