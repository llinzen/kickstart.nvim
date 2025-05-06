if picker == 'telescope' then
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', require('telescope.builtin').oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
  vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').find_files, { desc = '[ ] Find files' })

  vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
  vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind with live [G]rep' })
  vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind in [B]uffers' })
  vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind in [H]elp tags' })
  vim.keymap.set('n', '<leader>fc', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[F]ind in [C]urrent buffer' })

  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Slightly advanced example of overriding default behavior and theme
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.require('telescope.builtin').live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
    require('telescope.builtin').live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
elseif picker == 'fzf' then
  vim.keymap.set('n', '<leader>sh', require('fzf-lua').helptags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', require('fzf-lua').keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', require('fzf-lua').builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', require('fzf-lua').grep_cword, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', require('fzf-lua').oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sb', require('fzf-lua').buffers, { desc = '[F]ind existing [B]uffers' })
  vim.keymap.set('n', '<leader><leader>', require('fzf-lua').files, { desc = '[ ] Find files' })

  vim.keymap.set('n', '<leader>ff', require('fzf-lua').files, { desc = '[F]ind [F]iles' })
  vim.keymap.set('n', '<leader>fg', require('fzf-lua').live_grep, { desc = '[F]ind with live [G]rep' })
  vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers, { desc = '[F]ind in [B]uffers' })
  vim.keymap.set('n', '<leader>fh', require('fzf-lua').helptags, { desc = '[F]ind in [H]elp tags' })
  vim.keymap.set('n', '<leader>fc', require('fzf-lua').lgrep_curbuf, { desc = '[F]ind in [C]urrent buffer' })
elseif picker == 'snacks' then
end
