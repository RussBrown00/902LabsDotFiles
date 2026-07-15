-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  "html",
  "eslint",
  "cssls",
  "yamlls",
  "jsonls",
  "pyright",
  "tailwindcss",
  "sqlls",
  "gopls",
}

-- "jedi-language-server"
-- "pylsp"

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

vim.lsp.config("jsonls", {
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/vscode-json-language-server", "--stdio" },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- for name, opts in pairs(servers) do
--   opts.on_init = configs.on_init
--   opts.on_attach = configs.on_attach
--   opts.capabilities = configs.capabilities
--
--   require("lspconfig")[name].setup(opts)
-- end

-- typescript
vim.lsp.config("ts_ls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

vim.lsp.enable(servers)
