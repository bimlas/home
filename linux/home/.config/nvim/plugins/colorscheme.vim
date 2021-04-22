" THE colorscheme - i tried but cannot live without it :(
" Actually it's a fork which works in terminal and NeoVim too.
Plug 'icymind/neosolarized'

let g:neosolarized_contrast = 'high'

" Make vertical split visible.
let g:neosolarized_vertSplitBgTrans = 0

" Base16 colorscheme which fits better to my terminal
Plug 'chriskempson/base16-vim'

" Use GUI colors in terminal.
set termguicolors

autocmd  vimrc  VimEnter  *  colorscheme base16-tomorrow-night-eighties

"                                DEFAULTS
" ____________________________________________________________________________

" I had to add VimEnter too, without this, NeoSolarized does not works as I
" want.

" Colors of statusline
autocmd  vimrc  ColorScheme,VimEnter  *
\ highlight! link StatFilename   DiffText   |
\ highlight! link StatFileformat DiffAdd    |
\ highlight! link StatInfo       DiffChange |
\ highlight! link StatWarning    Error

" Mode-aware cursor colors (see below)
autocmd  vimrc  ColorScheme,VimEnter  *
\ highlight! InsertCursor   ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#a96800 |
\ highlight! VisualCursor   ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#006eff |
\ highlight! ReplaceCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#ef0000 |
\ highlight! OperatorCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#c000ff

" Allways display comments with italic fonts.
autocmd  vimrc  ColorScheme,VimEnter  *
\ highlight! Comment term=italic      cterm=italic      gui=italic      |
\ highlight! Folded  term=bold,italic cterm=bold,italic gui=bold,italic

" More visible linebreak, whitespace and other special characters.
autocmd vimrc ColorScheme,VimEnter *
\ highlight! NonText term=bold ctermfg=9 gui=bold guifg=#dc322f             |
\ highlight! link SpecialKey NonText                                        |
\ highlight! Error term=bold ctermfg=9 gui=bold guibg=#dc322f guifg=#ffffff

" Fit diff to my taste.
autocmd  vimrc  ColorScheme,VimEnter  *
\ highlight! link diffFile      DiffChange |
\ highlight! link diffIndexLine DiffChange

"                                 DESERT
" ____________________________________________________________________________

autocmd vimrc ColorScheme desert set background=dark

" Colors of statusline
autocmd  vimrc  ColorScheme  desert
\ highlight! link StatFilename   Directory  |
\ highlight! link StatFileformat Identifier |
\ highlight! link StatInfo       ModeMsg    |
\ highlight! link StatWarning    Error

" I don't like the default colors of the popup-menu (<C-X><C-N>)
autocmd  vimrc  ColorScheme  desert
\ highlight! Pmenu      ctermbg=Black ctermfg=Gray  guibg=#FFFFCC guifg=DarkGray          |
\ highlight! PmenuSel   ctermbg=Black ctermfg=White guibg=#FFFFCC guifg=Black    gui=bold |
\ highlight! PmenuSbar  ctermbg=Black ctermfg=Black guibg=#FFFFCC guifg=#FFFFCC           |
\ highlight! PmenuThumb ctermbg=White ctermfg=White guibg=Black   guifg=Black
