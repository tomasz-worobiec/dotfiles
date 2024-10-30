-- Disable netrw file manager
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Lazy
require('tom.lazy')

-- LSP --
require('tom.lsp')

-- VIM config --
require('tom.vim-config')

-- Keymaps
require('tom.keymaps')

-- Dont show LSP messages inline
vim.diagnostic.config({
	virtual_text = false,
})

-- Run dashboard at start
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("Dashboard")
    end,
})
