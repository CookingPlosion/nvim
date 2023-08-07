return {
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'ryanoasis/vim-devicons',
		},
		opts = {
			options = {
				mode = "tabs",
				indicator = {
					icon = '▎', -- this should be omitted if indicator style is not 'icon'
					-- style = 'icon' | 'underline' | 'none',
					style = "icon",
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_duplicate_prefix = false,
				tab_size = 10,
				enforce_regular_tabs = false,
				padding = 0,
				separator_style = "thick",
			}
		}
}
