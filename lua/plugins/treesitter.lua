-- Treesitter on nvim-treesitter's `main` branch (the old `master` branch only supports Neovim <= 0.11):
-- nvim-treesitter only installs parsers and queries; highlighting is Neovim's own vim.treesitter.start().
-- Needs the tree-sitter CLI >= 0.26.1 (Fedora: tree-sitter-cli).

local ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vim', 'vimdoc', 'latex', 'bibtex' }

-- filetypes without treesitter highlighting (vim syntax instead); their parsers are still used, e.g. by LuaSnip
local no_highlight = { latex = true, tex = true, csv = true }
-- filetypes that additionally keep vim's regex highlighting and indentation
local vim_regex = { ruby = true }

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(ensure_installed)

      local function start(buf, lang, ft)
        if not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        if vim_regex[ft] then
          vim.bo[buf].syntax = ft
        else
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        callback = function(args)
          local ft = args.match
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang or no_highlight[ft] then
            return
          end
          if vim.treesitter.language.add(lang) then
            start(args.buf, lang, ft)
          elseif vim.list_contains(require('nvim-treesitter').get_available(), lang) then
            -- auto-install a missing parser, then start highlighting in this buffer
            require('nvim-treesitter').install(lang):await(function(err)
              if not err then
                vim.schedule(function()
                  if vim.api.nvim_buf_is_valid(args.buf) then
                    start(args.buf, lang, ft)
                  end
                end)
              end
            end)
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      enable = true,
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
      zindex = 20, -- The Z-index of the context window
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- extend text objects by the surrounding whitespace (like the built-in `ap`)
          include_surrounding_whitespace = true,
        },
      }

      local function select(lhs, query, group, desc)
        vim.keymap.set({ 'x', 'o' }, lhs, function()
          require('nvim-treesitter-textobjects.select').select_textobject(query, group or 'textobjects')
        end, { desc = desc })
      end
      select('af', '@function.outer', nil, 'Select around function')
      select('if', '@function.inner', nil, 'Select inside function')
      select('ac', '@class.outer', nil, 'Select around class')
      select('ic', '@class.inner', nil, 'Select inner part of a class region')
      select('as', '@local.scope', 'locals', 'Select language scope')
    end,
  },
}
