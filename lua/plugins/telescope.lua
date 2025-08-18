return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-file-browser.nvim',
    'jonarrien/telescope-cmdline.nvim',
  },
  keys = function()
    local builtin = require('telescope.builtin')
    local telescope = require('telescope')
    return {
      { "<leader>f'", builtin.marks, desc = 'Find marks' },
      { '<leader>f/', builtin.current_buffer_fuzzy_find, desc = 'Find words in current buffer' },
      { '<leader>f<cr>', builtin.resume, desc = 'Resume previous search' },
      { '<leader>fb', builtin.buffers, desc = 'Find buffer in open buffers' },
      { '<leader>fc', '<cmd>Telescope cmdline<cr>', desc = 'Find commands in Cmdline' },
      { '<leader>ff', builtin.find_files, desc = 'Find file' },
      { '<leader>fh', builtin.help_tags, desc = 'Find Help' },
      { '<leader>fk', builtin.keymaps, desc = 'Find keymaps' },
      { '<leader>fm', builtin.man_pages, desc = 'Find man' },
      { '<leader>fo', builtin.oldfiles, desc = 'Find old files' },
      { '<leader>fs', builtin.treesitter, desc = 'Find treesitter symbols' },
      { '<leader>fw', builtin.live_grep, desc = 'Find words in current working' },
      {
        '<leader>fe',
        function()
          local cwd = vim.fn.stdpath('config')
          builtin.find_files({ prompt_title = 'Find nvim config files', cwd = cwd, follow = true })
        end,
        desc = 'Find nvim config files',
      },
      {
        '<leader>fP',
        function()
          builtin.find_files({ cwd = require('lazy.core.config').options.root })
        end,
        desc = 'Find Plugin File',
      },
      {
        '<leader>ft',
        function()
          builtin.colorscheme {
            layout_strategy = 'horizontal',
            enable_preview = true,
            previewer = false,
          }
        end,
        desc = 'Find themes',
      },
      {
        '<leader>fW',
        function()
          builtin.live_grep {
            additional_args = function(args)
              return vim.list_extend(args, { '--hidden', '--no-ignore' })
            end,
          }
        end,
        desc = 'Find words in current working(all files)',
      },
      -- Telescope Explorer
      {
        '<leader>e',
        function()
          telescope.extensions.file_browser.file_browser()
        end,
        desc = 'Toggle Explorer',
      },
      {
        '<leader>E',
        function()
          telescope.extensions.file_browser.file_browser({
            path = vim.fn.expand('%:p:h'),
            cwd = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Toggle Explorer(current cwd)',
      },
      -- Git keymaps
      { '<leader>gC', builtin.git_bcommits, desc = 'Git commits(current file)' },
      { '<leader>gT', builtin.git_stash, desc = 'Git stash' },
      { '<leader>gc', builtin.git_commits, desc = 'Git commits' },
      { '<leader>gt', builtin.git_status, desc = 'Git status' },
      -- LSP keymaps
      { 'gO', builtin.lsp_document_symbols, desc = 'Search symbols' },
      { '<leader>ls', builtin.lsp_document_symbols, desc = 'Search symbols' },
      { '<leader>lG', builtin.lsp_dynamic_workspace_symbols, desc = 'Search workspace symbols' },
    }
  end,
  config = function(_, _)
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        mappings = {
          n = {
            ["q"] = require('telescope.actions').close,
          },
        },
        dynamic_preview_title = true,
        path_display = { truncate = 2 },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
        }
      }
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}
