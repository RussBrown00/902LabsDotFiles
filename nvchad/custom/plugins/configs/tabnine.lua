local present, cmp = pcall(require, "cmp")

if not present then
   return
end

local sources = {
  { name = 'cmp_tabnine' },
}

cmp.setup {
   sources = sources,
}
