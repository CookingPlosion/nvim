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
    event = 'VeryLazy',
    -- cmd = { 'LspInstall', 'LspUnInstall' },
    opts = function(_, opts)
      opts.ensure_installed = require('utils').list_insert_unique(opts.ensure_installed, { 'lua_ls' })
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    -- cmd = { 'MasonToolsInstall', 'MasonToolsUpdate', 'MasonToolsClean', 'MasonToolsUpdateSync' },
    opts = function(_, opts)
      opts.ensure_installed = require('utils').list_insert_unique(opts.ensure_installed, { 'stylua', 'selene' })
    end,
  },
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
      ui = { title = true },
      breadcrumbs = { enable = true },
      -- implement = { enable = true, lang = { 'c' } },
    },
    keys = {
      { 'ga',         '<cmd>Lspsaga finder<cr>',                          desc = 'Open symbol finder' },
      { 'ghi',        '<cmd>Lspsaga finder imp<cr>',                      desc = 'Find all implementations' },
      { 'ghr',        '<cmd>Lspsaga finder ref<cr>',                      desc = 'Find all references' },
      { 'ghd',        '<cmd>Lspsaga finder def<cr>',                      desc = 'Find all definitions' },
      { 'gr',         '<cmd>Lspsaga rename<cr>',                          desc = 'Rename symbol' },
      { 'gR',         '<cmd>Lspsaga rename ++project<cr>',                desc = 'Rename symbol (project)' },
      { 'gd',         '<cmd>Lspsaga peek_definition<cr>',                 desc = 'Peek definition' },
      { 'gD',         '<cmd>Lspsaga goto_definition<cr>',                 desc = 'Goto definition' },
      { 'gt',         '<cmd>Lspsaga peek_type_definition<cr>',            desc = 'Peek type definition' },
      { 'gT',         '<cmd>Lspsaga goto_type_definition<cr>',            desc = 'Goto type definition' },
      { '<leader>lo', '<cmd>Lspsaga outline<cr>',                         desc = 'Show symbols int buffer' },
      { '<leader>dl', '<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>', desc = 'Show line diagnostics' },
      { '<leader>dc', '<cmd>Lspsaga show_cursor_diagnostics<cr>',         desc = 'Show cursor diagnostics' },
      { '<leader>db', '<cmd>Lspsaga show_buf_diagnostics<cr>',            desc = 'Show buffer diagnostics' },
      { '<leader>dw', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Show workspace diagnostics' },
      { '<leader>li', '<cmd>LspInfo<cr>',                                 desc = 'Show lsp info' },
      { '<leader>ll', '<cmd>LspLog<cr>',                                  desc = 'Show lsp log' },
      { '<leader>la', '<cmd>Lspsaga code_action<cr>',                     desc = 'LSP code action' },
      { '[d',         '<cmd>Lspsaga diagnostic_jump_prev<cr>',            desc = 'Jump to previous diagnostic' },
      { ']d',         '<cmd>Lspsaga diagnostic_jump_next<cr>',            desc = 'Jump to next diagnostic' },
      {
        'K',
        '<cmd>Lspsaga hover_doc<cr>',
        desc = 'Show symbol information',
        mode = { 'n', 'v' },
      },
      -- { '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', desc = 'Show symbol document', mode = { 'i' } },
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
        '[i',
        function()
          require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.INFO })
        end,
        desc = 'Jump to previous info',
      },
      {
        ']i',
        function()
          require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.INFO })
        end,
        desc = 'Jump to next info',
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      opts = function(_, opts)
        if opts.ensure_installed ~= 'all' then
          opts.ensure_installed = require('utils').list_insert_unique(opts.ensure_installed, { 'vimdoc' })
        end
      end,
    },
  },
}
