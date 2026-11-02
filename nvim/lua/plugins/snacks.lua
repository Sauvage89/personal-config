-- snacks.nvim : explorateur de fichiers + picker

local Snacks = require("snacks")

Snacks.setup({
	picker = { enabled = true }, -- naviguer dans les fichiers, le texte, les buffers
	explorer = { enabled = true }, -- arbre de fichiers
})

-- Raccourcis ------------------------------------------------------------------
local map = vim.keymap.set

map("n", "<leader>ff", Snacks.picker.files, { desc = "Fichiers" })
map("n", "<leader>fg", Snacks.picker.grep, { desc = "Grep" })
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>fd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fs", Snacks.picker.lsp_symbols, { desc = "Symboles" })
map("n", "<leader>fS", Snacks.picker.lsp_workspace_symbols, { desc = "Symboles du projet" })

-- Explorateur : donne le focus s'il est déjà ouvert, sinon l'ouvre
map("n", "<leader>fe", function()
	local picker = Snacks.picker.get({ source = "explorer" })[1]
	if picker then
		picker:focus()
	else
		Snacks.explorer()
	end
end, { desc = "Explorateur" })
