vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

-- sync with the system clipboard; scheduled because detecting the clipboard tool slows startup
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 100

vim.opt.termguicolors = true

-- blinking block cursor in insert mode
vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

vim.opt.spelllang = { 'en_us', 'de_de' }
vim.opt.spelloptions = 'camel' -- check the parts of CamelCase words separately
-- turn spell checking on right after startup: loading the German dictionary takes ~20 ms
-- (in code, treesitter limits it to comments/docstrings; typos-lsp checks identifiers)
vim.schedule(function()
  vim.opt.spell = true
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.wo[win].spell = true
  end
end)

-- vim.opt.encoding = 'utf-8'

vim.opt.hlsearch = true

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.o.tabstop = 2 -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

-- load project-local .nvim.lua / .nvimrc / .exrc from the working directory;
-- Neovim asks before running an unknown or changed file (:trust to manage)
vim.o.exrc = true

-- no plugins need the remote-plugin providers (molten, the last python one, is parked);
-- disabling them skips their startup checks and the :checkhealth warnings
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
