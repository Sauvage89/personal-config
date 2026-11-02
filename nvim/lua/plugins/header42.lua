-- header42 : insère l'en-tête 42 dans le fichier

vim.cmd("packadd header42.nvim")

-- Alt+F1 : neutralisé dans tous les modes, puis réactivé uniquement en mode normal
vim.keymap.set({ "n", "i", "v", "t" }, "<A-F1>", "<Nop>")
vim.keymap.set("n", "<A-F1>", "<cmd>Header42<CR>", { desc = "Header 42" })
