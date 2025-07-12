require('lazy').setup({
  { import = 'plugins' },
  { import = 'language' },
}, {
  ui = { size = { width = 1, height = 1 }, border = 'none' },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'zipPlugin',
        'tutor',
      },
    },
  },
})
