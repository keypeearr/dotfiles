vim.pack.add({
	gh("ibhagwan/fzf-lua"),
	gh("nvim-tree/nvim-web-devicons"),
})

local fzf = require("fzf-lua")
fzf.setup({
	"telescope",
	previewers = {
		fzf = {
			snacks_image = { enabled = false },
		},
	},
})

local set = vim.keymap.set

set("n", "<leader>fh", function()
	fzf.helptags()
end, { desc = "[F]ind [H]elp" })
set("n", "<leader>fk", function()
	fzf.keymaps()
end, { desc = "[F]ind [K]eymaps" })
set("n", "<leader>ff", function()
	fzf.files()
end, { desc = "[F]ind [F]iles" })
set("n", "<leader>fw", function()
	fzf.grep_cword()
end, { desc = "[F]ind current [W]ord" })
set("n", "<leader>fg", function()
	fzf.live_grep()
end, { desc = "[F]ind [G]rep" })
set("n", "<leader>fdd", function()
	fzf.diagnostics_document()
end, { desc = "[F]ind [D]iagnostics [D]ocument" })
set("n", "<leader>fdw", function()
	fzf.diagnostics_workspace()
end, { desc = "[F]ind [D]iagnostics [W]orkspace" })
set("n", "<leader>fr", function()
	fzf.resume()
end, { desc = "[F]ind [R]esume" })
set("n", "<leader>f.", function()
	fzf.oldfiles()
end, { desc = "[F]ind [.]Recent Files" })
set("n", "<leader><leader>", function()
	fzf.buffers()
end, { desc = "[ ][ ] Find in Buffers" })
set("n", "<leader>/", function()
	fzf.blines()
end, { desc = "[ ][/] Find in current Buffer" })
set("n", "<leader>f/", function()
	fzf.lines()
end, { desc = "[F]ind [/] in Open Buffers" })
set("n", "<leader>fn", function()
	fzf.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[F]ind [N]eovim Files" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("fzf-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor.
		set("n", "gr", fzf.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		set("n", "gI", fzf.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })

		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-t>.
		set("n", "gd", fzf.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		set("n", "gs", fzf.lsp_document_symbols, { buffer = buf, desc = "[G]oto Document [S]ymbols" })

		-- Fuzzy find all the symbols in your current workspace.
		-- Similar to document symbols, except searches over your entire project.
		set("n", "gW", fzf.lsp_workspace_symbols, { buffer = buf, desc = "[G]oto [W]orkspace Symbols" })

		-- Jump to the type of the word under your cursor.
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		set("n", "gt", fzf.lsp_typedefs, { buffer = buf, desc = "[G]oto [T]ype Definition" })
	end,
})
