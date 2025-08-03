-- utils/term.lua
local Term = {}
Term.__index = Term

function Term:new(opts)
  opts = opts or {}
  local obj = {
    termBufnr = nil,
    defaults = {
      layout = opts.layout or 'only',
      size = opts.size or 0,
      arg = opts.arg or '',
      startinsert = opts.startinsert or true,
    }
  }
  setmetatable(obj, self)
  return obj
end

function Term:destroy(force)
  force = force or false
  -- close bufer
  if self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr) then
    local cmdStr = 'bd ' .. self.termBufnr
    if force then cmdStr = 'bd! ' .. self.termBufnr end
    vim.cmd(cmdStr)
    self.termBufnr = nil
  end
  -- Cleanup status
  self.defaults = nil
end

function Term:setLayout(opts)
  for k, _ in pairs(opts) do
    if self.defaults[k] == nil then
      error(k .. " is not a valid configuration option")
      return false
    end
    local expectedType = type(self.defaults[k])
    local actualType = type(opts[k])
    if expectedType ~= actualType then
      error("Invalid type for " .. k .. ": expected " .. expectedType .. ", got " .. actualType)
      return false
    end
  end
  self.defaults = vim.tbl_deep_extend('force', {}, self.defaults, opts or {})
  return true
end

function Term:cmd(cmdStr)
  if self.defaults.layout ~= 'only' then
    cmdStr = self.defaults.layout .. ' | resize 10 | ' .. cmdStr
  end
  vim.cmd(cmdStr)
end

function Term:autoStartInsert()
  if self.defaults.startinsert then
    vim.cmd('startinsert')
  end
end

function Term:createTerm()
  local cmdStr = 'term'
  if self.defaults.arg ~= '' and self.defaults.arg ~= nil then
    cmdStr = cmdStr .. ' ' .. self.defaults.arg
  end
  self:cmd(cmdStr)
  self.termBufnr = vim.api.nvim_get_current_buf()
  self:autoStartInsert()
  vim.api.nvim_set_option_value('filetype', 'terminal', { buf = self.termBufnr })
  vim.api.nvim_set_option_value('buflisted', false, { buf = self.termBufnr })
end

function Term:showTerm()
  if self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr) and curBufnr == self.termBufnr then
    local cmdStr = 'buffer ' .. self.termBufnr
    self:cmd(cmdStr)
    self:autoStartInsert()
  else
    self:createTerm()
  end
end

function Term:hideTerm()
  if self.termBufnr and self.termBufnr == vim.api.nvim_get_current_buf() then
    if self.defaults.layout == 'only' then
      vim.cmd('b#')
    else
      vim.cmd('hide')
    end
  end
end

function Term:toggleTerm(opts)
  if opts and not self:setLayout(opts) then
    return false
  end
  local curBufnr = vim.api.nvim_get_current_buf()
  if self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr) and curBufnr == self.termBufnr then
    self:hideTerm()
  else
    self:showTerm()
  end
end

return Term
