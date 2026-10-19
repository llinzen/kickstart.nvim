vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*ansible*/*.yaml', '*ansible*/*.yml' },
  command = 'set filetype=yaml.ansible',
  desc = 'if inside ansible folder set filetype to ensure ansible-lsp',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*ansible*.yaml', '*ansible*.yml' }, command = 'print("switched filetype to ")' })
