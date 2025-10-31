-- Rose Pine Dark Enhanced - Full Color Scheme for Neovim
vim.cmd('set background=dark')
vim.cmd('set termguicolors')

-- Rose Pine Dark Base Colors
vim.api.nvim_set_hl(0, 'Normal', { bg = '#191724', fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1f1d2e', fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'Comment', { fg = '#908caa', italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'String', { fg = '#f6c177' })
vim.api.nvim_set_hl(0, 'Character', { fg = '#ea9a97' })
vim.api.nvim_set_hl(0, 'Number', { fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'Boolean', { fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'Float', { fg = '#eb6f92' })

-- Identifiers
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#ebbcba' })
vim.api.nvim_set_hl(0, 'Function', { fg = '#ebbcba' })
vim.api.nvim_set_hl(0, 'Variable', { fg = '#e0def4' })

-- Statements
vim.api.nvim_set_hl(0, 'Statement', { fg = '#31748f' })
vim.api.nvim_set_hl(0, 'Conditional', { fg = '#31748f' })
vim.api.nvim_set_hl(0, 'Repeat', { fg = '#31748f' })
vim.api.nvim_set_hl(0, 'Label', { fg = '#31748f' })
vim.api.nvim_set_hl(0, 'Operator', { fg = '#ebbcba' })
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#31748f' })
vim.api.nvim_set_hl(0, 'Exception', { fg = '#eb6f92' })

-- Preprocessor
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'Include', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'Define', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'Macro', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'PreCondit', { fg = '#9ccfd8' })

-- Types
vim.api.nvim_set_hl(0, 'Type', { fg = '#c4a7e7' })
vim.api.nvim_set_hl(0, 'StorageClass', { fg = '#c4a7e7' })
vim.api.nvim_set_hl(0, 'Structure', { fg = '#c4a7e7' })
vim.api.nvim_set_hl(0, 'Typedef', { fg = '#c4a7e7' })

-- Special
vim.api.nvim_set_hl(0, 'Special', { fg = '#f6c177' })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'Tag', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'SpecialComment', { fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'Debug', { fg = '#eb6f92' })

-- UI Elements
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e0def4', bold = true })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1f1d2e' })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = '#1f1d2e' })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#1f1d2e' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#191724', fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = '#191724', fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'Folded', { bg = '#1f1d2e', fg = '#6e6a86' })

-- Visual Mode
vim.api.nvim_set_hl(0, 'Visual', { bg = '#403d52' })
vim.api.nvim_set_hl(0, 'VisualNOS', { bg = '#403d52' })

-- Search
vim.api.nvim_set_hl(0, 'Search', { bg = '#f6c177', fg = '#191724' })
vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#eb6f92', fg = '#191724' })
vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#403d52', fg = '#e0def4', bold = true })

-- Status Line
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#1f1d2e', fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#191724', fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'WildMenu', { bg = '#c4a7e7', fg = '#191724' })

-- Tab Line
vim.api.nvim_set_hl(0, 'TabLine', { bg = '#1f1d2e', fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = '#c4a7e7', fg = '#191724' })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#191724', fg = '#6e6a86' })

-- Pmenu (Completion)
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#1f1d2e', fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#31748f', fg = '#191724' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#1f1d2e' })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#403d52' })

-- Errors and Warnings
vim.api.nvim_set_hl(0, 'Error', { bg = '#eb6f92', fg = '#191724' })
vim.api.nvim_set_hl(0, 'ErrorMsg', { bg = '#eb6f92', fg = '#191724' })
vim.api.nvim_set_hl(0, 'WarningMsg', { bg = '#f6c177', fg = '#191724' })
vim.api.nvim_set_hl(0, 'MoreMsg', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'ModeMsg', { fg = '#e0def4' })
vim.api.nvim_set_hl(0, 'Question', { fg = '#f6c177' })

-- Diffs
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#2a2733', fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#2a2733', fg = '#f6c177' })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#2a2733', fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'DiffText', { bg = '#2a2733', fg = '#c4a7e7' })

-- Spelling
vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = '#eb6f92' })
vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = '#f6c177' })
vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true, sp = '#c4a7e7' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#9ccfd8' })

-- Special Syntax
vim.api.nvim_set_hl(0, 'Title', { fg = '#ebbcba', bold = true })
vim.api.nvim_set_hl(0, 'Todo', { bg = '#f6c177', fg = '#191724', bold = true })
vim.api.nvim_set_hl(0, 'Underlined', { fg = '#c4a7e7', underline = true })
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'NonText', { fg = '#6e6a86' })
vim.api.nvim_set_hl(0, 'Directory', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'Conceal', { fg = '#6e6a86' })

-- LSP and Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#eb6f92' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#f6c177' })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#c4a7e7' })
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#403d52' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#403d52' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#403d52' })

-- Treesitter
vim.api.nvim_set_hl(0, '@function', { fg = '#ebbcba' })
vim.api.nvim_set_hl(0, '@function.call', { fg = '#ebbcba' })
vim.api.nvim_set_hl(0, '@parameter', { fg = '#e0def4' })
vim.api.nvim_set_hl(0, '@field', { fg = '#f6c177' })
vim.api.nvim_set_hl(0, '@property', { fg = '#f6c177' })
vim.api.nvim_set_hl(0, '@constructor', { fg = '#c4a7e7' })
vim.api.nvim_set_hl(0, '@tag', { fg = '#9ccfd8' })
vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = '#e0def4' })