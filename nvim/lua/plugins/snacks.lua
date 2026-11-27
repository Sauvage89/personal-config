-- snacks.nvim : explorateur de fichiers + picker

local Snacks = require("snacks")

Snacks.setup({
	picker = { enabled = true }, -- naviguer dans les fichiers, le texte, les buffers
	explorer = { enabled = true }, -- arbre de fichiers
})

-- Raccourcis ------------------------------------------------------------------
local map = vim.keymap.set

map("n", "<leader>ff", Snacks.picker.files, { desc = "Fichiers" })
map("n", "<leader>fg", function()
    Snacks.picker.grep({
        actions = {
            copy_line = {
                action = "yank",
                field = "text",
            },
        },
        win = {
            input = {
                keys = {
                    ["<C-y>"] = {
                        "copy_line",
                        mode = { "n", "i" },
                        desc = "Copier la ligne",
                    },
                },
            },
        },
    })
end, { desc = "Grep" })
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>fd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fs", Snacks.picker.lsp_symbols, { desc = "Symboles" })
map("n", "<leader>fS", Snacks.picker.lsp_workspace_symbols, { desc = "Symboles du projet" })

-- Fermer des buffers (Snacks.bufdelete garde la disposition des fenêtres intacte)
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Fermer le buffer courant" })
vim.keymap.set("n", "<C-w>", function() Snacks.bufdelete() end, { desc = "Fermer le buffer" })
vim.keymap.set("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Fermer les autres buffers" })
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLinePickClose<CR>", { desc = "Choisir un buffer à fermer" })

-- Explorateur : donne le focus s'il est déjà ouvert, sinon l'ouvre
map("n", "<leader>fe", function()
	local picker = Snacks.picker.get({ source = "explorer" })[1]
	if picker then
		picker:focus()
	else
		Snacks.explorer()
	end
end, { desc = "Explorateur" })
