" Disable GUI menubar - this flag (M) have to be in here (in the .vimrc,
" before `filetye syntax on`), not in .gvimrc.
set guioptions=M

" Disable the loading of the menupoints to speed up startup. If you want to
" open up the font selector, use `set guifont=*`
let did_install_default_menus = 1
let did_install_syntax_menu   = 1

" https://github.com/blaenk/dots/blob/9843177fa6155e843eb9e84225f458cd0205c969/vim/vimrc.ln#L49-L64
set guicursor+=o:hor50-OperatorCursor
set guicursor+=n:Cursor
set guicursor+=i-ci-sm:ver25-InsertCursor
set guicursor+=r-cr:ReplaceCursor-hor20
set guicursor+=c:Cursor
set guicursor+=v-ve:VisualCursor

" Fajlnev es current working directory kiirasa a cimsorban.
let &titlestring = '%f | CWD: %{getcwd()}'
