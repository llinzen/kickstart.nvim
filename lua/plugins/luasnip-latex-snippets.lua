return {
  'iurimateus/luasnip-latex-snippets.nvim',
  ft = { 'tex', 'markdown' },
  dependencies = { 'L3MON4D3/LuaSnip' },
  config = function()
    require('luasnip-latex-snippets').setup {
      use_treesitter = true,
    }
    require('luasnip').config.setup { enable_autosnippets = true }
  end,
}
