local M = {}

M.general = {
   i = {
     ["<leader>cc"] = { "<cmd>TComment<CR>", "Comment line" },
      ["jj"] = { "<ESC>", "Escape" },
   },
   n = {
     ["<C-p>"] = { "<cmd>Telescope find_files<CR>", "find files" },
     ["<leader><space>"] = { "<cmd>noh<CR>", "Clear search" },
     ["<leader>fr"] = { "<cmd>let @+ = expand(\"%\")<CR>", "Copy relative path to clipboard" },
     ["<leader>fs"] = { "<cmd>let @+ = expand(\"%:p\")<CR>", "Copy system path to clipboard" },
     ["<leader>fn"] = { "<cmd>let @+ = expand(\"%:t\")<CR>", "Copy filename to clipboard" },
     ["<leader>n"] = { "<cmd>tabnew<CR>", "Create new tab" },
     ["<leader>s"] = { "<cmd>split<CR>", "Create h-split" },
     ["<leader>v"] = { "<cmd>vsplit<CR>", "Create v-split" },
     ["<leader><C-f>"] = { "<cmd>Neoformat<CR>", "Neformat Page" },
     ["<C-h>"] = { "<cmd>tabprevious<CR>", "navigate to previous tab" },
     ["<C-l>"] = { "<cmd>tabnext<CR>", "navigate to next tab" },
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
