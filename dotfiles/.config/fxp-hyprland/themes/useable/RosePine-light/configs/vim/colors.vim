" Rosé Pine Light Full Color Scheme for Vim
set background=light
set termguicolors

" Rosé Pine Light Base Colors
highlight Normal guibg=#faf4ed guifg=#575279
highlight NormalFloat guibg=#fffaf3 guifg=#575279
highlight Comment guifg=#9893a5 gui=italic
highlight Constant guifg=#b4637a
highlight String guifg=#ea9d34
highlight Character guifg=#d7827e
highlight Number guifg=#b4637a
highlight Boolean guifg=#b4637a
highlight Float guifg=#b4637a

" Identifiers
highlight Identifier guifg=#d7827e
highlight Function guifg=#d7827e
highlight Variable guifg=#575279

" Statements
highlight Statement guifg=#286983
highlight Conditional guifg=#286983
highlight Repeat guifg=#286983
highlight Label guifg=#286983
highlight Operator guifg=#d7827e
highlight Keyword guifg=#286983
highlight Exception guifg=#b4637a

" Preprocessor
highlight PreProc guifg=#56949f
highlight Include guifg=#56949f
highlight Define guifg=#56949f
highlight Macro guifg=#56949f
highlight PreCondit guifg=#56949f

" Types
highlight Type guifg=#907aa9
highlight StorageClass guifg=#907aa9
highlight Structure guifg=#907aa9
highlight Typedef guifg=#907aa9

" Special
highlight Special guifg=#ea9d34
highlight SpecialChar guifg=#b4637a
highlight Tag guifg=#56949f
highlight Delimiter guifg=#575279
highlight SpecialComment guifg=#9893a5
highlight Debug guifg=#b4637a

" UI Elements
highlight LineNr guifg=#9893a5
highlight CursorLineNr guifg=#575279 gui=bold
highlight CursorLine guibg=#fffaf3
highlight CursorColumn guibg=#fffaf3
highlight ColorColumn guibg=#fffaf3
highlight SignColumn guibg=#faf4ed guifg=#9893a5
highlight FoldColumn guibg=#faf4ed guifg=#9893a5
highlight Folded guibg=#fffaf3 guifg=#9893a5

" Cursor settings
highlight Cursor guibg=#b4637a guifg=#faf4ed
highlight iCursor guibg=#b4637a guifg=#faf4ed
highlight CursorIM guibg=#b4637a guifg=#faf4ed

" Visual Mode
highlight Visual guibg=#f2e9e1
highlight VisualNOS guibg=#f2e9e1

" Search
highlight Search guibg=#ea9d34 guifg=#faf4ed
highlight IncSearch guibg=#b4637a guifg=#faf4ed
highlight MatchParen guibg=#f2e9e1 guifg=#575279 gui=bold

" Status Line
highlight StatusLine guibg=#fffaf3 guifg=#575279
highlight StatusLineNC guibg=#faf4ed guifg=#9893a5
highlight WildMenu guibg=#907aa9 guifg=#faf4ed

" Tab Line
highlight TabLine guibg=#fffaf3 guifg=#9893a5
highlight TabLineSel guibg=#907aa9 guifg=#faf4ed
highlight TabLineFill guibg=#faf4ed guifg=#9893a5

" Pmenu (Completion)
highlight Pmenu guibg=#fffaf3 guifg=#575279
highlight PmenuSel guibg=#286983 guifg=#faf4ed
highlight PmenuSbar guibg=#fffaf3
highlight PmenuThumb guibg=#f2e9e1

" Errors and Warnings
highlight Error guibg=#b4637a guifg=#faf4ed
highlight ErrorMsg guibg=#b4637a guifg=#faf4ed
highlight WarningMsg guibg=#ea9d34 guifg=#faf4ed
highlight MoreMsg guifg=#56949f
highlight ModeMsg guifg=#575279
highlight Question guifg=#ea9d34

" Diffs
highlight DiffAdd guibg=#f2e9e1 guifg=#56949f
highlight DiffChange guibg=#f2e9e1 guifg=#ea9d34
highlight DiffDelete guibg=#f2e9e1 guifg=#b4637a
highlight DiffText guibg=#f2e9e1 guifg=#907aa9

" Spelling
highlight SpellBad gui=undercurl guisp=#b4637a
highlight SpellCap gui=undercurl guisp=#ea9d34
highlight SpellRare gui=undercurl guisp=#907aa9
highlight SpellLocal gui=undercurl guisp=#56949f

" Special Syntax
highlight Title guifg=#d7827e gui=bold
highlight Todo guibg=#ea9d34 guifg=#faf4ed gui=bold
highlight Underlined guifg=#907aa9 gui=underline
highlight SpecialKey guifg=#9893a5
highlight NonText guifg=#9893a5
highlight Directory guifg=#56949f
highlight Conceal guifg=#9893a5