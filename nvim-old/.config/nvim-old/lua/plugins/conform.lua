return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = true,
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports-reviser", "golines", "gofumpt" },
			-- go = {
			-- 	"gofumpt",
			-- 	"goimports-reviser",
			-- 	"goimports",
			-- 	"golines",
			-- 	"gomodifytags",
			-- },
			templ = { "templ" },
			javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
			typescript = { "prettierd", "prettier", "biome", stop_after_first = true },
		},
	},
}
