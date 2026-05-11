vim.pack.add({ gh("xiyaowong/transparent.nvim") })

require("transparent").setup({
	extra_groups = {
		"NormalFloat",
		"NvimTreeNormal",
	},
})
