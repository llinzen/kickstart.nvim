-- fuzzy-pick one of the harpoon files with fzf-lua
local function pick_harpoon()
  local items = vim.tbl_map(function(item)
    return item.value
  end, require('harpoon'):list().items)
  require('fzf-lua').fzf_exec(items, {
    prompt = 'Harpoon> ',
    previewer = 'builtin',
    actions = { ['default'] = require('fzf-lua').actions.file_edit },
  })
end

local function select(i)
  return function()
    require('harpoon'):list():select(i)
  end
end

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua' },
    opts = {},
    keys = {
      { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Harpoon: [A]dd file' },
      { '<C-e>', pick_harpoon, desc = 'Harpoon: pick file (fzf)' },
      {
        '<leader>H',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[H]arpoon menu (edit/reorder)',
      },
      { '<leader>1', select(1), desc = 'Harpoon: file 1' },
      { '<leader>2', select(2), desc = 'Harpoon: file 2' },
      { '<leader>3', select(3), desc = 'Harpoon: file 3' },
      { '<leader>4', select(4), desc = 'Harpoon: file 4' },
      -- Toggle previous & next buffers stored within Harpoon list
      { '<C-S-P>', function() require('harpoon'):list():prev() end, desc = 'Harpoon: previous file' },
      { '<C-S-N>', function() require('harpoon'):list():next() end, desc = 'Harpoon: next file' },
    },
  },
}
