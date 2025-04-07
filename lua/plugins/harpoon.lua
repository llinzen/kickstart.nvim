return {
  -- Harpoon plugin configuration
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' }, -- if harpoon requires this
    config = function()
      require('harpoon').setup {}

      if picker == 'telescope' then
        function pick_harpoon(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require('telescope.pickers')
            .new({}, {
              prompt_title = 'Harpoon',
              finder = require('telescope.finders').new_table {
                results = file_paths,
              },
              previewer = require('telescope.config').values.file_previewer {},
              sorter = require('telescope.config').values.generic_sorter {},
            })
            :find()
        end
      elseif picker == 'fzf' then
        -- print 'fzf not yet implemented'
        -- else
        function pick_harpoon(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.item) do
            table.insert(file_paths, item.value())
          end

          require('fzf-lua').fzf_exec(file_paths)
        end
      end
    end,
  },
}
