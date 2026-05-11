vim.pack.add({
	gh("nvim-tree/nvim-web-devicons"),
	gh("stevearc/oil.nvim"),
	gh("JezerM/oil-lsp-diagnostics.nvim"),
})

require("oil").setup({
	columns = {
		"size",
		"mtime",
		"icon",
	},
	view_options = {
		show_hidden = true,
		natural_order = true,
	},
})

require("oil-lsp-diagnostics").setup({})

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
