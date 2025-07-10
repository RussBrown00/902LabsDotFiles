local options = {
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1500,
    lsp_fallback = true,
    stop_after_first = true, -- Add this option if you want to stop after the first formatter
  },
}

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format {
    async = true,
    lsp_fallback = true,
    range = range,
    quiet = false,
    stop_after_first = true, -- Add this option here if needed per command
  }
end, { range = true })

require("conform").setup(options)
