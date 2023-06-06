local present, vimjsxpretty = pcall(require, "vim-jsx-pretty")

if not present then
   return
end

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
vimjsxpretty.load_extension('fzf')
