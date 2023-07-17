local G = require('G')

local indent = 4

-- 设置编码
G.scriptencoding = 'utf-8'
G.opt.encoding = 'utf-8'
G.opt.fileencoding = 'utf-8'

-- 显示标题
G.opt.title = true

-- 显示行号
G.opt.number = true

-- 相对行号
G.opt.relativenumber = true

-- 行结尾可以跳到下一行
G.opt.whichwrap = 'b,s,[,],h'

-- 允许隐藏被修改过的buffer
G.opt.hidden = true

-- 使用可视铃声而不是响铃
G.opt.vb = true

-- 命令行补全以增强模式
G.opt.wildmenu = true

-- 高亮搜索
G.opt.hlsearch = true

-- 高亮对应括号
G.opt.showmatch = true

-- 弹出菜单的最大高度
G.opt.pumheight = 10

-- 正常显示文本(是否显示可隐藏文本)
G.opt.conceallevel = 0 

-- 保存撤销文件的位置
G.optundodir = os.getenv('HOME') .. '/.config/nvim/cache/undodir'

-- mkview 存储文件的所在目录
G.opt.viewdir = os.getenv('HOME') .. '/.config/nvim/cache/viewdir'

-- 列不超过80
-- G.opt.colorcolumn = "80"

-- 启用光标
G.opt.mouse = "a"

-- 系统剪切板
G.opt.clipboard = 'unnamed,unnamedplus'

-- 缩进4个空格等于一个Tab
G.opt.tabstop = indent 

-- 计算空格数
G.opt.softtabstop = indent

-- 移动宽度
G.opt.shiftwidth = indent

-- >> << 时移动长度
G.opt.shiftround = true

-- 使用适当数量的空格插入
G.opt.expandtab = true

-- 始终设置自动缩进
G.opt.autoindent = true

-- 自动缩进(C语言)
G.opt.smartindent = true

-- 禁止拆分行
G.opt.wrap = false

-- 终端真颜色
G.opt.termguicolors = true

-- 左侧多一列
G.opt.signcolumn = 'number'

G.opt.path:append { '**' }

-- 模糊搜索
G.opt.smartcase = true

-- 相应时间
G.opt.timeoutlen = 500

-- 关闭备份功能
G.opt.backup = false
G.opt.swapfile = false

-- split window 从下边和右边出现
G.opt.splitbelow = true
G.opt.splitright = true

-- 光标
G.cmd([[
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"
]])
