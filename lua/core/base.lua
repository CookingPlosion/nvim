-- 设置缩进长度
local indent = 4

-- 设置编码
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- 显示标题
vim.opt.title = true

-- 显示行号
vim.opt.number = true

-- 相对行号
vim.opt.relativenumber = true

-- 行结尾可以跳到下一行
vim.opt.whichwrap = 'b,s,[,],h'

-- 允许隐藏被修改过的buffer
vim.opt.hidden = true

-- 使用可视铃声而不是响铃
vim.opt.vb = true

-- 命令行补全以增强模式
vim.opt.wildmenu = true

-- 高亮搜索
vim.opt.hlsearch = true

-- 高亮对应括号
vim.opt.showmatch = true

-- 弹出菜单的最大高度
vim.opt.pumheight = 10

-- 正常显示文本(是否显示可隐藏文本)
vim.opt.conceallevel = 0

-- 保存撤销文件的位置
vim.optundodir = os.getenv('HOME') .. '/.config/nvim/cache/undodir'

-- mkview 存储文件的所在目录
vim.opt.viewdir = os.getenv('HOME') .. '/.config/nvim/cache/viewdir'

-- 列不超过80
-- G.opt.colorcolumn = "80"

-- 启用光标
vim.opt.mouse = "a"

-- 系统剪切板
vim.opt.clipboard = 'unnamed,unnamedplus'

-- 缩进4个空格等于一个Tab
vim.opt.tabstop = indent

-- 计算空格数
vim.opt.softtabstop = indent

-- 移动宽度
vim.opt.shiftwidth = indent

-- >> << 时移动长度
vim.opt.shiftround = true

-- 使用适当数量的空格插入
vim.opt.expandtab = true

-- 始终设置自动缩进
vim.opt.autoindent = true

-- 自动缩进(C语言)
vim.opt.smartindent = true

-- 禁止拆分行
vim.opt.wrap = false

-- 设置status line(底部状态栏)为global bottom(总是最下面)
vim.opt.laststatus = 3

-- 左侧多一列
vim.opt.signcolumn = 'number'

-- 设置遍历所有子目录
vim.opt.path:append { '**' }

-- 模糊搜索
vim.opt.smartcase = true

-- 相应时间
-- vim.opt.timeoutlen = 500

-- 关闭备份功能
vim.opt.backup = false
vim.opt.swapfile = false

-- split window 从下边和右边出现
vim.opt.splitbelow = true
vim.opt.splitright = true

-- 高亮当前行
vim.opt.cursorline = true

-- 终端真颜色
vim.opt.termguicolors = true

-- 垂直(补全)弹出列表
vim.opt.wildoptions = 'pum'

-- 背景颜色
vim.opt.background = 'dark'

-- 启用浮动窗口的伪透明度(0~100)
vim.opt.winblend = 0

-- 启用弹出菜单的伪透明度(0~100)
vim.opt.pumblend = 0

-- 光标
vim.cmd([[
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"
]])
