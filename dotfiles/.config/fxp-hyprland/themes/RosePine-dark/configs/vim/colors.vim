" Rosé Pine Full Color Scheme for Vim
set background=dark
set termguicolors

" Rosé Pine Base Colors
highlight Normal guibg=#191724 guifg=#e0def4
highlight NormalFloat guibg=#1f1d2e guifg=#e0def4
highlight Comment guifg=#908caa gui=italic
highlight Constant guifg=#eb6f92
highlight String guifg=#f6c177
highlight Character guifg=#ea9a97
highlight Number guifg=#eb6f92
highlight Boolean guifg=#eb6f92
highlight Float guifg=#eb6f92

" Identifiers
highlight Identifier guifg=#ebbcba
highlight Function guifg=#ebbcba
highlight Variable guifg=#e0def4

" Statements
highlight Statement guifg=#31748f
highlight Conditional guifg=#31748f
highlight Repeat guifg=#31748f
highlight Label guifg=#31748f
highlight Operator guifg=#ebbcba
highlight Keyword guifg=#31748f
highlight Exception guifg=#eb6f92

" Preprocessor
highlight PreProc guifg=#9ccfd8
highlight Include guifg=#9ccfd8
highlight Define guifg=#9ccfd8
highlight Macro guifg=#9ccfd8
highlight PreCondit guifg=#9ccfd8

" Types
highlight Type guifg=#c4a7e7
highlight StorageClass guifg=#c4a7e7
highlight Structure guifg=#c4a7e7
highlight Typedef guifg=#c4a7e7

" Special
highlight Special guifg=#f6c177
highlight SpecialChar guifg=#eb6f92
highlight Tag guifg=#9ccfd8
highlight Delimiter guifg=#e0def4
highlight SpecialComment guifg=#6e6a86
highlight Debug guifg=#eb6f92

" UI Elements
highlight LineNr guifg=#6e6a86
highlight CursorLineNr guifg=#e0def4 gui=bold
highlight CursorLine guibg=#1f1d2e
highlight CursorColumn guibg=#1f1d2e
highlight ColorColumn guibg=#1f1d2e
highlight SignColumn guibg=#191724 guifg=#6e6a86
highlight FoldColumn guibg=#191724 guifg=#6e6a86
highlight Folded guibg=#1f1d2e guifg=#6e6a86

" Cursor settings
highlight Cursor guibg=#eb6f92 guifg=#191724
highlight iCursor guibg=#eb6f92 guifg=#191724
highlight CursorIM guibg=#eb6f92 guifg=#191724

" Visual Mode
highlight Visual guibg=#403d52
highlight VisualNOS guibg=#403d52

" Search
highlight Search guibg=#f6c177 guifg=#191724
highlight IncSearch guibg=#eb6f92 guifg=#191724
highlight MatchParen guibg=#403d52 guifg=#e0def4 gui=bold

" Status Line
highlight StatusLine guibg=#1f1d2e guifg=#e0def4
highlight StatusLineNC guibg=#191724 guifg=#6e6a86
highlight WildMenu guibg=#c4a7e7 guifg=#191724

" Tab Line
highlight TabLine guibg=#1f1d2e guifg=#6e6a86
highlight TabLineSel guibg=#c4a7e7 guifg=#191724
highlight TabLineFill guibg=#191724 guifg=#6e6a86

" Pmenu (Completion)
highlight Pmenu guibg=#1f1d2e guifg=#e0def4
highlight PmenuSel guibg=#31748f guifg=#191724
highlight PmenuSbar guibg=#1f1d2e
highlight PmenuThumb guibg=#403d52

" Errors and Warnings
highlight Error guibg=#eb6f92 guifg=#191724
highlight ErrorMsg guibg=#eb6f92 guifg=#191724
highlight WarningMsg guibg=#f6c177 guifg=#191724
highlight MoreMsg guifg=#9ccfd8
highlight ModeMsg guifg=#e0def4
highlight Question guifg=#f6c177

" Diffs
highlight DiffAdd guibg=#2a2733 guifg=#9ccfd8
highlight DiffChange guibg=#2a2733 guifg=#f6c177
highlight DiffDelete guibg=#2a2733 guifg=#eb6f92
highlight DiffText guibg=#2a2733 guifg=#c4a7e7

" Spelling
highlight SpellBad gui=undercurl guisp=#eb6f92
highlight SpellCap gui=undercurl guisp=#f6c177
highlight SpellRare gui=undercurl guisp=#c4a7e7
highlight SpellLocal gui=undercurl guisp=#9ccfd8

" Special Syntax
highlight Title guifg=#ebbcba gui=bold
highlight Todo guibg=#f6c177 guifg=#191724 gui=bold
highlight Underlined guifg=#c4a7e7 gui=underline
highlight SpecialKey guifg=#6e6a86
highlight NonText guifg=#6e6a86
highlight Directory guifg=#9ccfd8
highlight Conceal guifg=#6e6a86
