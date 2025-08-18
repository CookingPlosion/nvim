local api = vim.api

-- 光标回到上次位置
vim.api.nvim_command([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

-- 取消换行注释
-- 用o换行不要延续注释
api.nvim_create_augroup('Sapnvim_edit', { clear = true })
api.nvim_create_autocmd({ 'BufEnter' }, {
  desc = "O and o, do not continue with the comment, but continue when you hit the enter key.",
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
  desc = "Auto close some filetypes with <q>",
  group = 'Sapnvim_bufs',
  pattern = { 'sagaoutline', 'help', 'qf' },
  callback = function()
    if vim.tbl_contains({ 'sagaoutline', 'help' }, vim.bo.filetype) then
      vim.opt_local.foldcolumn = '0'
    end
    vim.opt_local.list = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { silent = true, buffer = true })
  end,
})
-- api.nvim_create_autocmd('CursorHold', {
--   desc = 'Dynamically adjust scrolloff when cursor settles',
--   group = 'Sapnvim_bufs',
--   callback = function()
--     if not vim.tbl_contains({ 'terminal' }, vim.bo.filetype) then
--       local height = vim.api.nvim_win_get_height(0)
--       if height > 2 then
--         local new_scrolloff = math.floor(height / 2) - 1
--         if vim.wo.scrolloff ~= new_scrolloff then
--           vim.wo.scrolloff = new_scrolloff
--         end
--       end
--     end
--   end,
-- })

-- Highlight on yank
api.nvim_create_augroup('Sapnvim_yank', { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight on yank",
  group = 'Sapnvim_yank',
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})
-- wsl ceil
if vim.fn.has('wsl') == 1 then
  api.nvim_create_autocmd('TextYankPost', {
    desc = "Copying text using windows clip.exe",
    group = 'Sapnvim_yank',
    callback = function()
      vim.fn.system('/mnt/c/windows/system32/clip.exe ', vim.fn.getreg('"'))
    end,
  })
end

api.nvim_create_augroup('Sapnvim_diagnostic', { clear = true })
api.nvim_create_autocmd({ 'BufLeave' }, {
  desc = "Refresh qfline Diagnostic",
  group = 'Sapnvim_diagnostic',
  callback = function()
    if vim.bo.filetype == 'qf' then
      vim.cmd.wincmd('p')
    end
  end
})

-- -- 清空 quickfix 列表
-- vim.fn.setqflist({}, 'r')
--
-- -- 设置诊断结果
-- local diagnostics = vim.diagnostic.get(0)
-- local qf_items = {}
-- for _, d in ipairs(diagnostics) do
--   table.insert(qf_items, {
--     bufnr = d.bufnr,
--     lnum = d.lnum + 1,
--     col = d.col + 1,
--     text = d.message,
--     type = ({
--       [vim.diagnostic.severity.ERROR] = 'E',
--       [vim.diagnostic.severity.WARN] = 'W',
--       [vim.diagnostic.severity.INFO] = 'I',
--       [vim.diagnostic.severity.HINT] = 'H',
--     })[d.severity] or 'E'
--   })
-- end
-- vim.fn.setqflist(qf_items, 'r')
-- 根据文件类型设置缩进
-- vim.cmd [[
--   augroup Indentation
--     autocmd!
--     autocmd FileType python,java,ruby,go,swift,rust,php,html,css setlocal shiftwidth=4
--   augroup END
-- ]]

-- -- 自动在 nvim 启动时运行该函数
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = utils.open_the_current_directory,
-- })
