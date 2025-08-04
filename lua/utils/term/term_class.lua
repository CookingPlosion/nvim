-- utils/term.lua
local Term = {}
Term.__index = Term
local defaults = {
  layout = 'only',
  size = 0,
  arg = '',
  startinsert = true,
}

function Term:validateOpts(opts)
  for k, v in pairs(opts) do
    if defaults[k] == nil then
      error(k .. " is not a valid configuration option")
      return false
    end
    if type(defaults[k]) ~= type(v) then
      error("Invalid type for " .. k .. ": expected " .. type(defaults[k]) .. ", got " .. type(v))
      return false
    end
  end
  return true
end

function Term:new(name, opts)
  name = name or 'SapnvimTmpTerm'
  opts = opts or {}
  assert(self:validateOpts(opts))
  local obj = {
    name = name,
    termBufnr = nil,
    defaults = vim.tbl_deep_extend('force', {}, defaults, opts)
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
  if self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr) then
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

function Term:toggleTerm()
  local curBufnr = vim.api.nvim_get_current_buf()
  if self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr) and curBufnr == self.termBufnr then
    self:hideTerm()
  else
    self:showTerm()
  end
end

return Term
