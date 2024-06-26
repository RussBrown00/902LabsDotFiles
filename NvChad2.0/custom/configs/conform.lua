local conform = require("conform")

local options = {
	log_level = vim.log.levels.DEBUG,
	lsp_fallback = true,
	formatters_by_ft = {
		css = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		lua = { "stylua" },
		python = { "black" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

-- Adding the new user command from conformer.vim
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end

	conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

conform.setup(options)
