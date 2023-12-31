-- 主题
return {
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --   config = function()
  --     require("onedark").setup({
  --       style = "darker",
  --       transparent = true,
  --       term_colors = true,                                                                  -- Change terminal color as per the selected theme style
  --       ending_tildes = true,                                                                -- Show the end-of-buffer tildes. By default they are hidden
  --       cmp_itemkind_reverse = false,                                                        -- reverse item kind highlights in cmp menu
  --       -- toggle theme style ---
  --       toggle_style_key = "<leader>as",                                                     -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  --       toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
  --       -- Change code style ---
  --       -- Options are italic, bold, underline, none
  --       -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  --       code_style = {
  --         comments = "italic",
  --         keywords = "bold",
  --         functions = "none",
  --         strings = "none",
  --         variables = "bold",
  --       },
  --       -- Lualine options --
  --       lualine = {
  --         transparent = false, -- lualine center bar transparency
  --       },
  --       -- Custom Highlights --
  --       colors = {}, -- Ove"rride default colors
  --       highlights = {
  --         ["@comment"] = { fg = "gray" },
  --         Comment = { fg = "gray" },
  --         TreesitterContextLineNumber = { fg = "gray" },
  --         Normal = { bg = "NONE" },
  --         NormalFloat = { bg = "NONE" },
  --         FloatBorder = { bg = "NONE" },
  --         TelescopePromptBorder = { fg = "#a7b8d6" },
  --         TelescopePreviewBorder = { fg = "#a7b8d6" },
  --         TelescopeResultsBorder = { fg = "#a7b8d6" },
  --         TelescopeSelection = { bg = "#5f668a" },
  --         TelescopePreviewLine = { fg = "white" },
  --         NeoTreeGitUntracked = { fg = "#4a69bd" },
  --         PmenuSel = { fg = "NONE", bg = "#5f668a" },
  --         Pmenu = { fg = "#C5CDD9", bg = "NONE" },
  --         DashboardFooter = { fg = "#e2b86b" },
  --         NotifyBackground = { bg = "#5f668a" },
  --         StatusLine = { bg = "NONE" },
  --       },                   -- Override highlight groups
  --       diagnostics = {
  --         darker = false,    -- darker colors for diagnostic
  --         undercurl = true,  -- use undercurl instead of underline for diagnostics
  --         background = true, -- use background color for virtual text
  --       },
  --     })
  --
  --     require("onedark").load()
  --   end,
  -- },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require('solarized-osaka').load({
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent",  -- style for sidebars, see below
          floats = "transparent",    -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,        -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        dim_inactive = true,         -- dims inactive windows
        lualine_bold = false,        -- When `true`, section headers in the lualine theme will be bold
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    opts = { user_default_options = { names = false } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    main = "ibl",
    opts = {
      indent = { char = "|" },
      scope = { show_start = true, show_end = true },
      exclude = {
        buftypes = {
          "nofile",
          "terminal",
        },
        filetypes = {
          "help",
          "startify",
          "aerial",
          "alpha",
          "dashboard",
          "lazy",
          "neogitstatus",
          "NvimTree",
          "neo-tree",
          "Trouble",
        },
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    tag = "legacy",
    opts = {
      window = {
        blend = 0,          -- &winblend for the window
        border = "rounded", -- style of border for the fidget window
      },
    }
  }
}
