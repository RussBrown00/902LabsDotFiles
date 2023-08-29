local M = {}

M.treesitter = {
  auto_install = true,
  sync_install = true,
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "css",
    "fish",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "php",
    "regex",
    "ruby",
    "scss",
    "swift",
    "toml",
    "tsx",
    "vim",
    "yaml",
  },
  autotag = {
    enable = false,
  },
}

M.nvimtree = {
   actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true,
      }
    }
  },
  filters = {
    dotfiles = true,
    git_ignored = false,
  },
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
    disable_for_dirs = {},
    timeout = 400,
  },
  renderer = {
    highlight_git = false,
    icons = {
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      git_placement = "after",
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "פֿ",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "喝",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

M.mason = {
  ensure_installed = {
     -- web dev
    "css-lsp",
    "emmet-ls",
    "eslint-lsp",
    "eslint_d",
    "flake8",
    "gospel",
    "html-lsp",
    "isort",
    "json-lsp",
    "marksman",
    "prettier",
    "tailwindcss-language-server",
    "typescript-language-server",
    "vue-language-server",
    "yaml-language-server",

    -- python stuff
    "autopep8",
    "black",
    "pylint",
    "python-lsp-server",
    "pyright",
    -- "mypy",
    -- "jedi-language-server",

    -- other stuff
    "lua-language-server",
    "stylua",
  },
}

return M
