-- bufferline : barre d'onglets pour les buffers ouverts

require("bufferline").setup({
	options = {
		-- Fermer un buffer sans casser la disposition des fenêtres
		close_command = function(n) Snacks.bufdelete(n) end,
		right_mouse_command = function(n) Snacks.bufdelete(n) end,
		diagnostics = "nvim_lsp", -- erreurs/warnings LSP affichés par onglet
		always_show_bufferline = true,
		offsets = {
			{ filetype = "snacks_layout_box" }, -- décale la barre devant l'explorateur
		},
	},
})

-- Raccourcis ------------------------------------------------------------------
-- Aller au buffer n°i de la barre (rangée de chiffres AZERTY : & é " ' ( - è _ ç)
local keys = { "&", "é", '"', "'", "(", "-", "è", "_", "ç" }

for i, key in ipairs(keys) do
	vim.keymap.set("n", "<C-" .. key .. ">", "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Buffer " .. i })
end

-- Fermer des buffers (Snacks.bufdelete garde la disposition des fenêtres intacte)
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Fermer le buffer courant" })
vim.keymap.set("n", "<C-w>", function() Snacks.bufdelete() end, { desc = "Fermer le buffer" })
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Fermer les autres buffers" })
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLinePickClose<CR>", { desc = "Choisir un buffer à fermer" })
