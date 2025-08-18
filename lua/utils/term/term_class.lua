-- utils/term.lua
local Term = {}
local defaults = {
  layout = 'only',
  size = 0,
  cmdStr = {},
  arg = '',
  startinsert = true,
}

local env = {
  EDITOR = 'nvim --server ' .. vim.env.HOME .. '/.cache/nvim/server_' .. vim.fn.getpid() .. '.pipe --remote '
}

local function validateOpts(opts)
  if opts == nil then return true end
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

function Term:new(term)
  term = term or {}
  self.__index = self
  term.name = term.name or 'SapnvimTmpTerm'
  term.termBufnr = term.termBufnr or nil
  term.env = vim.tbl_deep_extend('force', {}, env, term.env or {})
  term.opts = term.opts or {}
  assert(validateOpts(term.opts))
  term.opts = vim.tbl_deep_extend('force', {}, defaults, term.opts)
  term.on_stdout = function() end
  term.on_stderr = function() end
  return setmetatable(term, self)
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
  self.opts = nil
end

function Term:setLayout(opts)
  for k, _ in pairs(opts) do
    if self.opts[k] == nil then
      error(k .. " is not a valid configuration option")
      return false
    end
    local expectedType = type(self.opts[k])
    local actualType = type(opts[k])
    if expectedType ~= actualType then
      error("Invalid type for " .. k .. ": expected " .. expectedType .. ", got " .. actualType)
      return false
    end
  end
  self.opts = vim.tbl_deep_extend('force', {}, self.defaults, opts or {})
  return true
end

function Term:cmd(cmdStr)
  if self.opts.layout ~= 'only' then
    cmdStr = self.opts.layout .. ' | resize 10 | ' .. cmdStr
  end
  vim.cmd(cmdStr)
end

function Term:autoStartInsert()
  if self.opts.startinsert then
    vim.cmd('startinsert')
  end
end

function Term:createTerm()
  local bufnr = vim.api.nvim_create_buf(false, true)
  self.termBufnr = bufnr
  vim.api.nvim_set_option_value('filetype', 'terminal', { buf = self.termBufnr })
  vim.api.nvim_set_current_buf(self.termBufnr)
  local job_id = vim.fn.jobstart(self.opts.cmdStr, {
    term = true,
    env = self.env,
    on_stdout = self.on_stdout,
    on_stderr = self.on_stderr
  })
  self:autoStartInsert()
  print(job_id)
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
    if self.opts.layout == 'only' then
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
