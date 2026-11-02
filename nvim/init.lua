-- ~/.config/nvim/init.lua
-- Point d'entrée : l'ORDRE des require est important.

-- 1. Options générales (définit aussi <leader>, à faire avant tout raccourci)
require("config.options")

-- 2. Plugins : installation, puis configuration de chacun (lua/plugins/)
require("plugins")

-- 3. Serveurs de langage (LSP)
require("config.lsp")

-- 4. Raccourcis généraux (ceux liés à un plugin sont dans lua/plugins/)
require("config.keymaps")
