--- utils/term/init.lua
--- Examples:
--- -- Example 1: toggle yazi.
---   local term = require('utils.term')
---   vim.keymap.set('n', '<leader>e', function()
--      term.toggle({ name = 'yazi', cmdStr = { 'zsh', '-c', 'yazi' } })
---   end, { silent = true })
---
--- -- Example 2: toggle terminal.
---   local term = require('utils.term')
---   vim.keymap.set('n', '<leader>e', function()
---     utils.term.toggle({
---      name = 'main',
---      cmdStr = { 'zsh' },
---      opts = { layout_strategy = 'only', startinsert = false },
---     })
---   end, { silent = true })
---
--- -- Example 3: Close instance.
---   local term = require('utils.term')
---   vim.keymap.set('n', '<leader>c', function()
---     if vim.api.nvim_get_option_value('filetype', { buf = 0 }) == 'terminal' then
---       utils.term.destroy(0, false) - false is no force
---     else
---       vim.cmd('bd')
---     end
---   end, { silent = true })

local term = require('utils.term.term_class')
local M = {}
local instances = {}
local bufnrToName = {}

local pid = vim.fn.getpid()
local pipe_path = vim.fn.stdpath('cache') .. '/server_' .. pid .. '.pipe'

local cache_dir = vim.fn.fnamemodify(pipe_path, ':h')
if vim.fn.isdirectory(cache_dir) == 0 then
  vim.fn.mkdir(cache_dir, 'p')
end

if vim.v.servername == '' or vim.v.servername ~= pipe_path then
  pcall(vim.fn.serverstart, pipe_path)
end

--- debug, Show existing instances
function M.showInstances()
  local debug = {}
  table.insert(debug, instances)
  table.insert(debug, bufnrToName)
  vim.notify(vim.inspect(debug))
end

--- Register the name and bufnr id of an existing instance to the bufnrToname table
---@param instance table Instances that need to be registered
local function registerBufnr(instance)
  if instance.termBufnr and instance.name then
    bufnrToName[instance.termBufnr] = instance.name
  end
end

--- Destroy term instance
---@param target string|number Instance name or buffer number
---@param force boolean Whether force
function M.destroy(target, force)
  target = target or 0
  force = force or false

  local name = target
  if type(target) == 'number' then
    if target == 0 then
      target = vim.api.nvim_get_current_buf()
    end
    name = bufnrToName[target]
    if not name then
      return
    end
    local buf_type = vim.api.nvim_get_option_value('filetype', { buf = target })
    if not force and buf_type ~= 'terminal' then
      return -- 非终端且非强制，不销毁
    end
  end
  if instances[name] then
    local bufnr = instances[name].termBufnr
    instances[name]:destroy(force)
    instances[name] = nil
    if bufnr then
      bufnrToName[bufnr] = nil
    end
  end
end

--- Toggle term instance
---@param opts table Default configuration fpr initial creation.
function M.toggle(opts)
  local name = opts.name

  if not instances[name] then
    instances[name] = term:new(opts or {})
  end

  -- 执行 toggleTerm 切换显示/隐藏
  instances[name]:toggleTerm()
  registerBufnr(instances[name])
end

vim.api.nvim_create_augroup('Sapnvim_term', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'terminal' },
  desc = 'Use <q> to quit the terminal buffer instance',
  group = 'Sapnvim_term',
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>bd!<cr>', { buffer = true, silent = true })
    vim.keymap.set('n', '<C-w>s', '<Nop>', { buffer = true, silent = true })
    vim.keymap.set('n', '<C-w>v', '<Nop>', { buffer = true, silent = true })
    vim.keymap.set('n', '|', '<Nop>', { buffer = true, silent = true })
    vim.keymap.set('n', '\\', '<Nop>', { buffer = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd('BufWipeout', {
  group = 'Sapnvim_term',
  desc = 'Cleanup terminal buffer instances when wiped out',
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    if filetype == 'terminal' then
      local name = bufnrToName[bufnr]
      if name and instances[name] then
        instances[name] = nil
        bufnrToName[bufnr] = nil
      end
    end
  end,
})

return M
