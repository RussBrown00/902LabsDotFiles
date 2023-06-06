local present, telescope = pcall(require, "telescope")

if not present then
   return
end

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
