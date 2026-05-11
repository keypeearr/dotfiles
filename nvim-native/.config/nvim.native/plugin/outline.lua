vim.pack.add({ gh("hedyhli/outline.nvim") })

require("outline").setup({})

local set = vim.keymap.set

set("n", "<leader>ss", "<CMD>Outline<CR>", { desc = "Toggle Outline" })
