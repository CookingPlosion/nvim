--- utils/term/init.lua
--- Examples:
--- -- Example 1: toggle yazi.
---   local term = require('utils.term')
---   local myterm = term.get('myterm', { arg = 'yazi', startinsert = true })
---   vim.keymap.set('n', '<leader>e', function() myterm:toggleTerm() end, { silent = true })
---
--- -- Example 2: toggle yazi, override opts.
---   local term = require('utils.term')
---   local myterm = term.get('myterm')
---   vim.keymap.set('n', '<leader>e', function()
---     myterm:toggleTerm({ arg = 'yazi', startinsert = true })
---   end, { silent = true })
---
--- -- Example 3: Close instance.
---   local term = require('utils.term')
---   local myterm = term.get('myterm')
---   vim.keymap.set('n', '<leader>c', function()
---     if vim.api.nvim_get_option_value('filetype', { buf = 0 }) == 'terminal' then
---       utils.term.destroy(0, false)
---     else
---       vim.cmd('bd!')
---     end
---   end, { silent = true })

local term = require('utils.term.term_class')
local M = {}
local instances = {}
local bufnr_to_name = {}

do
  local serverPipe = vim.env.HOME .. '/.cache/nvim/server.pipe'
  local callCmd = string.format('call serverstart("%s")', serverPipe)
  vim.cmd(callCmd)
end

--- Get or create Term instances.
---@param name string unique instances name.
---@param opts table? Default configuration fpr initial creation.
function M.get(name, opts)
  if not instances[name] then
    instances[name] = term:new(opts or {})
    -- 记录映射
    if instances[name].termBufnr then
      bufnr_to_name[instances[name].termBufnr] = name
    end
  end
  return instances[name]
end

function M.showInstances()
  vim.notify(vim.inspect(instances))
end

--- Destroy term instance
---@param target string|number Instance name or buffer number
---@param force boolean Whether force
function M.destroy(target, force)
  target = target or 0
  force = force or false
  if target == 0 then target = vim.api.nvim_get_current_buf() end

  local name = target
  if type(target) == "number" then
    -- 按 bufnr 查找实例名
    name = bufnr_to_name[target]
    if not name then return end
    local buf_type = vim.api.nvim_get_option_value('filetype', { buf = target })
    if not force and buf_type ~= 'terminal' then
      return -- 非终端且非强制，不销毁
    end
  end
  if instances[name] then
    local bufnr = instances[name].termBufnr
    instances[name]:destroy(force)
    instances[name] = nil
    if bufnr then bufnr_to_name[bufnr] = nil end
  end
end

--- Toggle term instance
---@param name string unique instances name.
---@param opts table? Default configuration fpr initial creation.
function M.toggle(name, opts)
  if not instances[name] or not instances[name].defaults then
    instances[name] = term:new(opts or {})
    if instances[name].termBufnr then
      bufnr_to_name[instances[name].termBufnr] = name
      vim.notify(vim.inspect(bufnr_to_name))
    end
  end
  instances[name]:toggleTerm(opts)
end

vim.api.nvim_create_augroup('Sapnvim_term', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'terminal' },
  group = 'Sapnvim_term',
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>bd!<cr>', { buffer = true, silent = true })
  end
})
vim.api.nvim_create_autocmd('BufDelete', {
  group = 'Sapnvim_term',
  callback = function(args)
    local bufnr = args.buf
    local name = bufnr_to_name[bufnr]
    if name and instances[name] then
      instances[name] = nil
      bufnr_to_name[bufnr] = nil
    end
  end
})

return M
