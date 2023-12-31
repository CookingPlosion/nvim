-- file tree
return {
  'nvim-neo-tree/neo-tree.nvim',
  event = { "bufEnter" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
  },
  config = function()
    require('neo-tree').setup({
      sources = {
        "filesystem",
        "buffers",
        "document_symbols",
      },
      popup_border_style = 'rounded',
      add_blank_line_at_top = false,
      enable_normal_mode_for_inputs = true,
      source_selector = {
        winbar = false,
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "document_symbols" },
          { source = "remote" },
        }
      },
      filesystem = {
        enable = true,
        visible = false,
        hide_gitignored = true,
        hide_hidden = true,
        hide_dotfiles = true,
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
      -- window = { position = "float", }
    })
  end
}
