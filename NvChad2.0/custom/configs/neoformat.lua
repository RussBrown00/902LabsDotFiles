vim.api.nvim_exec(
	[[
    augroup fmt
    autocmd!
    autocmd BufWritePre *.js Neoformat
    augroup END
]],
	false
)

require("neoformat").setup({})
