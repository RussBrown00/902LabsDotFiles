local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  {
    name = "html",
  },
  {
    name = "eslint",
  },
  {
    name = "cssls",
  },
  {
    name = "tsserver",
  },
  -- {
  --   name = "jedi-language-server",
  -- },
  {
    name = "pyright",
  },
  {
    name = "pylsp",
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "W391" },
            maxLineLength = 100,
          },
        },
      },
    },
  },
  {
    name = "jsonls",
  },
  {
    name = "tailwindcss",
  },
  {
    name = "sqlls",
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp.name].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    setttings = lsp.settings,
  }
end
