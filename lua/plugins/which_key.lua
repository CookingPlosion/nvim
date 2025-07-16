return {
  "folke/which-key.nvim",
  event = 'bufEnter',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer local keymaps (which-key)',
    },
  },
  opts = function(_, opts)
    opts.win = {
      no_overlap = false,
    }
    opts.icons = {
      mappings = false,
      group = vim.g.icons_enabled ~= false and "" or "+",
      separator = "-",
    }
    opts.layout = {
      width = { min = 20 }, -- min and max width of the columns
      spacing = 3,          -- spacing between columns
    }
  end,
}
