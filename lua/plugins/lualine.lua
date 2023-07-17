-- lualine
return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
        { "<A-1>", "<cmd>LualineBuffersJump! 1<cr>" },
        { "<A-2>", "<cmd>LualineBuffersJump! 2<cr>" },
        { "<A-3>", "<cmd>LualineBuffersJump! 3<cr>" },
        { "<A-4>", "<cmd>LualineBuffersJump! 4<cr>" },
        { "<A-5>", "<cmd>LualineBuffersJump! 5<cr>" },
        { "<A-6>", "<cmd>LualineBuffersJump! 6<cr>" },
        { "<A-7>", "<cmd>LualineBuffersJump! 7<cr>" },
        { "<A-8>", "<cmd>LualineBuffersJump! 8<cr>" },
        { "<A-9>", "<cmd>LualineBuffersJump! 9<cr>" },
        { "<A-$>", "<cmd>LualineBuffersJump! $<cr>" },
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    "diff",
                    {
                        "diagnostics",
                        symbols = { Error = "", Warn = " ", Hint = " ", Info = " " },
                        colored = true,           -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false,   -- Show diagnostics even if there are none.
                    },
                },
                lualine_c = { "filename", },
                lualine_x = { "filesize", "encoding", "fileformat", "filetype" },
                lualine_y = {},
                lualine_z = { "progress" },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {''},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = {{
                    "buffers",
                    mode = 2,
                    max_length = vim.o.columns * 9 / 10,
                    symbols = {
                        modified = ' ',      -- Text to show when the buffer is modified
                        alternate_file = '#', -- Text to show to identify the alternate file
                        directory =  '',     -- Text to show when the buffer is a directory
                    }
                }},
               lualine_x = { "tabs" },
               lualine_y = {},
               lualine_z = {},
            },
            extensions = {
                "aerial",
                "fugitive",
                "fzf",
                "man",
                "neo-tree",
                "nvim-dap-ui",
                "quickfix",
                "toggleterm",
            },
        })
    end,
}
