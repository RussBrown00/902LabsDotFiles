require "nvchad.mappings"

local map = vim.keymap.set
map("i", "<ESC>", "<ESC><ESC>", { desc = "Double Escape" })
map("i", "jj", "<ESC><ESC>", { desc = "Escape" })
map("i", "jk", "<ESC><ESC>", { desc = "Escape" })

-- General mappings: Normal mode
map("n", "<leader>cc", "<cmd>TComment<CR>", { desc = "Comment line" })
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>fu", "<cmd>Telescope resume<CR>", { desc = "Resume" })
map("n", "<leader>fh", "<cmd>Telescope search_history<CR>", { desc = "Telescope Search History" })
map("n", "<leader>fm", "<cmd>Format<CR>", { desc = "Run Conformer" })
map("n", "<leader><space>", "<cmd>noh<CR>", { desc = "Clear search" })
map("n", "<leader>n", "<cmd>tabnew<CR>", { desc = "Create new tab" })
map("n", "<leader>s", "<cmd>split<CR>", { desc = "Create h-split" })
map("n", "<leader>v", "<cmd>vsplit<CR>", { desc = "Create v-split" })
map("n", "<C-h>", "<cmd>tabprevious<CR>", { desc = "Navigate to previous tab" })
map("n", "<C-l>", "<cmd>tabnext<CR>", { desc = "Navigate to next tab" })
map("n", "<leader>fr", '<cmd>let @+=expand("%")<CR>', { desc = "Copy relative path" })
map("n", "<leader>fp", '<cmd>let @+=expand("%:p")<CR>', { desc = "Copy full path" })
map("n", "<leader>fn", '<cmd>let @+=expand("%:t")<CR>', { desc = "Copy file name" })

-- Error / Linting Navigation
map("n", "<leader><C-d>", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Goto Next Diagnostic" })
map("n", "<leader><C-u>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Goto Prev Diagnostic" })

-- Terminal mappings (requires defining functions if used)
map("t", "<leader>tf", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "Toggle floating term" })
map("t", "<leader>th", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "Toggle horizontal term" })
map("t", "<leader>tv", function()
  require("nvterm.terminal").toggle "vertical"
end, { desc = "Toggle vertical term" })

map("n", "<leader>tt", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

-- Visual and Select Mode Mappings
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Don't copy replaced text", silent = true, noremap = true })
map("v", "<leader>S", "<cmd>sort u<CR>", { desc = "Unique sort selected lines" })

-- Save session
vim.keymap.set("n", "<leader>ss", function()
  local cwd = vim.fn.getcwd()
  local escaped = cwd:gsub("/", "%%"):gsub(":", "%%3A")
  local session_file = string.format("%s/.tmp/session_%s.vim", vim.env.HOME, escaped)
  vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
  print("Session saved to: " .. session_file)
end, { desc = "Save session for current pwd" })

-- Load session
vim.keymap.set("n", "<leader>ls", function()
  local cwd = vim.fn.getcwd()
  local escaped = cwd:gsub("/", "%%"):gsub(":", "%%3A")
  local session_file = string.format("%s/.tmp/session_%s.vim", vim.env.HOME, escaped)
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd("source " .. vim.fn.fnameescape(session_file))
    print("Session loaded from: " .. session_file)
  else
    print "No session found for current directory."
  end
end, { desc = "Load session for current pwd" })
map("n", "<leader>al", function()
  vim.g.sidekick_layout = vim.g.sidekick_layout == "float" and "right" or "float"
  print("Sidekick layout: " .. vim.g.sidekick_layout)
end, { desc = "Toggle Sidekick Layout" })
