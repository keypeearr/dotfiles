vim.pack.add({
	gh("gisketch/triforce.nvim"),
	gh("nvzone/volt"),
})

require("triforce").setup({
	keymap = {
		show_profile = "<leader>tp",
	},
})
