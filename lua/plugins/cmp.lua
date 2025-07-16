return {
  'saghen/blink.cmp',
  event = 'VeryLazy',
  version = '*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    keymap = {
      preset = 'none',
      -- hide or show completion
      ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
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
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
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
      list = { selection = { preselect = false, auto_insert = false } },
      menu = {
        draw = {
          padding = 1,
          gap = 2,
          columns = {
            { 'label',     'label_description' },
            { 'kind_icon', 'source_name',      gap = 1 },
          },
          treesitter = { 'lsp' },
        },
      },
    },
    sources = {
      default = { 'lazydev', 'snippets', 'lsp', 'buffer', 'path' },
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
      },
    },
    signature = { enabled = true, window = { border = 'single' } },
  },
}
