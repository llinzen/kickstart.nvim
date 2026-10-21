return {
  'benlubas/molten-nvim',
  version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
  dependencies = { '3rd/image.nvim' },
  build = ':UpdateRemotePlugins',
  init = function()
    -- these are examples, not defaults. Please see the readme
    vim.g.molten_image_provider = 'image.nvim'
    vim.g.molten_output_win_max_height = 20
  end,
  vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' }),
  vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' }),
  vim.keymap.set('n', '<localleader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' }),
  vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' }),
  vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' }),
  vim.keymap.set('n', '<localleader>ra', 'ggVG:<BS><BS><BS><BS><BS>MoltenEvaluateVisual<CR><ESC>', { silent = true, desc = 'evaluate all' }),
}
