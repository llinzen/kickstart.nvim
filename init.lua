vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

picker = 'fzf'

require 'config.opts'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require 'config.lazy'

require 'keymaps.keymaps'
require 'keymaps.tabs'


require 'keymaps.picker'

vim.o.background = 'dark' -- or "light" for light mode
vim.cmd [[colorscheme gruvbox]]

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/snippets/*.lua', true)) do
  loadfile(ft_path)()
end
