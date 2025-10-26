-- Rosé Pine colors for Neovim
vim.cmd('set background=dark')
vim.cmd('set termguicolors')

-- Set colorscheme (install with your package manager later)
-- vim.cmd('colorscheme rose-pine')

-- Custom highlights
vim.api.nvim_set_hl(0, 'Normal', { bg = '#191724', fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'Comment', { fg = '#908caa' })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#ebbcba' })
vim.api.nvim_set_hl(0, 'Statement', { fg = '#31748f' })
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'Type', { fg = '#c4a7e7' })
vim.api.nvim_set_hl(0, 'Special', { fg = '#f6c177' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1f1d2e' })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#403d52' })
vim.api.nvim_set_hl(0, 'Search', { bg = '#f6c177', fg = '#191724' })
