return {
  'saghen/blink.cmp',
  event = 'VeryLazy',
  version = '*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    keymap = {
      preset = 'none',
      -- hide or show completion
      ['<C-d>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
      -- accept completion
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.select_and_accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      -- select completion
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = {
        function(cmp)
          if cmp.is_active() then cmp.select_prev() end
        end,
        'show', 'fallback_to_mappings'
      },
      ['<C-n>'] = {
        function(cmp)
          if cmp.is_active then cmp.select_next() end
        end,
        'show', 'fallback_to_mappings' },
      -- select documentation
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      -- toggle signature
      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    completion = {
      keyword = { range = 'full' },
      ghost_text = { enabled = true },
      documentation = { auto_show = true },
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        direction_priority = function()
          local ctx = require('blink.cmp').get_context()
          local item = require('blink.cmp').get_selected_item()
          if ctx == nil or item == nil then return { 's', 'n' } end

          local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
          local is_multi_line = item_text:find('\n') ~= nil

          -- after showing the menu upwards, we want to maintain that direction
          -- until we re-open the menu, so store the context id in a global variable
          if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
            vim.g.blink_cmp_upwards_ctx_id = ctx.id
            return { 'n', 's' }
          end
          return { 's', 'n' }
        end,
        draw = {
          padding = { 0, 0 },
          treesitter = { 'lsp' },
          columns = {
            { 'label',     'label_description', gap = 1 },
            { 'kind_icon', 'kind',              gap = 1 }
          },
        },
      },
    },
    sources = {
      default = { 'lazydev', 'snippets', 'lsp', 'path', 'buffer', },
      providers = {
        -- cmdline = {
        --   enabled = false
        --   -- enabled = function()
        --   --   return vim.fn.getcmdline():sub(1, 1) ~= '!'
        --   -- end
        -- },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        buffer = { min_keyword_length = 3 },
        cmdline = { min_keyword_length = 2 },
        snippets = { min_keyword_length = 3 },
      },
    },
    signature = { enabled = true, },
    cmdline = {
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
      keymap = {
        ['<C-d>'] = { 'show', 'hide' },
      }
    },
  },
}
