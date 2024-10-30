local function map(mode, lhs, rhs, desc, opts)
	opts = opts or { silent = true }
	opts.desc = desc
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Map space as leader
map('n', '<space>', '<Nop>', '', {silent = true})
vim.g.mapleader = ' '

-- Center on find
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- Split management
map('n', '<leader>v', '<cmd>vsplit<cr>')
map('n', '<leader>h', '<cmd>split<cr>')
map('n', '<M-h>', '<cmd>bp<cr>')
map('n', '<M-l>', '<cmd>bn<cr>')
map('n', '<leader>q', '<cmd>q<cr>')
map('t', '<ESC>', '<cmd>q<cr>')

-- Fuzzy finder
map('n', '<leader>f', '<cmd>Files<cr>')
map('n', '<leader>g', '<cmd>RG<cr>')
map('n', '<leader>b', '<cmd>Buffers<cr>')

-- Trouble
local trouble = require('trouble')
map('n', '<leader>xx', trouble.toggle)
map('n', '<leader>xw', function() trouble.toggle('workspace_diagnostics') end)
map('n', '<leader>xd', function() trouble.toggle('document_diagnostics') end)
map('n', '<leader>xq', function() trouble.toggle('quickfix') end)
map('n', '<leader>xl', function() trouble.toggle('loclist') end)
map('n', 'gR', function() trouble.toggle('lsp_references') end)

-- Terminal
local term = require('toggleterm')
map('n', '<leader>t', '<cmd>ToggleTerm direction=float<cr>')
