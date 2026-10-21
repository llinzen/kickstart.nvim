--picker
return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua', -- also loaded on require (picker keymaps, harpoon, neoclip)
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {}
    end,
  },
}
