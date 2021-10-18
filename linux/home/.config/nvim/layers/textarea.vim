" Enable filetype detection and load formatting settings (e.g. comment char
" and indentation)
if exists(':filetype')
  filetype plugin indent on
endif

" Syntax highlighting
if has('syntax')
  syntax enable
endif

" 'Vertical margin' of cursor when reaching top or bottom of window
set scrolloff=3

" The cursor can go beyond the last character of the line
" It's really handy sometimes!
set virtualedit=onemore

" Soft break long lines, but do it only at given characters (do not split
" words)
set wrap
set linebreak
let &breakat = " \t;:,/])}"

" Indent soft wrapped lines to the start of the first line
set breakindent

" Show soft breaks visually
if has('gui_running')
  let &showbreak = '↳'
else
  let &showbreak = '^'
endif

" Automatically indent lines if the previous line ends in `{` character
set autoindent smartindent

" Write spaces instead of tabulator character
set expandtab

" Rate of indentation as number of space characters
set shiftwidth=2 shiftround

" Pressing tab will write `shiftwidth` number of spaces
let &softtabstop = &sw

" Show special characters
if has('gui_running')
  set list listchars=tab:▶‒,nbsp:∙,trail:∙,extends:▶,precedes:◀
else
  set list listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<
endif

" Use foldmarker as default foldmethod
set foldmethod=marker

" Ignorcase search, but switch to case sensitive when expression contains
" uppercase letters
set ignorecase smartcase

" For me sometimes it's hard to notice that I went beyond the end of line, so
" don't jump to the beginning of the file when I reached EOF while searching
set nowrapscan

" Set up omni-completion if not already set
autocmd vimrc FileType * if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
