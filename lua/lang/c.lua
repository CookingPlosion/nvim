local utils = require('utils')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= 'all' then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { 'cpp', 'c', 'objc', 'cuda', 'proto' })
      end
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    -- cmd = { 'LspInstall', 'LspUnInstall' },
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { 'clangd' })
    end,
  },
}
