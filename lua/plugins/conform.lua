return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[C]ode [F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable LSP fallback formatting for languages that don't
        -- have a well standardized coding style.
        local disable_filetypes = { c = true, cpp = true, tex = true }
        return {
          timeout_ms = 500,
          lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        markdown = { 'prettier' },
        python = { 'ruff_organize_imports', 'ruff_format' },
      },
    },
  },
}
