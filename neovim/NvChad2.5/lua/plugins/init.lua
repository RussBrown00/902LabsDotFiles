return {
  {
    "pipoprods/nvm.nvim",
    config = function()
      require("nvm").setup {
        -- Auto-detect nvm and use the active Node version
        auto_use = true,
        -- Optional: Specify a default Node version if needed
        default_version = "18", -- Or whatever you use
      }
    end,
  },
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

  -- MARKDOWN STUFF
  { "vim-pandoc/vim-pandoc" },
  { "vim-pandoc/vim-pandoc-syntax" },

  { "nvim-lua/plenary.nvim" },
  event = "InsertEnter",
  -- { "puremourning/vimspector" },

  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  --   config = function()
  --     -- Mapping tab is already used by NvChad
  --     vim.g.copilot_no_tab_map = true;
  --     vim.g.copilot_assume_mapped = true;
  --     vim.g.copilot_tab_fallback = "";
  --     vim.g.copilot_workspace_folders = "~/workspace/photivo";
  --     -- The mapping is set to other key, see custom/lua/mappings
  --     -- or run <leader>ch to see copilot mapping section
  --   end
  -- },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        workspace_folders = {
          "~/workspace/photivo/",
          "~/workspace/marriott/",
          "~/workspace/sixoneeight/",
        },
        copilot_node_command = vim.fn.expand "$HOME" .. "/.nvm/versions/node/v23.1.0/bin/node",
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-Right>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<Right>",
          },
        },
      }
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  -- SIDEKICK
  {
    "folke/sidekick.nvim",
    opts = {
      nodejs_path = vim.fn.exepath "node",
      use_neovim_api = true,
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
        win = {
          layout = vim.g.sidekick_layout or "float", ---@type "float"|"left"|"bottom"|"top"|"right"
          --- Options used when layout is "float"
          ---@type vim.api.keyset.win_config
          float = {
            width = 0.75,
            height = 0.8,
          },
        },
      },
    },
    keys = {
      {
        "<leader><Tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
          -- Or to select only installed tools:
          -- require("sidekick.cli").select({ filter = { installed = true } })
        end,
        desc = "Sidekick Select CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          require("sidekick").clear()
        end,
        desc = "Sidekick Claude Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle { name = "grok", focus = true }
        end,
        desc = "Sidekick Grok Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
      require "configs.comment"
    end,
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
