return {
    'j-hui/fidget.nvim',
    lazy = false,
    tag = "legacy",
    config = function ()
        require('fidget').setup({
            window = {
                blend = 0,                  -- &winblend for the window
                border = "rounded",         -- style of border for the fidget window
            },
        })
    end,
}
