" Nem szeretem a magyar uzeneteket (a C az angol megfeleloje).
language messages C

" A Vim alapertelmezett karakterkodolasa. (nem a fajloke)
set encoding=utf8

" Mindig legyen eger.
set mouse=a

" Eger viselkedese.
behave xterm

" Mindig mutassa a tabokat (megnyitott fajlokat, nem a TAB karakteret).
set showtabline=2

" Sorok szamozasara szant oszlop szelessege.
set numberwidth=6

" Uj ablakok alulra / jobbra keruljenek. (a help is)
set splitbelow splitright

" Ablakok nyitasanal / bezarasanal mindig ugyanakkorara meretezze ujra oket.
set equalalways

" A help ablak se foglaljon nagyobb helyet.
set helpheight=0

" Az ablakok kozti elvalaszto ne tartalmazzon karaktereket, csak a szinezes jelolje a hatarokat.
let &fillchars = 'vert: ,stl: ,stlnc: '

" Do not make visual/audio bell (have to be in .gvimrc too).
set visualbell t_vb=
set belloff=all

" CursorHold-hoz kell es a swap fajl mentesenek idejet is befolyasolja.
set updatetime=1000

" Makrok futtatasanal ne frissitse a kepernyot, csak ha vegzett.
set lazyredraw

" Terminalban ne varakozzon az <Esc>
set ttimeout ttimeoutlen=0 notimeout

" Splits has to be equal even if Vim itself resized.
autocmd vimrc VimResized * wincmd =

" Disable the fancy things for view-only buffers.
autocmd vimrc FileType man,qf  setlocal nonumber nolist
autocmd vimrc BufNew   __doc__ setlocal nonumber nolist   " pydoc buffer

" Auto-open quickfix window - I don't like to open it up by Neomake.
" See `:help QuickFixCmdPost` and https://github.com/tpope/vim-fugitive#faq
autocmd vimrc QuickFixCmdPost *grep* nested botright cwindow
