return {
	{
		"folke/snacks.nvim",
		event = { "VimEnter" },
		lazy = false,
		priority = 1000,
		opts = {
			dashboard = {
				preset = {
					header = [[
	██╗  ██╗██████╗ ██████╗
	██║ ██╔╝██╔══██╗██╔══██╗
	█████╔╝ ██████╔╝██████╗
	██╔═██╗ ██╔═ ══╝██╔══██╗
	██║  ██╗██║     ██║  ██║
	╚═╝  ╚═╝╚═╝     ╚═   ╚═╝]],
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
			lazygit = {},
			notifier = {
				enabled = true,
				timeout = 3000,
			},
		},
		keys = function()
			return {
				{
					"<leader>lg",
					function()
						Snacks.lazygit.open()
					end,
					desc = "LazyGit",
				},
				{
					"<leader>nsh",
					function()
						Snacks.notifier.show_history()
					end,
					desc = "[N]otifier [S]how [H]istory",
				},
				{
					"<leader>nh",
					function()
						Snacks.notifier.hide()
					end,
					desc = "[N]otifier [H]ide",
				},
			}
		end,
	},
}
