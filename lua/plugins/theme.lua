-- 主题
return {
  {
    'killitar/obscure.nvim',
    -- event = 'BufEnter',
    -- dir = "~/code/obscure.nvim/",
    lazy = false,
    priority = 1000,
    opts = function(_, _)
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  { 'brenoprata10/nvim-highlight-colors', cmd = { 'HighlightColors' } },
  -- {
  --   'j-hui/fidget.nvim',
  --   tag = "legacy",
  --   opts = {
  --     window = {
  --       blend = 0,          -- &winblend for the window
  --       border = "rounded", -- style of border for the fidget window
  --     },
  --   }
  -- }
}
