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

-- command name → keymaps whose right-hand side runs it (any arguments), built once per command-line session
local by_cmd
local function index()
  if by_cmd then
    return by_cmd
  end
  by_cmd = {}
  local maps = vim.list_extend(vim.api.nvim_buf_get_keymap(0, 'n'), vim.api.nvim_get_keymap 'n')
  for _, m in ipairs(maps) do
    if m.rhs then
      local full = norm(m.rhs)
      local name = full:match '^([%w_]+)'
      if name and full ~= '' and not full:find('<', 1, true) then
        by_cmd[name] = by_cmd[name] or {}
        local args = vim.trim(full:sub(#name + 1))
        table.insert(by_cmd[name], pretty(m.lhs) .. (args ~= '' and (' ' .. args) or ''))
      end
    end
  end
  return by_cmd
end

-- for blink.cmp's cmdline source (sources.providers.cmdline.transform_items): show the keymaps next to commands
function M.annotate(_, items)
  if vim.fn.getcmdtype() ~= ':' or vim.fn.getcmdline():find '%s' then
    return items -- only while typing the command name itself
  end
  local idx = index()
  for _, item in ipairs(items) do
    local keys = idx[(item.label or ''):lower()]
    if keys then
      item.labelDetails = vim.tbl_extend('force', item.labelDetails or {}, { description = table.concat(keys, ', ') })
    end
  end
  return items
end

vim.api.nvim_create_autocmd('CmdlineEnter', {
  pattern = ':',
  group = vim.api.nvim_create_augroup('cmd-keymap-index', { clear = true }),
  callback = function()
    by_cmd = nil
  end,
})

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
