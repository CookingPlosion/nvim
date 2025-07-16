return {
  'sapnvim/sapnvim_project.nvim',
  event = 'VeryLazy',
  -- dir = '~/code/sapnvim_project.nvim/',
  keys = {
    { '<leader>sc', '<cmd>ProjectClose<cr>', desc = 'Close curret project' },
    { '<leader>sa', '<cmd>ProjectAdd<cr>', desc = 'Create a project' },
    { '<leader>sw', '<cmd>ProjectSave<cr>', desc = 'Save existing project' },
    { '<leader>sf', '<cmd>ProjectLoad<cr>', desc = 'Switch a project' },
    { '<leader>so', '<cmd>ProjectToggle<cr>', desc = 'Toggle project' },
  },
  opts = function(_, _)
    return {
      --- The address where the project is stored
      --- Useing Lazy.nvim, default: '~/.local/share/nvim/lazy/sapnvim_project.nvim/sessions'
      --- no Using Lazy.nvim, details: 'vim.fn.stdpath("config") .. "/sessions"'
      sessions_storage_dir = '~/.local/share/nvim/lazy/sapnvim_project.nvim/sessions',

      --- This is a data file
      --- Records the projects that have been saved in the project storage directory
      sessions_data_filename = 'sessions_data.lua',

      --- This is a setting related to session saving in Vim/Neovim
      --- View details :h sessionoptions
      sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' },

      -- auto_session_restore = 'last',

      picker = 'telescope',
    }
  end,
}
