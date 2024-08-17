return {
  -- see the image.nvim readme for more information about configuring this plugin
  '3rd/image.nvim',
  config = function()
    require('image').setup()
    package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua'
    package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua'
  end,
  opts = {
    backend = 'kitty', -- whatever backend you would like to use
    max_width = 10000,
    max_height = 12000,
    max_height_window_percentage = math.huge,
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
  },
}
