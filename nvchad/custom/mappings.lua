local M = {}

M.general = {
   i = {
     ["jj"] = { "<ESC>" },
   },
   n = {
     ["<C-p>"] = { "<cmd>Telescope find_files<CR>", "find files" },
     ["<Leader><C-f>"] = { "<cmd>Neoformat<CR>" },
     ["<Leader><space>"] = { "<cmd>noh<CR>" },
     ["<Leader>S"] = { "<cmd>sort u<CR>" },
     ["<Leader>fm"] = { "<cmd>NeoFormat<CR>" },
     ["<Leader>n"] = { "<cmd>tabnew<CR>", "Create new tab" },
     ["<Leader>s"] = { "<cmd>split<CR>", "Create h-split" },
     ["<Leader>v"] = { "<cmd>vsplit<CR>", "Create v-split" },
     ["C-h"] = { "<cmd>tabprevious<CR>" },
     ["C-l"] = { "<cmd>tabnext<CR>" },
     ["Q"] = { "<cmd>q! <CR>", opts = { silent = true } },
   },
   v = {
     ["<"] = { '<gv'},
     [">"] = { ">gv"}
   },
}

return M
