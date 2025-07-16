-- set mapping
local utils = require('utils')
local maps = utils.empty_map_table()

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
maps.v['<M-p>'] = { ":m '>-2<CR>gv=gv", desc = 'Move up row' }
maps.v['<M-n>'] = { ":m '>+1<CR>gv=gv", desc = 'Move down row' }
maps.i['jk'] = { '<ESC>', desc = 'Quit insert mode' }
maps.n['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.n['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }
maps.n['<leader>w'] = { '<cmd>silent! w<cr>', desc = 'Save' }
maps.n['<leader>W'] = { "<cmd>wal<cr>', desc = Save all" }
maps.n['<leader>q'] = { '<cmd>confirm q<cr>', desc = 'Quit' }
maps.n['<leader>Q'] = { '<cmd>confirm qall<cr>', desc = 'Quit all' }
maps.n['<leader>n'] = { '<cmd>enew<cr>', desc = 'New File' }
maps.n['<C-s>'] = { '<cmd>w!<cr>', desc = 'Force write' }
maps.n['<C-q>'] = { '<cmd>qa!<cr>', desc = 'Force quit' }
maps.n['u'] = { '<cmd>silent undo<cr>', desc = 'silent undo' }
maps.n['<C-r>'] = { '<cmd>silent redo<cr>', desc = 'silent redo' }
maps.n['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' }
maps.n['\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' }
-- TODO: Remove when dropping support for <Neovim v0.10
-- if not vim.ui.open then maps.n['gx'] = { utils.system_open, desc = "Open the file under cursor with system app" } end

-- Manage Buffers
maps.n['<leader>c'] = {
  function()
    utils.close(0, false)
  end,
  desc = 'Close buffer',
}
maps.n['<leader>C'] = {
  function()
    require 'utils.buffer'.close(0, true)
  end,
  desc = 'Force close buffer',
}

-- Navigate tabs
-- maps.n[']t'] = {
--   function()
--     vim.cmd.tabnext()
--   end,
--   desc = 'Next tab',
-- }
-- maps.n['[t'] = {
--   function()
--     vim.cmd.tabprevious()
--   end,
--   desc = 'Previous tab',
-- }

utils.set_mappings(maps)
