vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("OXY2DEV/markview.nvim"),
})

require("markview").setup({
	preview = {
		filetypes = { "markdown" },
	},
})

local set = vim.keymap.set

set("n", "<leader>mt", "<CMD>Markview toggle<CR>", { desc = "[M]arkview [T]oggle" })
set("n", "<leader>ms", "<CMD>Markview splitToggle<CR>", { desc = "[M]arkview [S]plit Toggle" })
