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
local keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

for i, key in ipairs(keys) do
	vim.keymap.set("n", "<C-" .. key .. ">", "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Buffer " .. i })
end


