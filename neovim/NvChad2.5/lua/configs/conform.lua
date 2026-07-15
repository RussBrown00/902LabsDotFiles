local function find_oxfmt_root(filename)
  if not filename or filename == "" then
    return nil
  end
  return vim.fs.root(filename, ".oxfmtrc.json")
end

-- Force `bash` filetype for extensionless files starting with a bash shebang,
-- so shfmt formats them. Low priority defers to real extension-based detection.
vim.filetype.add {
  pattern = {
    [".*"] = {
      priority = -math.huge,
      function(_, bufnr)
        local first_line = (vim.api.nvim_buf_get_lines(bufnr, 0, 1, false))[1] or ""
        if first_line:match "^#!.*%f[%w]bash%f[%W]" then
          return "bash"
        end
      end,
    },
  },
}

local options = {
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    css = { "oxfmt", "prettierd", stop_after_first = true },
    html = { "prettierd" },
    javascript = { "oxfmt", "prettierd", stop_after_first = true },
    javascriptreact = { "oxfmt", "prettierd", stop_after_first = true },
    typescript = { "oxfmt", "prettierd", stop_after_first = true },
    typescriptreact = { "oxfmt", "prettierd", stop_after_first = true },
    json = { "oxfmt", "prettierd", stop_after_first = true },
    jsonc = { "oxfmt", "prettierd", stop_after_first = true },
    lua = { "stylua" },
    python = { "isort", "black" },
    terraform = { "terraform_fmt" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
  formatters = {
    oxfmt = {
      command = function(self, ctx)
        local root = find_oxfmt_root(ctx.filename)
        return root and (root .. "/node_modules/.bin/oxfmt") or "oxfmt"
      end,
      args = function(self, ctx)
        local root = find_oxfmt_root(ctx.filename)
        if not root then
          return { "--stdin-filepath", "$FILENAME" }
        end
        return {
          "--config=" .. root .. "/.oxfmtrc.json",
          "--stdin-filepath",
          "$FILENAME",
        }
      end,
      stdin = true,
      condition = function(self, ctx)
        return find_oxfmt_root(ctx.filename) ~= nil
      end,
    },
    black = {
      command = "poetry",
      args = { "run", "black", "--stdin-filename", "$FILENAME", "-" },
      stdin = true,
    },
    isort = {
      command = "poetry",
      args = { "run", "isort", "--filename", "$FILENAME", "-" },
      stdin = true,
    },
  },
  format_on_save = {
    timeout_ms = 1500,
    lsp_fallback = true,
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
  }
end, { range = true })

require("conform").setup(options)
