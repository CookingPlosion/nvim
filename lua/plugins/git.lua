return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  keys = {
    {
      ']g',
      function()
        require('gitsigns').nav_hunk('next')
      end,
      desc = 'Next Git hunk',
    },
    {
      '[g',
      function()
        require('gitsigns').nav_hunk('prev')
      end,
      desc = 'Previous Git hunk',
    },
    {
      '<leader>gl',
      function()
        require('gitsigns').blame_line()
      end,
      desc = 'View Git blame',
    },
    {
      '<leader>gL',
      function()
        require('gitsigns').blame_line { full = true }
      end,
      desc = 'View full Git blame',
    },
    {
      '<leader>gp',
      function()
        require('gitsigns').preview_hunk()
      end,
      desc = 'Preview Git hunk',
    },
    {
      '<leader>gh',
      function()
        require('gitsigns').reset_hunk()
      end,
      desc = 'Reset Git hunk',
    },
    {
      '<leader>gr',
      function()
        require('gitsigns').reset_buffer()
      end,
      desc = 'Reset Git buffer',
    },
    {
      '<leader>gs',
      function()
        require('gitsigns').stage_hunk()
      end,
      desc = 'Stage Git hunk',
    },
    {
      '<leader>gS',
      function()
        require('gitsigns').stage_buffer()
      end,
      desc = 'Stage Git buffer',
    },
    {
      '<leader>gu',
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      desc = 'Unstage Git hunk',
    },
    {
      '<leader>gd',
      function()
        require('gitsigns').diffthis()
      end,
      desc = 'View Git diff',
    },
  },
  opts = {
    culhl = true,
    worktrees = vim.g.git_worktrees,
  },
}
