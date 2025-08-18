local utils = require('utils')

return {
  {
    'williamboman/mason.nvim',
    keys = {
      { '<leader>pm', '<cmd>Mason<cr>',       desc = 'Mason Installer' },
      { '<leader>pM', '<cmd>MasonUpdate<cr>', desc = 'Mason Update' },
    },
    opts = function(_, opts)
      opts.ui = { width = 1, height = 1, border = 'none' }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    -- cmd = { 'LspInstall', 'LspUnInstall' },
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { 'lua_ls' })
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- cmd = { 'MasonToolsInstall', 'MasonToolsUpdate', 'MasonToolsClean', 'MasonToolsUpdateSync' },
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { 'stylua', 'selene' })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
      symbol_in_winbar = { enable = true },
      implement = { enable = true, virtual_text = true },
      finder = { layout = 'normal' },
      outline = { auto_preview = false, win_width = 40 },
    },
    keys = {
      { 'gra', '<cmd>Lspsaga code_action<cr>', desc = 'LSP code action' },
      { 'gD', '<cmd>Lspsaga peek_definition<cr>', desc = 'Peek definition' },
      { 'gd', '<cmd>Lspsaga goto_definition<cr>', desc = 'Goto definition' },
      { 'gT', '<cmd>Lspsaga peek_type_definition<cr>', desc = 'Peek type definition' },
      { 'gt', '<cmd>Lspsaga goto_type_definition<cr>', desc = 'Goto type definition' },
      { 'grt', '<cmd>Lspsaga goto_type_definition<cr>', desc = 'Goto type definition' },
      { 'grn', '<cmd>Lspsaga rename<cr>', desc = 'Rename symbol' },
      { 'grN', '<cmd>Lspsaga rename ++project<cr>', desc = 'Rename symbol (project)' },
      -- { 'ga', '<cmd>Lspsaga finder<cr>', desc = 'Open symbol finder' },
      { 'gri', '<cmd>Lspsaga finder imp<cr>', desc = 'Find all implementations' },
      { 'grr', '<cmd>Lspsaga finder ref<cr>', desc = 'Find all references' },
      { '<leader>lS', '<cmd>Lspsaga outline<cr>', desc = 'Symbols outline' },
      { '<leader>li', '<cmd>checkhealth vim.lsp<cr>', desc = 'show lsp info' },
      { '<leader>ll', '<cmd>lsplog<cr>', desc = 'show lsp log' },
      { '<leader>la', '<cmd>Lspsaga code_action<cr>', desc = 'lsp code action' },
      { '<leader>ld', '<cmd>Lspsaga show_buf_diagnostics<cr>', desc = 'show buffer diagnostics' },
      { '<leader>lD', '<cmd>Lspsaga show_workspace_diagnostics<cr>', desc = 'show workspace diagnostics' },
      { 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', desc = 'show line diagnostics' },
      { '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc = 'jump to previous diagnostic' },
      { ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', desc = 'jump to next diagnostic' },
      -- { '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', desc = 'show symbol document', mode = { 'i' } },
      {
        '[e',
        function()
          require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to previous error',
      },
      {
        ']e',
        function()
          require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to next error',
      },
      {
        '[w',
        function()
          require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = 'Jump to previous warning',
      },
      {
        ']w',
        function()
          require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = 'Jump to next warning',
      },
      {
        'K',
        '<cmd>Lspsaga hover_doc<cr>',
        desc = 'Show symbol information',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = { 'Bilal2453/luvit-meta' },
    opts = function(_, opts)
      if not opts.library then
        opts.library = {
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { path = 'lazy.nvim',          words = { 'Lazy' } },
        }
      end
    end,
  },
  {
    'OXY2DEV/helpview.nvim',
    ft = 'help',
  },
}
