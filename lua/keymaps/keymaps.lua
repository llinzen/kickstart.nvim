vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('i', 'kk', '<ESC>:w<RETURN>', { silent = true })

-- vim.keymap.set('i', 'll', '<ESC>:wq<RETURN>', { silent = true })
vim.keymap.set('n', '++', '<C-a>', { silent = true })
vim.keymap.set('n', '<leader>q', ':bq<bar>sp<bar>bn<bar>bd<CR>', { silent = true, desc = 'Close buffer w/o changing splits' })

-- TJ split resize
vim.keymap.set('n', '<M-,>', '<c-w>5<')
vim.keymap.set('n', '<M-.>', '<c-w>5>')
vim.keymap.set('n', '<M-t>', '<c-w>5+')
vim.keymap.set('n', '<M-s>', '<c-w>5-')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'n', 'x' }, '<A-j>', '<Cmd>MultipleCursorsAddDown<CR>', { desc = 'Add cursor and move down' })
vim.keymap.set({ 'n', 'x' }, '<A-k>', '<Cmd>MultipleCursorsAddUp<CR>', { desc = 'Add cursor and move up' })
vim.keymap.set({ 'n', 'i', 'x' }, '<A-Up>', '<Cmd>MultipleCursorsAddUp<CR>', { desc = 'Add cursor and move up' })
vim.keymap.set({ 'n', 'i', 'x' }, '<A-Down>', '<Cmd>MultipleCursorsAddDown<CR>', { desc = 'Add cursor and move down' })
vim.keymap.set({ 'n', 'i' }, '<C-LeftMouse>', '<Cmd>MultipleCursorsMouseAddDelete<CR>', { desc = 'Add or remove cursor' })
vim.keymap.set({ 'n', 'x' }, '<Leader>cw', '<Cmd>MultipleCursorsAddMatches<CR>', { desc = 'Add cursors to cword' })
vim.keymap.set({ 'n', 'x' }, '<Leader>cW', '<Cmd>MultipleCursorsAddMatchesV<CR>', { desc = 'Add cursors to cword in previous area' })
vim.keymap.set({ 'n', 'x' }, '<Leader>cd', '<Cmd>MultipleCursorsAddJumpNextMatch<CR>', { desc = 'Add cursor and jump to next cword' })
vim.keymap.set({ 'n', 'x' }, '<Leader>cD', '<Cmd>MultipleCursorsJumpNextMatch<CR>', { desc = 'Jump to next cword' })
vim.keymap.set({ 'n', 'x' }, '<Leader>cl', '<Cmd>MultipleCursorsLock<CR>', { desc = 'Lock virtual cursors' })

vim.keymap.set('n', '<leader>nc', ":lua require('neoclip.fzf')()<CR>", { desc = 'Browse [N]eo[C]lip with fzf' })
vim.keymap.set('n', '<leader>nC', ":lua require('neoclip.fzf')('')", { desc = 'Browse [N]eo[C]lip with fzf and choose a register' })

local harpoon = require 'harpoon'

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<C-h>', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<C-t>', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<C-n>', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<C-s>', function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-S-P>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<C-S-N>', function()
  harpoon:list():next()
end)

vim.keymap.set('n', '<C-e>', function()
  pick_harpoon(harpoon:list())
end, { desc = 'Open harpoon window' })
