return {
  {
    "stevearc/conform.nvim",
    event = {
      "BufWritePre",
      "InsertLeave",
    },
    config = function()
      require "configs.conform"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufWritePost",
      "BufNewFile",
      "BufEnter",
      "InsertLeave",
      "TextChanged",
    },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        kotlin = { "ktlint" },
        terraform = { "tflint" },
        ruby = { "standardrb" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "klen/nvim-config-local",
    "lambdalisue/vim-pyenv",
    config = function()
      require("config-local").setup {
        config_files = { ".nvim.lua", ".nvimrc" },

        -- Where the plugin keeps files data
        hashfile = vim.fn.stdpath "data" .. "/config-local",

        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
        silent = false, -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = true, -- Lookup config files in parent directories
      }
    end,
  },
  { "nvim-lua/plenary.nvim" },
  event = "InsertEnter",
  -- { "puremourning/vimspector" },
  {
    "codota/tabnine-nvim",
    -- event = edit_events,
    -- lazy = false,
    config = function()
      -- require("configs.tabnine")
    end,
    build = "./dl_binaries.sh",
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = true,
          },
        },
      },
      filters = {
        dotfiles = true,
        git_ignored = false,
        git_clean = false,
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
      view = {
        adaptive_size = true,
      },
      renderer = {
        highlight_git = true,
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
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
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
          -- "jedi-language-server",

          -- other stuff
          "lua-language-server",
          "stylua",
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
    },
  },
}
