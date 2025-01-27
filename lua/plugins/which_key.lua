return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec", "disable.ft", "disable.bt" },
  config = function()
    -- require("which-key").add({
    --   { "<leader>f", group = "file" },  -- group
    --   {
    --     "<leader>b",
    --     group = "buffers",
    --     expand = function()
    --       return require("which-key.extras").expand.buf()
    --     end
    --   },
    -- })
    require('which-key').setup({
      icons = {
        group = vim.g.icons_enabled ~= false and "" or "+",
        rules = false,
        separator = "-",
      },
    })
  end,
}
