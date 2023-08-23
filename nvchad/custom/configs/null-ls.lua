local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
   -- b.formatting.prettier,
   b.formatting.yamlfix,
   b.formatting.stylua,

   -- webdev stuff
   b.code_actions.eslint,
   b.formatting.eslint,
   b.diagnostics.eslint,

   -- Lua
   b.formatting.stylua,

  -- Terraform
  b.formatting.terraform_fmt,

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

null_ls.setup {
   debug = true,
   sources = sources,
}
