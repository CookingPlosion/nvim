return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  keys = function()
    local gitsigns = require('gitsigns')
    return {
      {
        ']c',
        function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end,
        desc = 'Next Git hunk',
      },
      {
        '[c',
        function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end,
        desc = 'Previous Git hunk',
      },
      {
        '<leader>gl',
        gitsigns.blame_line,
        desc = 'View Git blame',
      },
      {
        '<leader>gL',
        function()
          gitsigns.blame_line { full = true }
        end,
        desc = 'View full Git blame',
      },
      {
        '<leader>gp',
        gitsigns.preview_hunk,
        desc = 'Preview Git hunk',
      },
      {
        '<leader>gr',
        function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        mode = 'v',
        desc = 'Reset Git hunk in virtual',
      },
      {
        '<leader>gr',
        gitsigns.reset_hunk,
        desc = 'Reset Git hunk',
      },
      {
        '<leader>gR',
        gitsigns.reset_buffer,
        desc = 'Reset Git buffer',
      },
      {
        '<leader>gs',
        function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end,
        mode = 'v',
        desc = 'Stage Git hunk in virtual',
      },
      {
        '<leader>gs',
        gitsigns.stage_hunk,
        desc = 'Stage Git hunk',
      },
      {
        '<leader>gS',
        gitsigns.stage_buffer,
        desc = 'Stage Git buffer',
      },
      {
        '<leader>gd',
        gitsigns.diffthis,
        desc = 'View Git diff',
      },
      {
        '<leader>gh',
        gitsigns.select_hunk,
        desc = 'Select Git hunk',
      },
    }
  end,
  opts = {
    worktrees = vim.g.git_worktrees,
  },
}
