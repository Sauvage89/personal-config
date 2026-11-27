-- Installation des plugins (vim.pack), puis chargement d'un fichier par plugin

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" }, -- thème
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- barre de statut
	{ src = "https://github.com/folke/snacks.nvim" }, -- explorateur, picker et plus
	{ src = "https://github.com/folke/which-key.nvim" }, -- aide sur les raccourcis
	{ src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") }, -- barre de buffers
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- icônes (utilisé par les autres plugins)
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- configs prêtes de clangd, lua_ls...
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

-- Un fichier de config par plugin.
require("plugins.catppuccin") -- en premier : les autres plugins reprennent ses couleurs
require("plugins.snacks")
require("plugins.lualine")
require("plugins.which-key")
require("plugins.bufferline")
require("plugins.header42")
require("plugins.render-markdown")
