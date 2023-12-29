-- 光标回到上次位置
vim.api.nvim_command([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

-- 取消换行注释
-- 用o换行不要延续注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    -- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    vim.opt.formatoptions = vim.opt.formatoptions
        - "o"     -- O and o, don't continue comments
        + "r"     -- But do continue when pressing enter.
  end,
})

-- 高亮当前编辑文件(默认情况下: 使用cursorline会高亮所有文件)
vim.cmd [[
    augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    augroup END
]]


-- 根据文件类型设置缩进
vim.cmd[[
  augroup Indentation
    autocmd!
    autocmd FileType python,java,c,cpp,ruby,go,swift,rust,php,html,css setlocal shiftwidth=4
  augroup END
]]
