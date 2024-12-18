return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy', -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require('tiny-inline-diagnostic').setup {
      preset = 'powerline',
      options = {
        use_icons_from_diagnostics = true,
        multilines = true,
      },
    }
  end,
}
