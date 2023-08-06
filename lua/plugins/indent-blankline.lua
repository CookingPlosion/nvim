-- indent line
return {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    enabled = _G.Me_IsNotLargeFile(),
    config = function()
        require("indent_blankline").setup({
            context_char = "|",
            use_treesitter = true,
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
			buftype_exclude = {
                "terminal",
				"[No Name]",
				"prompt",
				"nofile",
				"help",
				"TelescopePrompt",
			},
			filetype_exclude = {
				"packer",
				"log",
				"markdown",
				"lspinfo",
				"plugin",
				"text",
                "lazy"
			},
		})
	end,
}
