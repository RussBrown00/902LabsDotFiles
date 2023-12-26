local M = {}

M.general = {
   i = {
     ["<leader>cc"] = { "<cmd>TComment<CR>", "Comment line" },
     ["ESC"] = { "<ESC><ESC>", "Double Escape" },
     ["jj"] = { "<ESC><ESC>", "Escape" },
   },
   n = {
     ["<C-p>"] = { "<cmd>Telescope find_files<CR>", "find files" },
     ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
     ["<leader>fu"] = { "<cmd> Telescope resume<CR>", "Resume" },
     ["<leader>fh"] = { "<cmd>Telescope search_history<CR>", "Telescope Search History" },
     ["<leader><space>"] = { "<cmd>noh<CR>", "Clear search" },
     ["<leader><C-f>"] = { "<cmd>Neoformat<CR>", "Run Neoformat on file" },
     ["<leader>n"] = { "<cmd>tabnew<CR>", "Create new tab" },
     ["<leader>s"] = { "<cmd>split<CR>", "Create h-split" },
     ["<leader>v"] = { "<cmd>vsplit<CR>", "Create v-split" },
     ["<C-h>"] = { "<cmd>tabprevious<CR>", "navigate to previous tab" },
     ["<C-l>"] = { "<cmd>tabnext<CR>", "navigate to next tab" },
     ["<leader>fr"] = { "<cmd>let @\" = expand(\"%\")<CR>", "Copy relative path" },
     ["<leader>fp"] = { "<cmd>let @\" = expand(\"%:p\")<CR>", "Copy full path" },
     ["<leader>fn"] = { "<cmd>let @\" = expand(\"%:t\")<CR>", "Copy file name" },
  },
   v = {
     ["<leader>S"] = { "<cmd>sort u<CR>", "Unique sort selected lines" },
   },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },

    -- new

    ["<leader>th"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "new horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}

return M
