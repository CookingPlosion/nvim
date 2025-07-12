return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed =
          require('utils').list_insert_unique(opts.ensure_installed, { 'qmljs' })
      end
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- event = 'VeryLazy',
    -- cmd = { 'MasonToolsInstall', 'MasonToolsUpdate', 'MasonToolsClean', 'MasonToolsUpdateSync' },
    opts = function(_, opts)
      opts.ensure_installed = require('utils').list_insert_unique(opts.ensure_installed, { 'qmlls' })
    end,
  },
  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   opts = function(_, opts)
  --     opts.ensure_installed = require('utils').list_insert_unique(opts.ensure_installed, { 'clangd', 'neocmake', })
  --   end,
  -- },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local server = {
        qmlls = {
          capabilities = { general = { positionEncodings = { 'utf-8' } } },
          cmd = { 'qmlls' },
        },
      }
      opts.servers = require('utils').table_insert_unique_keys(opts.servers, server)
    end,
  },
}
