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
  git = {
    enable = true,
  },
   actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true,
      }
    }
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  filters = {
    dotfiles = true,
    git_ignored = false,
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
