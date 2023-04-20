local G = require ("G")

-- 光标回到上次位置
G.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

-- 取消换行注释
-- 用o换行不要延续注释
G.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        -- vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        vim.opt.formatoptions = vim.opt.formatoptions
            - "o" -- O and o, don't continue comments
            + "r" -- But do continue when pressing enter.
    end,
})
