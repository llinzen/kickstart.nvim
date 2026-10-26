return {
  { -- render markdown inside nvim (headings, tables, checkboxes, code blocks)
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- keep the cursor line rendered too while reading (default: it shows the raw markdown)
      anti_conceal = { enabled = false },
      -- no extra virtual lines above/below code blocks and no inline padding in tables: they shift what you see
      -- against the real text, so scrolling jumps and mouse clicks land in the wrong place
      code = { border = 'thin' },
      pipe_table = { cell = 'overlay' },
      checkbox = { right_pad = 0 },
    },
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
