return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- surroundings (ys/ds/cs): nvim-surround, see lua/plugins/surround.lua
      require('mini.move').setup()
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      -- require('mini.git').setup()
      -- require('mini.icons').setup()
      -- require('mini.diff').setup()
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Buffer tabline at the top (listed buffers, ordered by buffer number)
      require('mini.tabline').setup { show_icons = vim.g.have_nerd_font }

      -- Delete buffers without closing their windows / changing the split layout
      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>q', function()
        MiniBufremove.delete()
      end, { desc = 'Close buffer w/o changing splits' })
      vim.keymap.set('n', '<A-c>', function()
        MiniBufremove.delete()
      end, { desc = 'Close buffer w/o changing splits' })

      -- <A-1>..<A-9>: go to the n-th buffer in the tabline, <A-0>: the last one
      -- (previous/next buffer: [b / ]b, built into Neovim)
      local function goto_buffer(n)
        return function()
          local bufs = vim.tbl_filter(function(b)
            return vim.bo[b].buflisted
          end, vim.api.nvim_list_bufs())
          local buf = n == 0 and bufs[#bufs] or bufs[n]
          if buf then
            vim.api.nvim_set_current_buf(buf)
          end
        end
      end
      for i = 0, 9 do
        vim.keymap.set('n', '<A-' .. i .. '>', goto_buffer(i), { desc = i == 0 and 'Go to last buffer' or ('Go to buffer ' .. i) })
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
