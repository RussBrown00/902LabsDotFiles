return {
  ["sbdchd/neoformat"] = {},
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/nvim-lsp-installer"] = {
    after = "nvim-lspconfig",
    config = function()
         local lsp_installer = require "nvim-lsp-installer"

         lsp_installer.on_server_ready(function(server)
            local opts = {}

            server:setup(opts)
            vim.cmd [[ do User LspAttachBuffers ]]
         end)
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lsp-installer",
    config = function()
      require "custom.plugins.configs.null-ls"
    end,
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    after = "telescope.nvim",
    run = "make",
    config = function()
      require "custom.plugins.configs.fzf"
    end,
  },
  ["tzachar/cmp-tabnine"] = {
    after = "nvim-cmp",
    run = "./install.sh",
    config = function()
      require "custom.plugins.configs.tabnine"
    end,
  },
}
