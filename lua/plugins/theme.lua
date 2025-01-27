-- 主题
return {
  {
    "killitar/obscure.nvim",
    -- event = 'VeryLazy',
    -- dir = "~/code/obscure.nvim/",
    -- lazy = false,
    -- priority = 1000,
    config = function()
      require("obscure").setup({
        -- hl_statuscolumn_cursorline = false, -- highlight statuscolumn groups (default false)
        -- on_highlights = function(hl, c)
        --   -- CursorLine = { bg = "" },
        --   hl.CursorLineNr = { bg = "#002c38" }
        --   hl.CursorLineFold = { bg = "#002c38" }
        --   hl.CursorLineSign = { bg = "#002c38" }
        --   hl.GitSignsAddCul = { bg = "#002c38" }
        --   hl.GitSignsChangeCul = { bg = "#002c38" }
        --   hl.GitSignsDeleteCul = { bg = "#002c38" }
        --   hl.GitSignsTopdeleteCul = { bg = "#002c38" }
        --   hl.GitSignsUntrackedCul = { bg = "#002c38" } hl.GitSignsChangedeleteCul = { bg = "#002c38" }
        -- end
      })
      vim.cmd [[colorscheme obscure]]
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
