vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true
require("options")
require("lazy-bootstrap")
require("lazy-plugins")
require("mappings")
require("configs.autocmd")
require("configs.lspconfig")
require("configs.colorscheme")
require("configs.terminal")

vim.treesitter.language.register('tsx', 'typescriptreact')
