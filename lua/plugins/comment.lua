-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
  { 'numToStr/Comment.nvim', envenet = "VeryLazy", },
  {
    "danymat/neogen",
    event = "VeryLazy",
    config = function()
      require("neogen").setup({
        enable = true,
        -- snippet_engine = "luasnip",
      })
    end
  },
}
