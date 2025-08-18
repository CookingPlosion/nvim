local g = vim.g
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '
g.git_worktrees = nil
g.max_file = { size = 1024 * 100, lines = 10000 }
g.icons_enabled = false
g.diagnostic_line_info = false
g.diagnostic_text_info = false
g.diagnostic_qflist = false -- Use qflist to view diagnostic information in the buffer

-- opt.formatexpr =
-- opt.formatoptions =

opt.autowrite = false -- 关闭离开buffer的自动保存
opt.breakindent = true
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
opt.cmdheight = 1
opt.colorcolumn = '0'
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 0
opt.confirm = true
opt.copyindent = true
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = 'utf-8'
opt.fillchars = { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '/', eob = ' ' }
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.infercase = true
opt.jumpoptions = 'view'
opt.laststatus = 3
opt.linebreak = true
opt.list = true
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 1
opt.preserveindent = true
opt.pumblend = 100
opt.pumheight = 10
opt.relativenumber = false
opt.ruler = false
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmatch = true
opt.showmode = true
opt.signcolumn = 'no'
opt.smartcase = true
opt.smartindent = true
opt.smoothscroll = true
opt.spelllang = { 'en' }
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.statuscolumn = ''
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 500
opt.undodir = os.getenv('HOME') .. '/.config/nvim/cache/undodir'
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 300
opt.viewdir = os.getenv('HOME') .. '/.config/nvim/cache/viewdir'
opt.virtualedit = 'block'
opt.wildmode = 'longest:full,full'
opt.winminwidth = 5
opt.wrap = false
opt.writebackup = false
opt.winborder = 'single'
vim.bo.indentexpr = 'nvim_treesitter#indent()'
vim.opt.backspace:append { 'nostop' } -- don't stop backspace at insert
if vim.fn.has 'nvim-0.9' == 1 then
  vim.opt.diffopt:append 'linematch:60' -- enable linematch diff algorithm
end
-- 行结尾可以跳到下一行
-- vim.opt.whichwrap = 'b,s,[,],h'

-- vim.opt.viewoptions:remove "curdir"    -- disable saving current directory with views
--   g = {
--     -- AstroNvim specific global options
--     autoformat_enabled = true,                       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
--     autopairs_enabled = true,                        -- enable autopairs at start
--     cmp_enabled = true,                              -- enable completion at start
--     codelens_enabled = true,                         -- enable or disable automatic codelens refreshing for lsp that support it
--     diagnostics_mode = 3,                            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
--     highlighturl_enabled = true,                     -- highlight URLs by default
--     icons_enabled = true,                            -- disable icons in the UI (disable if no nerd font is available)
--     inlay_hints_enabled = true,                      -- enable or disable LSP inlay hints on startup (Neovim v0.10 only)
--     lsp_handlers_enabled = true,                     -- enable or disable default vim.lsp.handlers (hover and signature help)
--     semantic_tokens_enabled = true,                  -- enable or disable LSP semantic tokens on startup
--     ui_notifications_enabled = true,                 -- disable notifications (TODO: rename to  notifications_enabled in AstroNvim v4)
--   },
--   -- t = vim.t.bufs and vim.t.bufs or { bufs = vim.api.nvim_list_bufs() }, -- initialize buffers for the current tab
-- }
