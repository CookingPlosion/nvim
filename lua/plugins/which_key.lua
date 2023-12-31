return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    popup_mappings = {
      scroll_down = "<c-d>",       -- binding to scroll down inside the popup
      scroll_up = "<c-u>",         -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded",
      margin = { 1, 0, 1, 0 },
      padding = { 0, 2, 0, 2 },
    },
    disable = {
      buftypes = {},
      filetypes = {},
    },
  }
}
