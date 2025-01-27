-- set mapping
local utils = require 'utils'
local is_available = utils.is_available
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
maps.n['<leader>w'] = { '<cmd>w<cr>', desc = 'Save' }
maps.n['<leader>W'] = { "<cmd>wal<cr>', desc = Save all" }
maps.n['<leader>q'] = { '<cmd>confirm q<cr>', desc = 'Quit' }
maps.n['<leader>Q'] = { '<cmd>confirm qall<cr>', desc = 'Quit all' }
maps.n['<leader>n'] = { '<cmd>enew<cr>', desc = 'New File' }
maps.n['<C-s>'] = { '<cmd>w!<cr>', desc = 'Force write' }
maps.n['<C-q>'] = { '<cmd>qa!<cr>', desc = 'Force quit' }
maps.n['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' }
maps.n['\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' }
-- TODO: Remove when dropping support for <Neovim v0.10
-- if not vim.ui.open then maps.n['gx'] = { utils.system_open, desc = "Open the file under cursor with system app" } end

-- Manage Buffers
maps.n['<leader>c'] = {
  function()
    require 'utils.buffer'.close(0, false)
  end,
  desc = 'Close buffer',
}
maps.n['<leader>C'] = {
  function()
    require 'utils.buffer'.close(0, true)
  end,
  desc = 'Force close buffer',
}
if is_available('bufferline.nvim') then
  maps.n['<leader>br'] = { '<cmd>BufferLineCloseRight<cr>', desc = 'Close all buffers to the right' }
  maps.n['<leader>bl'] = { '<cmd>BufferLineCloseLeft<cr>', desc = 'Close all buffers to the left' }
  maps.n['<leader>bb'] = { '<cmd>BufferLinePick<cr>', desc = 'Select buffer from bufferline' }
  maps.n['<leader>bd'] = { '<cmd>BufferLinePickClose<cr>', desc = 'Close buffer from bufferline' }
  maps.n['<leader>bp'] = { '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle pinned' }
  maps.n['<leader>bo'] = { '<cmd>BufferLineCloseOthers<cr>', desc = 'Close other buffers' }
  maps.n['<leader>bs'] = { '<cmd>BufferLineSortByExtension<cr>', desc = 'Sort buffers' }
  maps.n['<tab>'] = { '<cmd>b#<cr>', desc = 'Previous buffer' }
  maps.n['[b'] = { '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' }
  maps.n[']b'] = { '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' }
end

-- Navigate tabs
maps.n[']t'] = {
  function()
    vim.cmd.tabnext()
  end,
  desc = 'Next tab',
}
maps.n['[t'] = {
  function()
    vim.cmd.tabprevious()
  end,
  desc = 'Previous tab',
}

-- Comment
if is_available 'Comment.nvim' then
  maps.n['<leader>//'] = {
    function()
      require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
    end,
    desc = 'Toggle comment line',
  }
  maps.v['<leader>//'] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = 'Toggle comment for selection',
  }
end

-- Neogen
if is_available 'neogen' then
  maps.n['<leader>/f'] = {
    "<cmd>lua require('neogen').generate({ type = 'func' })<cr>",
    desc = 'Function annotation documentation',
  }
  maps.n['<leader>/c'] = {
    "<cmd>lua require('neogen').generate({ type = 'class' })<cr>",
    desc = 'Class annotation documentation',
  }
  maps.n['<leader>/F'] = {
    "<cmd>lua require('neogen').generate({ type = 'file' })<cr>",
    desc = 'File annotation documentation',
  }
  maps.n['<leader>/t'] = {
    "<cmd>lua require('neogen').generate({ type = 'type' })<cr>",
    desc = 'Type annotation documentation',
  }
end

if is_available 'gitsigns.nvim' then
  maps.n[']g'] = {
    function()
      require('gitsigns').nav_hunk('next')
    end,
    desc = 'Next Git hunk',
  }
  maps.n['[g'] = {
    function()
      require('gitsigns').nav_hunk('prev')
    end,
    desc = 'Previous Git hunk',
  }
  maps.n['<leader>gl'] = {
    function()
      require('gitsigns').blame_line()
    end,
    desc = 'View Git blame',
  }
  maps.n['<leader>gL'] = {
    function()
      require('gitsigns').blame_line { full = true }
    end,
    desc = 'View full Git blame',
  }
  maps.n['<leader>gp'] = {
    function()
      require('gitsigns').preview_hunk()
    end,
    desc = 'Preview Git hunk',
  }
  maps.n['<leader>gh'] = {
    function()
      require('gitsigns').reset_hunk()
    end,
    desc = 'Reset Git hunk',
  }
  maps.n['<leader>gr'] = {
    function()
      require('gitsigns').reset_buffer()
    end,
    desc = 'Reset Git buffer',
  }
  maps.n['<leader>gs'] = {
    function()
      require('gitsigns').stage_hunk()
    end,
    desc = 'Stage Git hunk',
  }
  maps.n['<leader>gS'] = {
    function()
      require('gitsigns').stage_buffer()
    end,
    desc = 'Stage Git buffer',
  }
  maps.n['<leader>gu'] = {
    function()
      require('gitsigns').undo_stage_hunk()
    end,
    desc = 'Unstage Git hunk',
  }
  maps.n['<leader>gd'] = {
    function()
      require('gitsigns').diffthis()
    end,
    desc = 'View Git diff',
  }
