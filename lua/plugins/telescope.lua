return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    'nvim-telescope/telescope-file-browser.nvim',
    'jonarrien/telescope-cmdline.nvim'
  },
  keys = {
    { '<leader>fc', '<cmd>Telescope cmdline<cr>', desc = 'cmdline' },
  },
  config = function(_, opts)
    require('telescope').load_extension('cmdline')
  end
}
