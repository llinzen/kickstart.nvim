local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.diagnostic.config { virtual_text = false }

require('lazy').setup {
  spec = {
    { 'tpope/vim-sleuth' },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
    { import = 'plugins' },
    { import = 'plugins.debug' },
    { import = 'plugins.practice' },
  },
  install = { colorscheme = { 'gruvbox' } },
  checker = {
    enabled = true,
    notify = true,
    frequency = 86400, --only once per day
  },
}
