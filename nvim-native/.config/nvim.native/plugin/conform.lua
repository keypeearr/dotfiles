vim.pack.add({ gh("stevearc/conform.nvim") })

require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = {
			"gofumpt",
			"goimports-reviser",
			"goimports",
			"golines",
			"gomodifytags",
		},
		templ = { "templ" },
		javascript = { "prettierd", "prettier", "biome" },
		typescript = { "prettierd", "prettier", "biome" },
	},
})
