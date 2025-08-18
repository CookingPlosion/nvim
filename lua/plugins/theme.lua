-- 主题
return {
  {
    "killitar/obscure.nvim",
    -- event = 'BufEnter',
    -- dir = "~/code/obscure.nvim/",
    lazy = false,
    priority = 1000,
    opts = function(_, _)
      vim.cmd.colorscheme(vim.g.colorscheme)
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = 'VeryLazy',
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    opts = { user_default_options = { names = false } },
  },
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
