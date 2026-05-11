vim.pack.add({ gh("folke/snacks.nvim") })

local snacks = require("snacks")
snacks.setup({
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
		},
	},
	lazygit = {},
	notifier = {
		enabled = true,
		timeout = 3000,
	},
})

local set = vim.keymap.set

set("n", "<leader>lg", function()
	snacks.lazygit.open()
end, { desc = "LazyGit" })
set("n", "<leader>nsh", function()
	snacks.notifier.show_history()
end, { desc = "[N]otifier [S]how [H]istory" })
set("n", "<leader>nh", function()
	snacks.notifier.hide()
end, { desc = "[N]otifier [H]ide" })
