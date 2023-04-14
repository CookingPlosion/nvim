local G = require ("G")

-- 光标回到上次位置
G.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

-- normal/insert模式下光标行高亮hi区分
G.cmd([[
    au InsertEnter * hi CursorLine ctermbg=235
    au InsertLeave * hi CursorLine ctermbg=none
]])
