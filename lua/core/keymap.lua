-- 快捷键设置

-- 快捷键前缀键(类似于Ctrl)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 将常用按键(容易错的)替换
vim.cmd([[
    cnoreabbrev Q q
    cnoreabbrev q1 q!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev Qa qa
    cnoreabbrev Qa! qa!
    cnoreabbrev Qa1 qa!
    cnoreabbrev Qall qall
    cnoreabbrev Qall! qall!
    cnoreabbrev W w
    cnoreabbrev W! w!
    cnoreabbrev w1 w!
    cnoreabbrev W1 w!
    cnoreabbrev WQ wq
    cnoreabbrev WQ1 wq!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ wq
    cnoreabbrev wQ1 wq!
    cnoreabbrev wq1 wq!
    cnoreabbrev Y y
    cnoreabbrev N n
]])

-- 定义一个存放快捷键的函数
local function keymap(maps)
    for _,map in pairs(maps) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
    end
end

-- 自定义快捷键(按以下方式添加)
keymap({
    -- -------------------------------- 插入模式 -------------------------------- --
    { 'i', 'jk',            '<ESC>',                                            {} },

    -- -------------------------------- 视觉模式 -------------------------------- --
    { 'v', 'J',             ":m '>+1<CR>gv=gv",                                 {} },
    { 'v', 'K',             ":m '<-2<CR>gv=gv",                                 {} },
    { 'v', 'jk',            '<ESC>',                                            {} },

    -- -------------------------------- 普通模式 -------------------------------- --
    -- 修改默认快捷键
    { "n", '<leader>nh',    ':nohl<CR>',                                        {} },
    -- 插件快捷键
    { 'n', "<leader>F",     '<cmd>Neotree toggle buffers<CR>',                  {} },
    { 'n', "<leader>f",     '<cmd>Neotree toggle<CR>',                          {} },
    { 'n', "<leader>fr",    '<cmd>Neotree toggle reveal_force_cwd<CR>',         {} },
    -- 自定义功能
    { 'n', '<leader>aa',    ':lua _G.Me_Sudo_write()<CR>',                      { silent = true } },
    -- 更新相关
    { 'n', '<leader>lil',   ':LspInfo<CR>',                                     {} },
    { 'n', '<leader>lim',   ':Mson<CR>',                                        {} },
    { 'n', '<leader>lip',   ':Lazy<CR>',                                        {} },
    { 'n', '<leader>lll',   ':LspLog<CR>',                                      {} },
    { 'n', '<leader>llm',   ':MasonLog<CR>',                                    {} },
    { 'n', '<leader>lul',   ':Lazy update<CR>',                                 {} },
    { 'n', '<leader>lum',   ':MasonUpdate<CR>',                                 {} },
})
