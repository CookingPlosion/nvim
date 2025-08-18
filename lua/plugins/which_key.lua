return {
  'folke/which-key.nvim',
  event = 'bufEnter',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer local keymaps',
    },
  },
  opts = function(_, opts)
    local wk = require('which-key')
    wk.add({
      { '<leader>/', group = 'Comments' },
      { '<leader>b', group = 'Load Buffers' },
      { '<leader>f', group = 'Find Files' },
      { '<leader>g', group = 'Git Actions' },
      { '<leader>l', group = 'LSP Tools' },
      { '<leader>p', group = 'Packages' },
      { '<leader>s', group = 'Projects' },
      { 'gr', group = 'LSP Actions' },
    })

    opts.win = {
      no_overlap = false,
    }
    opts.icons = {
      mappings = false,
      group = '+',
      separator = '-',
    }
    opts.layout = {
      width = { min = 20 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    }
  end,
}
