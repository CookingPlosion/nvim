return {
  cmd = { 'qmlls' },
  filetypes = { 'qml', 'qmljs' },
  -- root_markers = function(fname)
  --   return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
  -- end,
  root_markers = {
    '.git',
  },
  single_file_support = true,
}
