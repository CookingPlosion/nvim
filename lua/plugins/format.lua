return {
  'stevearc/conform.nvim',
  event = 'LspAttach',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      desc = 'Format buffer',
      mode = { 'n', 'v' },
    },
  },
  opts = {
    formatters = {
      cmake_format = {
        -- prepend_args = { '--tab-size', '4', '--line-width', '80' },
      },
    },

    formatters_by_ft = {
      c = { 'clang-format' },
      -- 这里的 'cmake_format' 会自动使用上面我们修改过的版本
      cmake = { 'cmake_format' },
      cpp = { 'clang-format' },
      lua = { 'stylua' },
      qml = { 'qmlls' },
    },
  },
}
