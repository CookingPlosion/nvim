return {
  {
    'numToStr/Comment.nvim',
    envenet = 'VeryLazy',
    keys = {
      {
        '<leader>//',
        function()
          require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
        end,
        desc = 'Toggle comment line',
      },
      {
        '<leader>//',
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = 'Toggle comment for selection',
        mode = 'v',
      },
    },
  },
  {
    'danymat/neogen',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>/f',
        "<cmd>lua require('neogen').generate({ type = 'func' })<cr>",
        desc = 'Function annotation documentation',
      },
      {
        '<leader>/c',
        "<cmd>lua require('neogen').generate({ type = 'class' })<cr>",
        desc = 'Class annotation documentation',
      },
      {
        '<leader>/F',
        "<cmd>lua require('neogen').generate({ type = 'file' })<cr>",
        desc = 'File annotation documentation',
      },
      {
        '<leader>/t',
        "<cmd>lua require('neogen').generate({ type = 'type' })<cr>",
        desc = 'Type annotation documentation',
      },
    },
    opts = {
      enabled = true,
    },
  },
}
