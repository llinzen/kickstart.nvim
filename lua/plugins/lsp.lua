return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'Mason', 'LspInfo' },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      -- { -- optional cmp completion source for require statements and module annotations
      --   'hrsh7th/nvim-cmp',
      --   opts = function(_, opts)
      --     opts.sources = opts.sources or {}
      --     table.insert(opts.sources, {
      --       name = 'lazydev',
      --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      --     })
      --   end,
      -- },
      {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
          -- 'super-tab' for mappings similar to vscode (tab to accept)
          -- 'enter' for enter to accept
          -- 'none' for no mappings
          --
          -- All presets have the following mappings:
          -- C-space: Open menu or open docs if already open
          -- C-n/C-p or Up/Down: Select next/previous item
          -- C-e: Hide menu
          -- C-k: Toggle signature help (if signature.enabled = true)
          --
          -- See :h blink-cmp-config-keymap for defining your own keymap
          keymap = { preset = 'default' },

          appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
          },

          -- (Default) Only show the documentation popup when manually triggered
          completion = { documentation = { auto_show = true } },

          -- Default list of enabled providers defined so that you can extend it
          -- elsewhere in your config, without redefining it, due to `opts_extend`
          sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
              -- : completion shows the keymap of a command next to it (lua/config/cmd-hint.lua)
              cmdline = {
                transform_items = function(ctx, items)
                  return require('config.cmd-hint').annotate(ctx, items)
                end,
              },
            },
          },
          -- function signature help
          signature = { enabled = true },
          -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
          -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
          -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
          --
          -- See the fuzzy documentation for more information
          fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
      },
    },

    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'texlab' then
            map('<leader>lb', '<cmd>LspTexlabBuild<CR>', '[L]aTeX [B]uild')
          end

          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- server-specific settings (merged with nvim-lspconfig's defaults).
      -- Every server installed via Mason is enabled automatically by mason-lspconfig;
      -- blink.cmp adds its completion capabilities to all servers by itself.
      vim.lsp.config('lua_ls', {
        settings = { Lua = { completion = { callSnippet = 'Replace' } } },
      })
      vim.lsp.config('texlab', {
        settings = {
          texlab = {
            build = {
              executable = 'latexmk',
              args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
              onSave = true, -- build on :w (manual: <leader>lb)
              forwardSearchAfter = true,
            },
            forwardSearch = {
              executable = 'okular',
              args = { '--unique', 'file:%p#src:%l%f' },
            },
          },
        },
      })

      -- tools Mason keeps installed (LSP servers, formatters, linters)
      require('mason-tool-installer').setup {
        ensure_installed = {
          'bash-language-server',
          'clang-format',
          'clangd',
          'cpplint',
          'checkmake',
          'cmakelint',
          'cmakelang',
          'cmake-language-server',
          'ansible-lint',
          'ansible-language-server',
          'lua-language-server',
          'markdownlint',
          'prettier', -- markdown formatter
          'ruff', -- python formatter (incl. import sorting)
          'shfmt', -- sh/bash formatter
          'pyright',
          'stylua', -- Used to format Lua code
          'texlab',
          'typos-lsp', -- code-aware spell checker (misspelled identifiers, comments)
          'latexindent',
          'yamlfix',
          'yamllint',
          'yaml-language-server',
        },
      }

      -- stylua is a formatter (used via conform), not a language server for this config
      require('mason-lspconfig').setup { automatic_enable = { exclude = { 'stylua' } } }
    end,
  },
}
