return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed =
          require('utils').list_insert_unique(opts.ensure_installed, { 'c', 'cpp', 'objc', 'cuda' })
      end
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      opts.ensure_installed = require('utils').list_insert_unique(opts.ensure_installed, { 'clangd' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local server = {
        clangd = {
          capabilities = { general = { positionEncodings = { 'utf-8' } } },
          cmd = { 'clangd', '--clang-tidy' },
        },
      }
      opts.servers = require('utils').table_insert_unique_keys(opts.servers, server)
    end,
  },
}
