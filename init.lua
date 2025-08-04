require('config.options')
require('config.autocmds')
require('config.keymaps')
require('config.lazy')
-- require('config.lsp')
-- Load user defined settings after Lazy initialization
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    vim.schedule(function()
      require('config.lsp')
    end)
  end,
})
