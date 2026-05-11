vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })

require("blink.cmp").setup({
	keymap = { preset = "enter" },
	snippets = { preset = "luasnip" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							local icon = ctx.kind_icon
							if ctx.item.source_name == "LSP" then
								local color_item =
									require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr ~= "" then
									icon = color_item.abbr
								end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							local highlight = "BlinkCmpKind" .. ctx.kind
							if ctx.item.source_name == "LSP" then
								local color_item =
									require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr_hl_group then
									highlight = color_item.abbr_hl_group
								end
							end
							return highlight
						end,
					},
				},
			},
		},
	},
	signature = { enabled = true },
	sources = {
		default = { "lsp", "buffer", "snippets", "path" },
		per_filetype = {
			sql = { "snippets", "buffer" },
		},
	},
	fuzzy = { implementation = "prefer_rust" },
})
