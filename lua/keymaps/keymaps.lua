-- jj -> <Esc> in insert mode: better-escape.nvim (lua/plugins/better-escape.lua)

-- vim.keymap.set('i', 'll', '<ESC>:wq<RETURN>', { silent = true })
vim.keymap.set('n', '++', '<C-a>', { silent = true })
-- <leader>q (close buffer w/o changing splits): mini.bufremove in lua/plugins/mini.lua

-- TJ split resize
vim.keymap.set('n', '<M-.>', '<c-w>5>', { desc = 'Increase split widt' })
vim.keymap.set('n', '<M-,>', '<c-w>5<', { desc = 'Decrease split widt' })
vim.keymap.set('n', '<M-t>', '<c-w>5+', { desc = 'Increase split height' })
vim.keymap.set('n', '<M-s>', '<c-w>5-', { desc = 'Decrease split height' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search hightlighting' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>sq', vim.diagnostic.setloclist, { desc = '[S]earch diagnostics in [Q]uickfix/location list' })

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

vim.keymap.set({ 'n', 'x' }, '<A-J>', '<Cmd>MultipleCursorsAddDown<CR>', { desc = 'Add cursor and move down' })
vim.keymap.set({ 'n', 'x' }, '<A-K>', '<Cmd>MultipleCursorsAddUp<CR>', { desc = 'Add cursor and move up' })
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

-- harpoon keymaps live in lua/plugins/harpoon.lua
