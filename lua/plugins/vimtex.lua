return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    -- Use init for configuration, don't use the more common "config".
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
  end,
}
