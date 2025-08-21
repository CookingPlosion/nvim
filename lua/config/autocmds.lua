local api = vim.api

-- 光标回到上次位置
vim.api.nvim_command([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

-- 取消换行注释
-- 用o换行不要延续注释
api.nvim_create_augroup('Sapnvim_edit', { clear = true })
api.nvim_create_autocmd({ 'BufEnter' }, {
  desc = 'O and o, do not continue with the comment, but continue when you hit the enter key.',
  pattern = { '*' },
  group = 'Sapnvim_edit',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      - 'o' -- O and o, don't continue comments
      + 'r' -- But do continue when pressing enter.
  end,
})

api.nvim_create_augroup('Sapnvim_bufs', { clear = true })
api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'Auto close some filetypes with <q>',
  group = 'Sapnvim_bufs',
  pattern = { 'saga*', 'help', 'qf', 'gitsigns*', 'checkhealth' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>bd<cr>', { silent = true, buffer = true, desc = 'quit the bufer' })
  end,
})
api.nvim_create_autocmd({ 'BufEnter' }, {
  desc = 'Option to disable specific file types',
  group = 'Sapnvim_bufs',
  callback = function()
    if vim.tbl_contains({ 'sagafinder', 'sagaoutline', 'help' }, vim.bo.filetype) then
      vim.opt_local.foldcolumn = '0'
      vim.opt_local.list = false
      vim.opt_local.number = false
    end
  end,
})

-- Highlight on yank
api.nvim_create_augroup('Sapnvim_yank', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight on yank',
  group = 'Sapnvim_yank',
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})
-- wsl ceil
if vim.fn.has('wsl') == 1 then
  api.nvim_create_autocmd('TextYankPost', {
    desc = 'Copying text using windows clip.exe',
    group = 'Sapnvim_yank',
    callback = function()
      vim.fn.system('/mnt/c/windows/system32/clip.exe ', vim.fn.getreg('"'))
    end,
  })
end

api.nvim_create_augroup('Sapnvim_diagnostic', { clear = true })
api.nvim_create_autocmd({ 'BufLeave' }, {
  desc = 'Refresh qfline Diagnostic',
  group = 'Sapnvim_diagnostic',
  callback = function()
    if vim.bo.filetype == 'qf' then
      vim.cmd.wincmd('p')
    end
  end,
})
