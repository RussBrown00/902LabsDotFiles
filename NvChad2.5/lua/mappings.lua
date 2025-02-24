require "nvchad.mappings"

local map = vim.keymap.set

-- General mappings: Insert mode
map("i", "<leader>cc", "<cmd>TComment<CR>", { desc = "Comment line" })
map("i", "<ESC>", "<ESC><ESC>", { desc = "Double Escape" })
map("i", "jj", "<ESC><ESC>", { desc = "Escape" })

-- Escape duplicated mapping of Tabnine Chat under insert mode for mapping clarification
map("i", "<leader>tq", "<cmd>TabnineChat<CR>", { desc = "Open Tabnine Chat" })

-- General mappings: Normal mode
map("n", "<leader>cc", "<cmd>TComment<CR>", { desc = "Comment line" })
map("n", "<leader>q", "<cmd>TabnineChat<CR>", { desc = "Open Tabnine Chat" })
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>fu", "<cmd>Telescope resume<CR>", { desc = "Resume" })
map("n", "<leader>fh", "<cmd>Telescope search_history<CR>", { desc = "Telescope Search History" })
map("n", "<leader>fm", "<cmd>Format<CR>", { desc = "Run Conformer" })
map("n", "<leader><space>", "<cmd>noh<CR>", { desc = "Clear search" })
map("n", "<leader><C-f>", "<cmd>Neoformat<CR>", { desc = "Run Neoformat on file" })
map("n", "<leader>n", "<cmd>tabnew<CR>", { desc = "Create new tab" })
map("n", "<leader>s", "<cmd>split<CR>", { desc = "Create h-split" })
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Create v-split" })
map("n", "<C-h>", "<cmd>tabprevious<CR>", { desc = "Navigate to previous tab" })
map("n", "<C-l>", "<cmd>tabnext<CR>", { desc = "Navigate to next tab" })
map("n", "<leader>fr", '<cmd>let @+=expand("%")<CR>', { desc = "Copy relative path" })
map("n", "<leader>fp", '<cmd>let @+=expand("%:p")<CR>', { desc = "Copy full path" })
map("n", "<leader>fn", '<cmd>let @+=expand("%:t")<CR>', { desc = "Copy file name" })
map("n", "<leader>rc", "<cmd>ReloadConfig<CR>", { noremap = true, silent = true, desc = "Reload configuration" })

-- Error / Linting Navigation
map("n", "<leader><C-d>", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Goto Next Diagnostic" })
map("n", "<leader><C-u>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Goto Prev Diagnostic" })

-- Terminal mappings (requires defining functions if used)
map("t", "<A-i>", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "Toggle floating term" })
map("t", "<A-h>", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "Toggle horizontal term" })
map("t", "<A-v>", function()
  require("nvterm.terminal").toggle "vertical"
end, { desc = "Toggle vertical term" })

-- Visual and Select Mode Mappings
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Don't copy replaced text", silent = true, noremap = true })
map("x", "<leader>q", function()
  require("tabnine.chat").open()
end, { desc = "Open Tabnine Chat" })
map("v", "<leader>S", "<cmd>sort u<CR>", { desc = "Unique sort selected lines" })
map("v", "<leader>qq", "<cmd>TabnineFix<CR>", { desc = "Run Tabnine Fix" })
