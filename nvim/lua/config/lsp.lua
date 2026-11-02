-- Serveurs de langage (LSP) : autocomplétion, diagnostics, aller à la définition...

-- Serveur personnalisé pour Codeterraform (fichiers Python)
vim.lsp.config("codeterraform", {
	cmd = {
		"node",
		vim.fn.expand("~/.local/share/io.codeterraform.game/external-ide/server/server.cjs"),
		"--stdio",
	},
	filetypes = { "python" },
	root_markers = { "codeterraform-workspace.json" },
})

-- Activation des serveurs (clangd et lua_ls : config fournie par nvim-lspconfig)
vim.lsp.enable({ "clangd", "lua_ls", "codeterraform" })

-- Raccourci LSP
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Formater" })
