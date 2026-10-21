-- jj leaves insert mode without the usual pause after every typed j
return {
  'max397574/better-escape.nvim',
  event = 'InsertEnter',
  opts = {
    timeout = 200, -- ms allowed between the two j
    default_mappings = false,
    mappings = {
      i = { j = { j = '<Esc>' } },
    },
  },
}
