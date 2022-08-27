local M = {}

M.general = {
   i = {
      ["jj"] = { "<ESC>" },
   },
   n = {
     ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },
     ["<Leader><space>"] = { "<cmd>noh<CR>" },
     ["<Leader>S"] = { "<cmd>sort u<CR>" },
     ["<leader>n"] = { "<cmd> tabnew <CR>", "Create new tab" },
     ["<leader>s"] = { "<cmd> split <CR>", "Create h-split" },
     ["<leader>v"] = { "<cmd> vsplit <CR>", "Create v-split" },
     ["Q"] = { "<cmd> q! <CR>", opts = { silent = true } },
     ["C-h"] = { "<cmd>tabPrevious<CR>" },
     ["C-l"] = { "<cmd>tabNext<CR>" }
   },
   v = {
     ["<"] = { '<gv'},
     [">"] = { ">gv"},
     ["<Leader>S"] = { "<cmd>sort u<CR>" },
     ["<Leader>n"] = { "<cmd>tabnew<CR>" },
     ["<leader><space>"] = { "<cmd>noh<CR>" },
     ["C-h"] = { "<cmd>tabPrevious<CR>" },
     ["C-l"] = { "<cmd>tabNext<CR>" }
   },
}

return M
