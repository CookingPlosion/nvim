return {
	"stevearc/conform.nvim",
	lazy = true,
	opts = {
		formatters_by_ft = { lua = { "stylua" } },
	},
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
				})
			end,
			desc = "Format buffer",
			mode = { "n", "v" },
		},
	},
}
