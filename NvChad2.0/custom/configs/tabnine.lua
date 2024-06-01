require("tabnine").setup({
	accept_keymap = "<S-RIGHT>",
	codelens_color = { gui = "#808080", cterm = 244 },
	codelens_enabled = true,
	debounce_ms = 800,
	disable_auto_comment = true,
	dismiss_keymap = "<C-]>",
	exclude_filetypes = { "TelescopePrompt", "NvimTree" },
	suggestion_color = { gui = "#808080", cterm = 244 },
})
