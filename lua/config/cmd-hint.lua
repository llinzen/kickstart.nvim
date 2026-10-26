-- After an Ex command that also has a normal-mode keymap, show the keymap ("RenderMarkdown toggle → <leader>mr"),
-- so the shortcut sticks. Matches keymaps whose right-hand side is that command (`<cmd>…<CR>` or `:…<CR>`).
local M = {}

local function norm(s)
  s = (s or ''):gsub('^%s*:', ''):gsub('^<[Cc][Mm][Dd]>', ''):gsub('<[Cc][Rr]>%s*$', '')
  return vim.trim(s):lower()
end

local function pretty(lhs)
  local leader = vim.g.mapleader or '\\'
  if lhs:sub(1, #leader) == leader then
    lhs = '<leader>' .. lhs:sub(#leader + 1)
  end
  return (lhs:gsub(' ', '<Space>'))
end

function M.keys_for(cmd)
  cmd = norm(cmd)
  if cmd == '' then
    return {}
  end
  local hits, seen = {}, {}
  local maps = vim.list_extend(vim.api.nvim_buf_get_keymap(0, 'n'), vim.api.nvim_get_keymap 'n')
  for _, m in ipairs(maps) do
    if m.rhs and norm(m.rhs) == cmd and not seen[m.lhs] then
      seen[m.lhs] = true
      table.insert(hits, pretty(m.lhs))
    end
  end
  return hits
end

vim.api.nvim_create_autocmd('CmdlineLeave', {
  pattern = ':',
  group = vim.api.nvim_create_augroup('cmd-keymap-hint', { clear = true }),
  callback = function()
    if vim.v.event.abort then
      return
    end
    local cmd = vim.fn.getcmdline()
    vim.schedule(function()
      local keys = M.keys_for(cmd)
      if #keys > 0 then
        vim.notify(vim.trim(cmd) .. ' → ' .. table.concat(keys, ', '), vim.log.levels.INFO, { title = 'keymap' })
      end
    end)
  end,
})

return M
