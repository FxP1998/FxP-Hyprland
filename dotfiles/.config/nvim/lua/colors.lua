-- Rose Pine Light Enhanced - Full Color Scheme for Neovim
vim.cmd('set background=light')
vim.cmd('set termguicolors')

-- Rose Pine Light Base Colors
vim.api.nvim_set_hl(0, 'Normal', { bg = '#faf4ed', fg = '#575279' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#fffaf3', fg = '#575279' })
vim.api.nvim_set_hl(0, 'Comment', { fg = '#9893a5', italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#b4637a' })
vim.api.nvim_set_hl(0, 'String', { fg = '#ea9d34' })
vim.api.nvim_set_hl(0, 'Character', { fg = '#d7827e' })
vim.api.nvim_set_hl(0, 'Number', { fg = '#b4637a' })
vim.api.nvim_set_hl(0, 'Boolean', { fg = '#b4637a' })
vim.api.nvim_set_hl(0, 'Float', { fg = '#b4637a' })

-- Identifiers
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#d7827e' })
vim.api.nvim_set_hl(0, 'Function', { fg = '#d7827e' })
vim.api.nvim_set_hl(0, 'Variable', { fg = '#575279' })

-- Statements
vim.api.nvim_set_hl(0, 'Statement', { fg = '#286983' })
vim.api.nvim_set_hl(0, 'Conditional', { fg = '#286983' })
vim.api.nvim_set_hl(0, 'Repeat', { fg = '#286983' })
vim.api.nvim_set_hl(0, 'Label', { fg = '#286983' })
vim.api.nvim_set_hl(0, 'Operator', { fg = '#d7827e' })
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#286983' })
vim.api.nvim_set_hl(0, 'Exception', { fg = '#b4637a' })

-- Preprocessor
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'Include', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'Define', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'Macro', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'PreCondit', { fg = '#56949f' })

-- Types
vim.api.nvim_set_hl(0, 'Type', { fg = '#907aa9' })
vim.api.nvim_set_hl(0, 'StorageClass', { fg = '#907aa9' })
vim.api.nvim_set_hl(0, 'Structure', { fg = '#907aa9' })
vim.api.nvim_set_hl(0, 'Typedef', { fg = '#907aa9' })

-- Special
vim.api.nvim_set_hl(0, 'Special', { fg = '#ea9d34' })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = '#b4637a' })
vim.api.nvim_set_hl(0, 'Tag', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#575279' })
vim.api.nvim_set_hl(0, 'SpecialComment', { fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'Debug', { fg = '#b4637a' })

-- UI Elements
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#575279', bold = true })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#fffaf3' })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = '#fffaf3' })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#fffaf3' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = '#faf4ed', fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'FoldColumn', { bg = '#faf4ed', fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'Folded', { bg = '#fffaf3', fg = '#9893a5' })

-- Visual Mode
vim.api.nvim_set_hl(0, 'Visual', { bg = '#f2e9e1' })
vim.api.nvim_set_hl(0, 'VisualNOS', { bg = '#f2e9e1' })

-- Search
vim.api.nvim_set_hl(0, 'Search', { bg = '#ea9d34', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#b4637a', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#f2e9e1', fg = '#575279', bold = true })

-- Status Line
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#fffaf3', fg = '#575279' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#faf4ed', fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'WildMenu', { bg = '#907aa9', fg = '#faf4ed' })

-- Tab Line
vim.api.nvim_set_hl(0, 'TabLine', { bg = '#fffaf3', fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = '#907aa9', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#faf4ed', fg = '#9893a5' })

-- Pmenu (Completion)
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#fffaf3', fg = '#575279' })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#286983', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#fffaf3' })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#f2e9e1' })

-- Errors and Warnings
vim.api.nvim_set_hl(0, 'Error', { bg = '#b4637a', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'ErrorMsg', { bg = '#b4637a', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'WarningMsg', { bg = '#ea9d34', fg = '#faf4ed' })
vim.api.nvim_set_hl(0, 'MoreMsg', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'ModeMsg', { fg = '#575279' })
vim.api.nvim_set_hl(0, 'Question', { fg = '#ea9d34' })

-- Diffs
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#f2e9e1', fg = '#56949f' })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#f2e9e1', fg = '#ea9d34' })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#f2e9e1', fg = '#b4637a' })
vim.api.nvim_set_hl(0, 'DiffText', { bg = '#f2e9e1', fg = '#907aa9' })

-- Spelling
vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = '#b4637a' })
vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = '#ea9d34' })
vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true, sp = '#907aa9' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#56949f' })

-- Special Syntax
vim.api.nvim_set_hl(0, 'Title', { fg = '#d7827e', bold = true })
vim.api.nvim_set_hl(0, 'Todo', { bg = '#ea9d34', fg = '#faf4ed', bold = true })
vim.api.nvim_set_hl(0, 'Underlined', { fg = '#907aa9', underline = true })
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'NonText', { fg = '#9893a5' })
vim.api.nvim_set_hl(0, 'Directory', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'Conceal', { fg = '#9893a5' })

-- LSP and Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#b4637a' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#ea9d34' })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#56949f' })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#907aa9' })
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#f2e9e1' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#f2e9e1' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#f2e9e1' })

-- Treesitter
vim.api.nvim_set_hl(0, '@function', { fg = '#d7827e' })
vim.api.nvim_set_hl(0, '@function.call', { fg = '#d7827e' })
vim.api.nvim_set_hl(0, '@parameter', { fg = '#575279' })
vim.api.nvim_set_hl(0, '@field', { fg = '#ea9d34' })
vim.api.nvim_set_hl(0, '@property', { fg = '#ea9d34' })
vim.api.nvim_set_hl(0, '@constructor', { fg = '#907aa9' })
vim.api.nvim_set_hl(0, '@tag', { fg = '#56949f' })
vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = '#575279' })