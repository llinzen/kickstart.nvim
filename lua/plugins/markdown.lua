return {
  { -- render markdown inside nvim (headings, tables, checkboxes, code blocks)
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown toggle<CR>', ft = 'markdown', desc = '[M]arkdown [R]ender toggle' },
    },
  },
  { -- live preview in the browser (KaTeX math, Mermaid diagrams), no Node needed
    'brianhuster/live-preview.nvim',
    cmd = 'LivePreview',
    dependencies = { 'ibhagwan/fzf-lua' },
    keys = {
      { '<leader>mp', '<cmd>LivePreview start<CR>', ft = 'markdown', desc = '[M]arkdown [P]review in browser' },
      { '<leader>mP', '<cmd>LivePreview close<CR>', ft = 'markdown', desc = '[M]arkdown [P]review close' },
    },
  },
}
