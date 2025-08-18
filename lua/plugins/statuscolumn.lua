local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

return {
  {
    'luukvbaal/statuscol.nvim',
    event = 'BufEnter',
    opts = function()
      local builtin = require('statuscol.builtin')
      return {
        relculright = true,
        ft_ignore = { 'help', 'man', 'terminal', 'gitsigns-blame' },
        segments = {
          { sign = { namespace = { 'diagnostic/signs' }, colwidth = 3 }, click = 'v:lua.ScSa' },
          { text = { builtin.lnumfunc },                                 click = 'v:lua.ScLa' },
          { sign = { namespace = { 'gitsign' }, colwidth = 1 },          click = 'v:lua.ScFa' },
          { text = { builtin.foldfunc, ' ' },                            click = 'v:lua.ScFa' },
        },
      }
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    -- event = 'VeryLazy',
    opts = {
      fold_virt_text_handler = handler,
      preview = {
        win_config = {
          border = 'solid',
          -- winblend = 0
        },
        mappings = {
          scrollB = '<C-b>',
          scrollF = '<C-f>',
          scrollU = '<C-u>',
          scrollD = '<C-d>',
        },
      },
      keys = {
        {
          'zr',
          function()
            require('ufo').openFoldsExceptKinds()
          end,
          desc = 'Open folds',
        },
        {
          'zR',
          function()
            require('ufo').openAllFolds()
          end,
          desc = 'Open all folds',
        },
        {
          'zm',
          function(opts)
            require('ufo').closeFoldsWith(opts)
          end,
          desc = 'Close folds',
        },
        {
          'K',
          function()
            if not require('ufo').peekFoldedLinesUnderCursor() then
              vim.cmd [[Lspsaga hover_doc]]
            end
          end,
          desc = 'Hover',
        },
      },
      provider_selector = function(_, filetype, buftype)
        local function handleFallbackException(bufnr, err, providerName)
          if type(err) == 'string' and err:match 'UfoFallbackException' then
            return require('ufo').getFolds(bufnr, providerName)
          else
            return require('promise').reject(err)
          end
        end
        return (filetype == '' or buftype == 'nofile') and 'indent' -- only use indent until a file is opened
            or function(bufnr)
              return require('ufo')
                  .getFolds(bufnr, 'lsp')
                  :catch(function(err)
                    return handleFallbackException(bufnr, err, 'treesitter')
                  end)
                  :catch(function(err)
                    return handleFallbackException(bufnr, err, 'indent')
                  end)
            end
      end,
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    opts = function()
      return {
        indent = { char = '╎' },
        scope = {
          show_start = false,
          show_end = false,
          injected_languages = true,
        },
      }
    end,
  },
  {
    'NMAC427/guess-indent.nvim',
    lazy = false,
    opts = {},
  },
}
