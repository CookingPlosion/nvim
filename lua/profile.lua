local G = require('G')

-- 设置高亮当前行
G.opt.cursorline = true

-- 列不超过80
G.opt.colorcolumn = "80"

-- 显示行号
G.opt.number = true

-- 相对行号
G.opt.relativenumber = true

-- 行号宽度
G.opt.numberwidth = 2

-- 启用光标
G.opt.mouse = "a"

-- 缩进2个空格等于一个Tab
G.opt.tabstop = 4 
G.opt.softtabstop = 4
G.opt.shiftround = true
-- >> << 时移动长度
G.opt.shiftwidth = 4

-- 新行对齐当前行，空格替代tab
G.opt.expandtab = true
G.opt.autoindent = true
G.opt.smartindent = true
