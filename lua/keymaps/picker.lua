-- search/goto keymaps for the picker selected in init.lua (vim.g.picker = 'fzf' | 'telescope')
-- the picker module is only required when a key is pressed (keeps startup lazy)

local pickers = {
  fzf = {
    module = 'fzf-lua',
    help = 'helptags',
    keymaps = 'keymaps',
    commands = 'commands',
    files = 'files',
    builtin = 'builtin',
    grep_word = 'grep_cword',
    live_grep = 'live_grep',
    diagnostics = 'diagnostics_workspace',
    resume = 'resume',
    oldfiles = 'oldfiles',
    buffers = 'buffers',
    grep_curbuf = 'lgrep_curbuf',
    definitions = 'lsp_definitions',
    references = 'lsp_references',
    implementations = 'lsp_implementations',
    typedefs = 'lsp_typedefs',
    document_symbols = 'lsp_document_symbols',
    workspace_symbols = 'lsp_workspace_symbols',
  },
  telescope = {
    module = 'telescope.builtin',
    help = 'help_tags',
    commands = 'commands',
    keymaps = 'keymaps',
    files = 'find_files',
    builtin = 'builtin',
    grep_word = 'grep_string',
    live_grep = 'live_grep',
    diagnostics = 'diagnostics',
    resume = 'resume',
    oldfiles = 'oldfiles',
    buffers = 'buffers',
    grep_curbuf = 'current_buffer_fuzzy_find',
    definitions = 'lsp_definitions',
    references = 'lsp_references',
    implementations = 'lsp_implementations',
    typedefs = 'lsp_type_definitions',
    document_symbols = 'lsp_document_symbols',
    workspace_symbols = 'lsp_dynamic_workspace_symbols',
  },
}

local p = pickers[vim.g.picker]
if not p then
  return
end

local function pick(action)
  return function()
    require(p.module)[p[action]]()
  end
end

local map = function(lhs, action, desc)
  vim.keymap.set('n', lhs, pick(action), { desc = desc })
end

map('<leader>sh', 'help', '[S]earch [H]elp')
map('<leader>sk', 'keymaps', '[S]earch [K]eymaps')
map('<leader>s:', 'commands', '[S]earch : commands')
map('<leader>sf', 'files', '[S]earch [F]iles')
map('<leader>ss', 'builtin', '[S]earch [S]elect picker')
map('<leader>sw', 'grep_word', '[S]earch current [W]ord')
map('<leader>sg', 'live_grep', '[S]earch by [G]rep')
map('<leader>sd', 'diagnostics', '[S]earch [D]iagnostics')
map('<leader>sr', 'resume', '[S]earch [R]esume')
map('<leader>s.', 'oldfiles', '[S]earch Recent Files ("." for repeat)')
map('<leader>sb', 'buffers', '[F]ind existing [B]uffers')
map('<leader><leader>', 'files', '[ ] Find files')

map('<leader>ff', 'files', '[F]ind [F]iles')
map('<leader>fg', 'live_grep', '[F]ind with live [G]rep')
map('<leader>fb', 'buffers', '[F]ind in [B]uffers')
map('<leader>fh', 'help', '[F]ind in [H]elp tags')
map('<leader>fc', 'grep_curbuf', '[F]ind in [C]urrent buffer')

map('gd', 'definitions', '[G]oto [D]efinition')
map('grr', 'references', '[G]oto [R]eferences')
map('gI', 'implementations', '[G]oto [I]mplementation')
map('<leader>D', 'typedefs', 'Type [D]efinition')
map('<leader>ds', 'document_symbols', '[D]ocument [S]ymbols')
map('<leader>ws', 'workspace_symbols', '[W]orkspace [S]ymbols')
