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
    return {
      { '<leader>fc',    '<cmd>Telescope cmdline<cr>',      desc = 'cmdline' },
      { '<leader>f<cr>', builtin.resume,                    desc = 'Resume previous search' },
      { '<leader>fw',    builtin.live_grep,                 desc = 'Find words in current working', },
      { '<leader>fb',    builtin.buffers,                   desc = 'Find buffer in open buffers' },
      { '<leader>ff',    builtin.find_files,                desc = 'Find file', },
      { '<leader>fh',    builtin.help_tags,                 desc = 'Find Help' },
      { '<leader>fk',    builtin.keymaps,                   desc = 'Find keymaps', },
      { '<leader>fm',    builtin.man_pages,                 desc = 'Find man', },
      { "<leader>f'",    builtin.marks,                     desc = 'Find marks', },
      { '<leader>f/',    builtin.current_buffer_fuzzy_find, desc = 'Find words in current buffer', },
      { '<leader>fs',    builtin.treesitter,                desc = 'Find treesitter symbols', },
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
      {
        '<leader>fe',
        function()
          local cwd = vim.fn.stdpath('config')
          builtin.find_files({
            prompt_title = 'Find nvim config files',
            cwd = cwd,
            follow = true,
          })
        end,
        desc = 'Find nvim config files',
      },
      {
        '<leader>e',
        function()
          telescope_file_browser()
        end,
        desc = 'Specifying search directories',
      },
      {
        '<leader>E',
        function()
          local path = vim.fn.expand('%:p:h')
          vim.ui.input({
            prompt = 'Enter directory path: ', -- Prompt user to input directory path
            default = path,
            completion = 'dir',                -- Use directory completion
          }, function(input)
            if 1 == vim.fn.isdirectory(vim.fn.expand(input)) then
              telescope_file_browser(input)
            else
              vim.notify('ERROR: Invalid input path!')
            end
          end)
        end,
        desc = 'Specifying search directories',
      },
      {
        '<leader>fP',
        function()
          builtin.find_files({
            cwd = require('lazy.core.config').options.root,
          })
        end,
        desc = 'Find Plugin File',
      },
      {
        '<leader>ft',
        function()
          builtin.colorscheme { enable_preview = true }
        end,
        desc = 'Find themes',
      },
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
