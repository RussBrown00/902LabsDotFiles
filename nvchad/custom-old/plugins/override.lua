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
    disable = {},
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

M.mason = {
  ensure_installed = {
     -- web dev
    "autopep8",
    "black",
    "css-lsp",
    "emmet-ls",
    "eslint-lsp",
    "flake8",
    "html-lsp",
    "isort",
    "json-lsp",
    "marksman",
    "mypy",
    "prettier",
    "pylint",
    "python-lsp-server",
    "jedi-language-server",
    "typescript-language-server",
    "yaml-language-server",

    -- other stuff
    "lua-language-server",
    "jedi-language-server",
    "stylua",


  },
}

return M
