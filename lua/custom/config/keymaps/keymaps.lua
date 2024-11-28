return {
  vim.keymap.set('i', 'jj', '<ESC>', { silent = true }),
  vim.keymap.set('i', 'kk', '<ESC>:w<RETURN>', { silent = true }),
  -- vim.keymap.set('i', 'll', '<ESC>:wq<RETURN>', { silent = true }),
  vim.keymap.set('n', '++', '<C-a>', { silent = true }),
  vim.keymap.set('n', '<leader>q', ':bq<bar>sp<bar>bn<bar>bd<CR>', { silent = true, desc = 'Close buffer w/o changing splits' }),
}
