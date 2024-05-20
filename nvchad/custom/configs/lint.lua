local lint = require "lint"

lint.linters_by_ft = {
  markdown = { "markdownlint", "vale" },
  yaml = { "yamllint" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  kotlin = { "ktlint" },
  terraform = { "tflint" },
  ruby = { "standardrb" },
}

vim.keymap.set("n", "<leader>ll", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
