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
maps.v["<M-p>"] = { ":m '>-2<CR>gv=gv", desc = "Move up row" }
maps.v["<M-n>"] = { ":m '>+1<CR>gv=gv", desc = "Move down row" }
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
if is_available 'neo-tree.nvim' then
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

-- LSP
-- if is_available "nvim-lspconfig" then
--   maps.n["gD"] = { vim.lsp.buf.declaration, desc = 'sssss' }
--   maps.n["gd"] = { vim.lsp.buf.definition, desc = 'sssss' }
--   maps.n["<leader>d"] = { vim.diagnostic.open_float, desc = 'sssss' }
-- end

utils.set_mappings(maps)
