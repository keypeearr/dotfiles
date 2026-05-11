vim.pack.add({
	gh("lmantw/themify.nvim"),
})

require("themify").setup({
	async = false,
	"folke/tokyonight.nvim",
	"Yazeed1s/minimal.nvim",
	"sho-87/kanagawa-paper.nvim",
	"catppuccin/nvim",
	"ellisonleao/gruvbox.nvim",
	"rose-pine/neovim",
	"vague2k/vague.nvim",
	"neanias/everforest-nvim",
	"alexpasmantier/hubbamax.nvim",
})

vim.keymap.set("n", "<leader>ft", "<CMD>Themify<CR>", { desc = "[F]ind [T]heme" })
