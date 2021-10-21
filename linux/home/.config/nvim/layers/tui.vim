" Do not use translations for Vim's messages (`C` stays for English)
language messages C

colorscheme desert

" Use these instead of EasyMotion
set number
set relativenumber

" Open splits in these directions
set splitbelow splitright

" Use only colors to highlight the window borders, do not add characters
let &fillchars = 'vert: ,stl: ,stlnc: '

" Needed by CursorHold and sawing of swap file
set updatetime=1000

" Refresh window only when a macro run is finished, do not show the process
set lazyredraw

" In terminal do not wait after pressing <Esc>
set ttimeout ttimeoutlen=0 notimeout

" Size help window to the same size as other windows
set helpheight=0

" Splits has to be equal even if Vim itself resized
autocmd vimrc VimResized * wincmd =

" Disable the fancy things for view-only buffers
autocmd vimrc FileType man,qf  setlocal nonumber nolist
autocmd vimrc BufNew   __doc__ setlocal nonumber nolist   " pydoc buffer

" Auto-open quickfix window - I don't like to open it up by Neomake.
" See `:help QuickFixCmdPost` and https://github.com/tpope/vim-fugitive#faq
autocmd vimrc QuickFixCmdPost *grep* nested botright cwindow
