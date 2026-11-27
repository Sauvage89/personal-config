-- Options générales de Neovim

-- Touche <leader> : les raccourcis "<leader>xxx" commencent par Espace
vim.g.mapleader = " "

-- Interface
vim.opt.showmode = false -- masque le mode natif (lualine l'affiche déjà)
vim.o.winborder = "rounded" -- bordures arrondies sur les fenêtres flottantes

-- Numéros de ligne
vim.opt.number = true
vim.opt.relativenumber = true
-- Colonne des numéros : ligne courante = numéro réel, autres = distance relative + 1
vim.o.statuscolumn = "%=%{v:relnum == 0 ? v:lnum : abs(v:relnum) + 1}%="

-- Indentation
vim.opt.shiftwidth = 4 -- espaces par niveau d'indentation
vim.opt.tabstop = 4 -- largeur d'une tabulation

-- Hapiness
vim.opt.swapfile = false
