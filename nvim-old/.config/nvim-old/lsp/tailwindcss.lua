return {
	filetypes = {
		"html",
		"templ",
		"javascriptreact",
		"typescriptreact",
		"css",
		"scss",
	},

	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					'class="([^"]*)"',
					'className="([^"]*)"',
				},
			},
		},
	},
}
