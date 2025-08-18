local utils = require('utils')

local servers = { 'clangd', 'neocmake', 'qmlls' }
local parsers = { 'cpp', 'objc', 'cuda', 'cmake', 'qmljs' }

-- install treesitter parser packages
local installed_parsers = require('nvim-treesitter.info').installed_parsers()
require('nvim-treesitter.configs').setup({
  ensure_installed = utils.list_insert_unique(installed_parsers, parsers),
})

-- install language servers
local installed_servers = require('mason-lspconfig').get_installed_servers()
require('mason-lspconfig').setup({
  ensure_installed = utils.list_insert_unique(installed_servers, servers),
})

-- enable lsp servsers
vim.lsp.enable(servers)

vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.diagnostic.handlers['qflist'] = {
  show = function(ns, _, _, opts)
    vim.diagnostic.setqflist({ namespace = ns, open = opts.qflist.open or false })
  end,

  -- hide = function()
  --   vim.cmd('cclose')
  -- end
}

-- Open the location list on every diagnostic change (warnings/errors only).
vim.diagnostic.config({
  ['qflist'] = {
    open = vim.g.diagnostic_qflist, -- view :h diagnostic-handlers
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarning',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarning',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    },
  },
  virtual_text = vim.g.diagnostic_text_info,
  virtual_lines = vim.g.diagnostic_line_info,
  severity_sort = true,
})

-- 2. 创建一个更完整的命令系统
vim.api.nvim_create_user_command('DiagQF', function(opts)
  local args = opts.args
  local ns = vim.diagnostic.get_namespaces()

  local actions = {
    -- 打开 quickfix 列表
    open = function()
      vim.diagnostic.setqflist(ns)
      vim.cmd.wincmd('p')
    end,

    -- 关闭 quickfix 列表
    close = function()
      vim.cmd('cclose')
    end,

    -- 切换 quickfix 列表
    toggle = function()
      if not vim.g.diagnostic_qflist then
        vim.diagnostic.setqflist(ns)
        vim.cmd.wincmd('p')
        vim.diagnostic.config({ virtual_lines = true })
        vim.g.diagnostic_qflist = true
      else
        vim.cmd('cclose')
        vim.diagnostic.config({ virtual_lines = false })
        vim.g.diagnostic_qflist = false
      end
    end,
  }

  if actions[args] then
    actions[args]()
  else
    vim.notify('请使用: open, close, 或 toggle', vim.log.levels.ERROR)
  end
end, {
  desc = '管理诊断 quickfix 列表',
  nargs = 1,
  complete = function()
    return { 'open', 'close', 'toggle' }
  end,
})
