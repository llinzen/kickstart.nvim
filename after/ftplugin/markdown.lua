-- Markdown outside the Obsidian vault: <CR> opens what is under the cursor, so notes like TODO.md / OFFLINE.md
-- can be browsed like a wiki. Handles [text](target) links, bare paths (also in `backticks`), path:line, ~/ and
-- URLs. Relative paths are tried against the markdown file's folder, then the current directory. Back: <C-o>.
-- Inside the vault obsidian.nvim keeps its own <CR> (smart action).
local buf = vim.api.nvim_get_current_buf()
local file = vim.api.nvim_buf_get_name(buf)

-- <leader>mq: quiet reading, i.e. spell checking and diagnostics (markdownlint inline hints) off/on for this buffer
vim.keymap.set('n', '<leader>mq', function()
  local quiet = not vim.b.md_quiet
  vim.b.md_quiet = quiet
  vim.opt_local.spell = not quiet
  vim.diagnostic.enable(not quiet, { bufnr = 0 })
  vim.notify(quiet and 'markdown: spell + diagnostics off' or 'markdown: spell + diagnostics on')
end, { buffer = buf, desc = '[M]arkdown [Q]uiet: spell + diagnostics toggle' })

local vault = vim.fn.expand '~' .. '/obsidian-sync/'
if file:sub(1, #vault) == vault then
  return
end

vim.opt_local.suffixesadd:append '.md'
vim.opt_local.path:prepend(vim.fn.fnamemodify(file, ':p:h'))

-- the markdown link target around the cursor column, if any
local function link_target(line, col)
  for s, target, e in line:gmatch '()%[[^%]]*%]%(([^)]+)%)()' do
    if col >= s and col < e then
      return target
    end
  end
end

-- the path-like word under the cursor, without surrounding quotes, backticks and punctuation
local function word_target(line, col)
  local s, e = col, col
  local stop = '[%s`"\'<>%(%)%[%]{},;|]'
  while s > 1 and not line:sub(s - 1, s - 1):match(stop) do
    s = s - 1
  end
  while e <= #line and not line:sub(e, e):match(stop) do
    e = e + 1
  end
  local w = line:sub(s, e - 1):gsub('[.:]+$', '')
  return w ~= '' and w or nil
end

local function open_target(target)
  target = target:gsub('^<', ''):gsub('>$', '')
  if target:match '^%a[%w+.-]*://' or target:match '^mailto:' then
    vim.ui.open(target)
    return true
  end
  target = target:gsub('#.*$', '') -- drop #anchors
  local path, lnum = target:match '^(.-):(%d+)$'
  path = path or target
  path = vim.fn.expand(path)
  local candidates = { path }
  if not path:match '^/' then
    candidates = {
      vim.fn.fnamemodify(file, ':p:h') .. '/' .. path,
      vim.fn.getcwd() .. '/' .. path,
    }
  end
  for _, p in ipairs(candidates) do
    for _, c in ipairs { p, p .. '.md' } do
      if vim.uv.fs_stat(c) then
        vim.cmd.edit { vim.fn.fnameescape(vim.fn.fnamemodify(c, ':p')) }
        if lnum then
          vim.api.nvim_win_set_cursor(0, { math.min(tonumber(lnum), vim.api.nvim_buf_line_count(0)), 0 })
        end
        return true
      end
    end
  end
  return false
end

local function follow()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local t = link_target(line, col) or word_target(line, col)
  if t and open_target(t) then
    return
  end
  vim.notify('nothing to open under the cursor' .. (t and (': ' .. t) or ''), vim.log.levels.INFO)
end

vim.keymap.set('n', '<CR>', follow, { buffer = buf, desc = 'Markdown: open link/path under cursor' })
