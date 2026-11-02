-- which-key : affiche les raccourcis disponibles après <leader>, g, z, <C-w>...

require("which-key").setup({
	delay = 300, -- ms avant l'affichage du menu
})

-- Noms des groupes affichés dans le menu
require("which-key").add({
	{ "<leader>f", group = "Find" },
	{ "<leader>b", group = "Buffer" },
})

