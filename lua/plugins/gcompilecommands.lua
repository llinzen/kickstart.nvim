return {
  'llinzen/gcompilecommands.nvim',
  opts = {
    tmp_file_path = '$HOME/tmp/compilecommandsNEOVIM.json',
  },
  ft = { 'c', 'cpp', 'make', 'cmake' }, -- lazy load plugin only on C and C++ filetypes
}
