local opt = vim.opt

opt.number          = true
opt.relativenumber  = true
opt.autoindent      = true
opt.cursorline      = true
opt.cursorlineopt   = 'both'
opt.cursorcolumn    = false
opt.ignorecase      = true
opt.splitright      = true
opt.splitbelow      = true
opt.wrap            = true
opt.expandtab       = true
opt.shiftwidth      = 4
opt.tabstop         = 4
opt.swapfile        = false
opt.signcolumn      = 'yes'

vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 2 })
