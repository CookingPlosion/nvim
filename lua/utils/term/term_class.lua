-- utils/term.lua
local Term = {}

local layout_config = {
  only = function()
    return {
      relative = 'editor',
      row = math.floor((vim.o.lines - vim.o.lines * 1 - vim.o.cmdheight - 1) / 2),
      col = math.floor((vim.o.columns - vim.o.columns * 1) / 2),
      width = math.floor(vim.o.columns * 1),
      height = math.floor(vim.o.lines * 1 - vim.o.cmdheight - 1),
      border = 'none',
    }
  end,
  float = function()
    return {
      relative = 'editor',
      row = math.floor((vim.o.lines - vim.o.lines * 0.8 - vim.o.cmdheight - 1) / 2),
      col = math.floor((vim.o.columns - vim.o.columns * 0.8) / 2),
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8 - vim.o.cmdheight - 1),
      border = 'single',
    }
  end,
  vsplit = function()
    return { width = math.floor(vim.o.columns * 0.8) }
  end,
  split = function()
    return { height = math.floor(vim.o.lines * 0.3) }
  end,
}

local defaults = { layout_strategy = 'vsplit', layout_config = layout_config, startinsert = true }

local env =
  { EDITOR = 'nvim --server ' .. vim.env.HOME .. '/.cache/nvim/server_' .. vim.fn.getpid() .. '.pipe --remote ' }

local layout_handlers = {
  vsplit = function(self)
    vim.cmd.vsplit()
    local winid = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_width(winid, self.opts.layout_config.vsplit().width)
    return winid
  end,
  split = function(self)
    vim.cmd.split()
    local winid = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(winid, self.opts.layout_config.split().height)
    return winid
  end,
  only = function(self)
    return vim.api.nvim_open_win(self.termBufnr, true, self.opts.layout_config.only())
  end,
  float = function(self)
    return vim.api.nvim_open_win(self.termBufnr, true, self.opts.layout_config.float())
  end,
}

local function validateOpts(opts)
  if opts == nil then
    return true
  end
  for k, v in pairs(opts) do
    if defaults[k] == nil then
      error(k .. ' is not a valid configuration option')
      return false
    end
    if type(defaults[k]) ~= type(v) then
      error('Invalid type for ' .. k .. ': expected ' .. type(defaults[k]) .. ', got ' .. type(v))
      return false
    end
  end
  return true
end

function Term:new(term)
  term = term or {}
  self.__index = self
  term.name = term.name or 'SapnvimTmpTerm'
  term.termBufnr = nil
  term.winid = nil
  term.augroup = 'TermInstance_' .. tostring(term)
  term.autocmd_ids = {}
  term.cmdStr = term.cmdStr or {}
  term.env = vim.tbl_deep_extend('force', {}, env, term.env or {})
  term.opts = term.opts or {}
  assert(validateOpts(term.opts))
  term.opts = vim.tbl_deep_extend('force', {}, defaults, term.opts)
  term.on_stdout = function() end
  term.on_stderr = function() end
  local instance = setmetatable(term, self)

  vim.api.nvim_create_augroup(instance.augroup, { clear = true })

  instance.autocmd_ids.resize = vim.api.nvim_create_autocmd('VimResized', {
    group = instance.augroup,
    callback = function()
      instance:recalculate_layout()
    end,
  })

  instance.autocmd_ids.bufenter = vim.api.nvim_create_autocmd('BufEnter', {
    group = instance.augroup,
    nested = true,
    callback = function(args)
      if instance.winid and vim.api.nvim_win_is_valid(instance.winid) and args.buf ~= instance.termBufnr then
        if vim.api.nvim_get_current_win() == instance.winid then
          instance:hideTerm()
          vim.api.nvim_set_current_buf(args.buf)
        end
      end
    end,
  })

  return instance
end

function Term:destroy(force)
  if self.autocmd_ids then
    for _, id in pairs(self.autocmd_ids) do
      vim.api.nvim_del_autocmd(id)
    end
    self.autocmd_ids = nil
  end
  vim.api.nvim_del_augroup_by_name(self.augroup)
  if self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr) then
    vim.cmd((force and 'bd! ' or 'bd ') .. self.termBufnr)
  end
  self.termBufnr, self.winid, self.opts = nil, nil, nil
end

function Term:recalculate_layout()
  if not (self.winid and vim.api.nvim_win_is_valid(self.winid)) then
    return
  end
  local strategy = self.opts.layout_strategy
    local config_generator = self.opts.layout_config[strategy]
    if config_generator then
      vim.api.nvim_win_set_config(self.winid, config_generator())
    end
end

function Term:open_win()
  if self.winid and vim.api.nvim_win_is_valid(self.winid) then
    return self.winid
  end
  if not (self.termBufnr and vim.api.nvim_buf_is_valid(self.termBufnr)) then
    self.termBufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value('filetype', 'terminal', { buf = self.termBufnr })
  end
  local strategy = self.opts.layout_strategy
  local handler = layout_handlers[strategy]
  if not handler then
    error('Unknown layout strategy: ' .. tostring(strategy))
    return
  end
  self.winid = handler(self)
  if strategy == 'vsplit' or strategy == 'split' then
    vim.api.nvim_win_set_buf(self.winid, self.termBufnr)
  end
  return self.winid
end

function Term:autoStartInsert()
  if self.opts.startinsert then
    vim.cmd.startinsert()
  end
end

function Term:showTerm()
  local winid = self:open_win()
  if not winid then
    return
  end
  vim.api.nvim_set_current_win(winid)
  local job_id = vim.b[self.termBufnr] and vim.b[self.termBufnr].terminal_job_id
  if not (job_id and job_id > 0) then
    vim.fn.jobstart(self.cmdStr, {
      term = true,
      env = self.env,
      on_stdout = self.on_stdout,
      on_stderr = self.on_stderr,
    })
  end
  self:autoStartInsert()
end

function Term:hideTerm()
  if self.winid and vim.api.nvim_win_is_valid(self.winid) then
    vim.api.nvim_win_close(self.winid, false)
    self.winid = nil
  end
end

function Term:toggleTerm()
  if self.winid and vim.api.nvim_win_is_valid(self.winid) then
    self:hideTerm()
  else
    self:showTerm()
  end
end

return Term
