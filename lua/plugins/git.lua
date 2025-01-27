return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    require("gitsigns").setup({
      culhl = true,
      worktrees = vim.g.git_worktrees,
    })
  end
}