end

-- Package Manager
if is_available 'mason.nvim' then
  maps.n['<leader>pm'] = { '<cmd>Mason<cr>', desc = 'Mason Installer' }
  maps.n['<leader>pM'] = { '<cmd>MasonUpdate<cr>', desc = 'Mason Update' }
end

if is_available 'telescope.nvim' then
  local builtin = require('telescope.builtin')
  local function telescope_file_browser(input)
    if nil == input then
      input = vim.fn.expand('%:p:h')
    end
    local telescope = require('telescope')
    telescope.extensions.file_browser.file_browser({
      path = input,
      cwd = input,
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = 'normal',
    })
  end
  maps.n['<leader>f<cr>'] = { builtin.resume, desc = 'Resume previous search' }
  maps.n["<leader>f'"] = {
    function()
      require('telescope.builtin').marks()
    end,
    desc = 'Find marks',
  }
  maps.n['<leader>f/'] = {
    function()
      require('telescope.builtin').current_buffer_fuzzy_find()
    end,
    desc = 'Find words in current buffer',
  }
  maps.n['<leader>ff'] = {
    function()
      builtin.find_files()
    end,
    desc = 'Find file',
  }
  maps.n['<leader>fw'] = {
    function()
      builtin.live_grep()
    end,
    desc = 'Find words in current working',
  }
  maps.n['<leader>fW'] = {
    function()
      builtin.live_grep {
        additional_args = function(args)
          return vim.list_extend(args, { '--hidden', '--no-ignore' })
        end,
      }
    end,
    desc = 'Find words in current working(all files)',
  }
  maps.n['<leader>fb'] = { builtin.buffers, desc = 'Find buffer in open buffers' }
  maps.n['<leader>fh'] = { builtin.help_tags, desc = 'Find Help' }
  maps.n['<leader>fk'] = {
    function()
      require('telescope.builtin').keymaps()
    end,
    desc = 'Find keymaps',
  }
  maps.n['<leader>fm'] = {
    function()
      require('telescope.builtin').man_pages()
    end,
    desc = 'Find man',
  }
  maps.n['<leader>fe'] = {
    function()
      local cwd = vim.fn.stdpath('config')
      builtin.find_files({
        prompt_title = 'Find nvim config files',
        cwd = cwd,
        follow = true,
      })
    end,
    desc = 'Find nvim config files',
  }
  maps.n['<leader>e'] = {
    function()
      telescope_file_browser()
    end,
    desc = 'Specifying search directories',
  }
  maps.n['<leader>E'] = {
    function()
      local input = vim.fn.expand('%:p:h')
      vim.ui.input({
        prompt = 'Enter directory path: ', -- Prompt user to input directory path
        default = input,
        completion = nil, -- Use directory completion
      }, function()
        if vim.fn.isdirectory(vim.fn.expand(input)) == 1 then
          telescope_file_browser(input)
        end
      end)
    end,
    desc = 'Specifying search directories',
  }
  maps.n['<leader>fP'] = {
    function()
      builtin.find_files({
        cwd = require('lazy.core.config').options.root,
      })
    end,
    desc = 'Find Plugin File',
  }
  maps.n['<leader>ft'] = {
    function()
      builtin.colorscheme { enable_preview = true }
    end,
    desc = 'Find themes',
  }
  maps.n['<leader>fs'] = {
    function()
      builtin.treesitter()
    end,
    desc = 'Find treesitter symbols',
  }
end

-- maps.n[':'] = { ":Telescope cmdline<CR>", desc = "CmdLine" }
-- maps.n['<leader><leader>'] = { ":Telescope cmdline<CR>", desc = "CmdLine" }
-- vim.keymap.set('n', ':', '<cmd>Telescope cmdline<CR>', { desc = "Cmdline" })

-- maps.n[':'] = {"<cmd>Telescope cmdline<cr>", desc = }
-- LSP
-- if is_available "nvim-lspconfig" then
--   maps.n['gD'] = { vim.lsp.buf.declaration, desc = 'sssss' }
--   maps.n['gd'] = { vim.lsp.buf.definition, desc = 'sssss' }
--   maps.n['<leader>d'] = { vim.diagnostic.open_float, desc = 'sssss' }
-- end

utils.set_mappings(maps)
