-- set mapping
local utils = require("etouse.utils")
local is_available = utils.is_available
local maps = require("etouse.utils").empty_map_table()

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

-- Standard Operatons
maps.i["jk"] = { "<ESC>", desc = "Quit insert mode" }
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" }
maps.n["<leader>Q"] = { "<cmd>confirm qall<cr>", desc = "Quit all" }
maps.n["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>qa!<cr>", desc = "Force quit" }
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }
-- TODO: Remove when dropping support for <Neovim v0.10
if not vim.ui.open then maps.n["gx"] = { utils.system_open, desc = "Open the file under cursor with system app" } end

-- Comment
if is_available "Comment.nvim" then
  maps.n["<leader>/"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Toggle comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment for selection",
  }
end

-- NeoTree
if is_available then
  maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<leader>o"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end,
    desc = "Toggle Explorer Focus",
  }
end

-- 自定义快捷键(按以下方式添加)
-- keymap({
--     -- -------------------------------- 插入模式 -------------------------------- --
--     { 'i', 'jk',         '<ESC>',                                    {} },
--
--     -- -------------------------------- 视觉模式 -------------------------------- --
--     { 'v', '<C-p>',      ":m '>+1<CR>gv=gv",                         {} },
--     { 'v', '<C-n>',      ":m '<-2<CR>gv=gv",                         {} },
--
--     -- -------------------------------- 普通模式 -------------------------------- --
--     { 'n', '<leader>q',  ':qa!<CR>',                                 {} },
--     { 'n', '<leader>w',  ':w<CR>',                                   {} },
--     -- 修改默认快捷键
--     { "n", '<leader>nh', ':nohl<CR>',                                {} },
--     -- neo tree
--     { 'n', "<leader>e",  '<cmd>Neotree toggle reveal_force_cwd<CR>', {} },
--     { 'n', '<leader>x',  ':lua Neotree_switch_focus()<CR>',                {} },
--
--     -- 自定义功能
--     { 'n', '<leader>aa', ':lua _G.Me_Sudo_write()<CR>',              { silent = true } },
--     { 'n', '<Leader>t',  ':ToggleTerm<CR>',                          { noremap = true, silent = true } },
--
--     -- 更新相关
--     { 'n', '<leader>pM', ':Mson<CR>',                                {} },
--     { 'n', '<leader>pl', ':Lazy<CR>',                                {} },
--     { 'n', '<leader>pl', ':MasonLog<CR>',                            {} },
--     { 'n', '<leader>pa', ':Lazy update<CR>',                         {} },
--     { 'n', '<leader>pm', ':MasonUpdate<CR>',                         {} },
--
--     -- lsp mapping
--     { 'n', '<leader>li', ':LspInfo<CR>',                             {} },
--     { 'n', '<leader>ll', ':LspLog<CR>',                              {} },
-- })

utils.set_mappings(maps)
