return {
  'sapnvim/sapnvim_project.nvim',
  -- dir = '~/code/sapnvim_project.nvim/',
  dependencies = {
    { 'fzf-lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'echasnovski/mini.icons' },
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
      sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },

      auto_session_restore = 'last',

      picker = 'telescope',
    }
  end
}
