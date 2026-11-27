-- Raccourcis généraux (non liés à un plugin).
-- Les autres sont à côté de leur plugin : lua/plugins/*.lua

local map = vim.keymap.set

-- Fenêtres -------------------------------------------------------------------
-- Redimensionner la fenêtre active (Ctrl+Alt+flèches)
map("n", "<C-S-Up>", "<cmd>resize +2<CR>", { desc = "Fenêtre + haute" })
map("n", "<C-S-Down>", "<cmd>resize -2<CR>", { desc = "Fenêtre - haute" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Fenêtre - large" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Fenêtre + large" })

-- Terminal -------------------------------------------------------------------
map("n", "<leader>t", function()
	vim.cmd("botright 15split | terminal")
end, { desc = "Ouvrir un terminal en bas" })

-- Man flottant (K) -----------------------------------------------------------
-- Ouvre la page man du mot sous le curseur dans une fenêtre flottante.
-- Fermeture : q ou Échap.
local function open_man_float()
    local word

    if vim.fn.mode():match("[vV]") then
        -- Récupérer la sélection Visual
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")

        local lines = vim.fn.getregion(
            start_pos,
            end_pos,
            { type = vim.fn.mode() }
        )

        word = table.concat(lines, " "):gsub("^%s*(.-)%s*$", "%1")
    else
        word = vim.fn.expand("<cword>")
    end

    if word == "" then
        return
    end

    local output = vim.fn.systemlist(
        "man " .. vim.fn.shellescape(word) .. " | col -b"
    )

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

	-- Fenêtre centrée, 80 % de l'écran
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
	})

	local function close()
		vim.api.nvim_win_close(win, true)
	end
	map("n", "q", close, { buffer = buf })
	map("n", "<Esc>", close, { buffer = buf })
end

map({ "n", "s", "v" }, "K", open_man_float, { desc = "Man flottant" })
