local vault = vim.fn.expand '~' .. '/obsidian-sync'

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  -- only load for markdown files inside the vault (other .md files stay plain markdown)
  event = {
    'BufReadPre ' .. vault .. '/**.md',
    'BufNewFile ' .. vault .. '/**.md',
  },
  init = function()
    -- obsidian.nvim hides link/markup syntax via conceal; only in vault notes
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
      pattern = vault .. '/**.md',
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    workspaces = {
      { name = 'sync', path = vault },
    },
    -- markdown rendering is done by render-markdown.nvim (lua/plugins/markdown.lua)
    ui = { enable = false },
  },
}
