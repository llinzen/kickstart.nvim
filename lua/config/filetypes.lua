-- files inside a directory with "ansible" in its name are ansible yaml (for ansible-language-server)
vim.filetype.add {
  pattern = {
    ['.*ansible.*/.*%.ya?ml'] = 'yaml.ansible',
  },
}
