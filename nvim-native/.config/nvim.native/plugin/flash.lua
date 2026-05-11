vim.pack.add({ gh("folke/flash.nvim") })

local flash = require("flash")
flash.setup({})

local set = vim.keymap.set

set({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash" })
set({ "n", "x", "o" }, "S", function()
	flash.treesitter()
end, { desc = "Flash Treesitter" })
set("o", "r", function()
	flash.remote()
end, { desc = "Remote Flash" })
set({ "o", "x" }, "R", function()
	flash.treesitter_search()
end, { desc = "Treesitter Search" })
set("c", "<c-s>", function()
	flash.toggle()
end, { desc = "Toggle Flash Search" })
