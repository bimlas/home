" Almighty homerow.
inoremap <C-F>      <C-X><C-O>
map      <C-J>      <CR>
imap     <C-J>      <CR>
map      <C-K>      <Esc>
imap     <C-K>      <Esc>
cnoremap <C-K>      <C-C>
noremap  H          g^
noremap  L          g$
noremap  j          gj
noremap  k          gk
noremap  gj         j
noremap  gk         k

" Update everything, not just the screen.
nnoremap <C-L> :nohlsearch <Bar> checktime <Bar> diffupdate <Bar> syntax sync fromstart<CR><C-L>

" Inserting digraphs.
nnoremap <Leader><C-K> a<C-K>

" Don't move to the first match, just highlight those.
nnoremap * *Nzz

" <Up> and <C-P> differs in command line - try it out!
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Pageup/down in pop-up (completion) menu.
inoremap <expr> <C-U> pumvisible() ? '<PageUp>' : '<C-U>'
inoremap <expr> <C-D> pumvisible() ? '<PageDown>' : '<C-D>'

" Hasznosabb backspace/delete. Az <expr> azert kell, mert a sor veget/elejet
" nem torli a d:call search().
" Kell hozza: set virtualedit=onemore
" inoremap <expr> <C-W>  (col(".") == 1       ) ? "<BS>"  : "<C-O>d:call search('\\s\\+\\<Bar>[A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű\\n]\\+\\<Bar>[^A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű]', 'Wb')<CR>"
inoremap <expr> <C-L>  (col(".") == col("$")) ? "<Del>" : "<C-O>d:call search('\\s\\+\\<Bar>[A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű\\n]\\+\\<Bar>[^A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű]', 'W')<CR>"

autocmd vimrc FileType man call ManMap()
function! ManMap()
  map   <buffer> K    <C-]>
  map   <buffer> <CR> <C-]>
endfunction

"                               SPACE MAPS                                {{{1
" ____________________________________________________________________________
"
" Idea taken from Spacemacs: https://github.com/syl20bnr/spacemacs

noremap  <Space><Space>      g<C-]>
noremap  <C-W><Space><Space> <C-W>g<C-]>
nnoremap <Space><Tab>        :buffer #<CR>
nnoremap <Space>0            :set relativenumber!<CR>
vnoremap <Space>0            <Esc>:set relativenumber!<CR>gv

nnoremap <Space>h       :cnext<CR>
nnoremap <Space>H       :cprevious<CR>

nnoremap <Space>L       g,
nnoremap <Space>l       g;

nnoremap <Space>O       :<C-U>put!=repeat(nr2char(10), v:count1)<CR>']
nnoremap <Space>o       :<C-U>put =repeat(nr2char(10), v:count1)<CR>'[

nnoremap <Space>u       :earlier 1f<CR>
nnoremap <Space>U       :later 1f<CR>

map      <Space>y       "+y
noremap  <Space>p       "+p
noremap  <Space>P       "+P

"                           <Space>b - BUFFERS                            {{{2
" ............................................................................

nnoremap <Space>bd :bdelete<CR>
nnoremap <Space>bD :bdelete!<CR>
" Move to next/previous argument (:args).
nnoremap <Space>bn :next<CR>
nnoremap <Space>bp :previous<CR>
nnoremap <Space>bf :first<CR>

"                             <Space>d - DIFF                             {{{2
" ............................................................................

nnoremap <Space>dn ]c
nnoremap <Space>dp [c
nnoremap <Space>dt :diffthis<CR>
nnoremap <Space>do :let b=bufnr('%')<CR>:bufdo diffoff!<CR>:exe 'buffer ' . b<CR>
nnoremap <Space>du :diffupdate<CR>

"                            <Space>f - FILES                             {{{2
" ............................................................................

nnoremap <Space>F   :find<Space>
nnoremap <Space>fvg :edit $MYGVIMRC<CR>
nnoremap <Space>fvm :edit ~/.vimrc_minimal<CR>
nnoremap <Space>fvv :edit ~/.vimrc<CR>

"                            <Space>s - SEARCH                            {{{2
" ............................................................................

nnoremap <Space>sg :noautocmd vimgrep //j ## <Bar> copen<Home><C-Right><C-Right><Right><Right>

"                            <Space>t - TOGGLE                            {{{2
" ............................................................................

nnoremap <expr> <Space>tb ':set background=' . (&background == 'light' ? 'dark' : 'light') . '<CR>'
nnoremap        <Space>tc :let &colorcolumn = ((&cc == '') ? virtcol('.') : '')<CR>
nnoremap        <Space>th :ColorToggle<CR>
nnoremap <expr> <Space>tm ':set guioptions' . (&guioptions =~ 'm' ? '-' : '+') . '=m<CR>'
nnoremap        <Space>tn :set number!<CR>
nnoremap        <Space>tr :set relativenumber!<CR>
nnoremap        <Space>ts :call dotvim#syncwin#call()<CR>
nnoremap <expr> <Space>tt ':set textwidth=' . (&textwidth > 0 ? '0' : '78') . '<CR>'
nnoremap <expr> <Space>tv ':set virtualedit=' . (&virtualedit == 'all' ? 'onemore' : 'all') . '<CR>'
nnoremap        <Space>tw :set wrap!<CR>

"                    <Space>w - WINDOW/TAB MANAGEMENT                     {{{2
" ............................................................................

nnoremap <Space>wo  :tab split<CR>
nnoremap <Space>wn  :botright 78 vnew $HOME/NOTES.adoc<Bar> set ft=asciidoc nobuflisted nonumber norelativenumber<CR>
autocmd vimrc BufLeave $HOME/NOTES.adoc write
nnoremap <Space>wm  :let ft=&filetype <Bar> exe 'new [' . ft . ']' <Bar> let &filetype=ft <Bar> set buftype=nofile<CR>
nnoremap <Space>wtt :tabnew<CR>
nnoremap <Space>wtq :tabclose<CR>
