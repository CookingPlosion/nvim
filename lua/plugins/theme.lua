-- 主题
return {
  {
    -- "killitar/obscure.nvim",
    -- event = 'VeryLazy',
    dir = "~/code/obscure.nvim/",
    -- lazy = false,
    -- priority = 1000,
    opts = function (_, opts)
      return opts
    end,
    config = function(_, opts)
      require("obscure").setup(opts)
      vim.cmd([[colorscheme obscure]])
    end
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
