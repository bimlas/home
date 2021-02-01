" ~/.vimrc
"
" TIPP: Ha nem ismered a folding hasznalatat, a zR kinyitja az osszes
" konyvjelzot.
"
" ==================== BimbaLaszlo (.github.io|gmail.com) ====================

" Use the minimal setting for debugging.
" source $HOME/.vimrc_minimal | finish

"                               BOILERPLATE                               {{{1
" ============================================================================

" Sok plugin es beallitas igenyli.
set nocompatible

" Gyorsitja a vim mukodeset.
if v:version >= 704
  set regexpengine=1
endif

" Nem szeretem a magyar uzeneteket (a C az angol megfeleloje).
language messages C

" Letrehozunk egy autocmd group-ot.
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
augroup vimrc
  autocmd!
augroup END

"                                NEOVIM                                   {{{1
" ============================================================================

if has('nvim')
  if has('win32')
    " Run `:CheckHealth` to verify.

    " pip2 install --upgrade neovim
    let g:python_host_prog = 'c:/app/python2/python.exe'
    " pip3 install --upgrade neovim
    " NOTE: If `:CheckHealth` not works, try `pip3 uninstall msgpack; pip3
    " install msgpack`.
    let g:python3_host_prog = 'c:/app/python3/python.exe'
    " gem update neovim
    let g:ruby_host_prog = 'c:/app/ruby/bin/ruby.exe'
    let g:ruby_default_path = ['c:/app/ruby']
  endif
endif

"                          WIN / NIX BEALLITASOK                          {{{1
" ============================================================================

" Add external binaries to PATH (like ctags, rg, etc.).
let $PATH .= (has('win32') ? ';' : ':') . $HOME . '/.vim/bin'

if has('win32')
  " Add the basic Linux tools (via Msys-Git) to the PATH.
  let $PATH = $PATH . ';c:/app/git/usr/bin'

  " Backslash (\) helyett forwardslash (/) hasznalat az utvonalakban
  " (pl. <C-X><C-F> kiegeszitesenel).
  " Tapasztalatbol mondhatom, hogy nem minden plugin szereti (pl. Jedi-vim) -
  " ha valamelyik nem mukodik, probald meg kommentelve is.
  " set shellslash

  " :make ezt a programot hasznalja:
  set makeprg=mingw32-make

endif

"                                PLUGINOK                                 {{{1
" ============================================================================

" Disable some default plugins.
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_logiPat           = 1

" Disable the loading of the menupoints to speed up startup. If you want to
" open up the font selector, use `set guifont=*`
let did_install_default_menus = 1
let did_install_syntax_menu   = 1

call bimlas#plugins#configure('netrw')

" .. SAJAT ..............................

call bimlas#plugins#configure('dotvim')
call bimlas#plugins#configure('eightheader')
call bimlas#plugins#configure('high')
call bimlas#plugins#configure('numutils')

" .. MEGJELENES .........................
" http://bytefluent.com/vivify/
" http://cocopon.me/app/vim-color-gallery/
" http://vimcolors.com/

call bimlas#plugins#configure('neosolarized')

" .. TEXTOBJ-USER .......................

call bimlas#plugins#configure('textobj-user')
call bimlas#plugins#configure('textobj-entire')
call bimlas#plugins#configure('textobj-comment')
call bimlas#plugins#configure('textobj-pastedtext')
call bimlas#plugins#configure('textobj-between')
call bimlas#plugins#configure('textobj-parameter')
call bimlas#plugins#configure('textobj-variable-segment')

" .. SZOVEG KERESESE/MODOSITASA .........

call bimlas#plugins#configure('visualstar')

" .. EGYEB HASZNOSSAGOK .................

call bimlas#plugins#configure('open-browser')

" .. FAJLTIPUSOK ........................

call bimlas#plugins#configure('asciidoctor')

if(!exists('g:vimrc_minimal_plugins'))

  " .. KURZOR MOZGATASA ...................

  call bimlas#plugins#configure('easymotion')

  " .. SZOVEG KERESESE/MODOSITASA .........

  call bimlas#plugins#configure('qf')
  call bimlas#plugins#configure('sandwich')
  call bimlas#plugins#configure('abolish')
  call bimlas#plugins#configure('exchange')
  call bimlas#plugins#configure('easy-align')
  call bimlas#plugins#configure('textconv')

  " .. FAJLOK/BUFFEREK/STB. BONGESZESE ....

  call bimlas#plugins#configure('dirvish')
  call bimlas#plugins#configure('fzf')

  " .. EGYEB HASZNOSSAGOK .................

  call bimlas#plugins#configure('linediff')
  call bimlas#plugins#configure('highlightedyank')
  call bimlas#plugins#configure('diff-enhanced')
  call bimlas#plugins#configure('repeat')
  call bimlas#plugins#configure('scriptease')
  call bimlas#plugins#configure('rooter')

  " .. PROGRAMOZAS ........................

  call bimlas#plugins#configure('tcomment')
  call bimlas#plugins#configure('lexima')
  call bimlas#plugins#configure('quickrun')
  call bimlas#plugins#configure('deoplete')
  call bimlas#plugins#configure('ultisnips')
  call bimlas#plugins#configure('snippets')

  " .. GIT ................................

  call bimlas#plugins#configure('gina')
  call bimlas#plugins#configure('gitgutter')

  " .. DEBUG/BENCHMARK/VIML DEVELOPMENT ...

  "                               CHEATSHEET                               {{{
  "
  " Analyse startuptime:
  "   $ vim --startuptime startup.txt
  "
  "   If you want to list time of function calls:
  "   $ vim --cmd 'profile start times.txt | profile func * | profile file *'
  "   \ -c 'profile pause' -c 'noau qall!'
  "   $ vim -c 'set ft=vim nofoldenable' times.txt
  "
  "   If you want to benchmark functions of Unite for example, then use
  "   `profile func unite*`.
  "
  " Debug a command
  "   debug CommandName
  "
  " Debug a fucntion
  "   debug call FunctionName(arg)
  "
  " Add breakpoint to function
  "   breakadd func [lineNumber] functionName
  "
  " Add breakpoint to file
  "   breakadd file [lineNumber] fileName
  "
  " Add breakpoint to current line of current file
  "   breakadd here
  "
  " Delete breakpoint number from breaklist output
  "   breakdel number
  "
  " Delete all breakpoints
  "   breakdel *
  "
  " Delete breakpoint on function
  "   breakdel func [lineNumber] functionName
  "
  " Delete breakpoint on file
  "   breakdel file [lineNumber] fileName
  "
  " Delete breakpoint at current line of current file
  "   breakdel here
  "
  " Commands in debug mode:
  "   cont:      continue execution until the next breakpoint (if one exists)
  "   quit:      stop current execution, but still stops at the next
  "              breakpoint
  "   step:      execute the current command and come back to debug mode when
  "              it is finished
  "   next:      like step except it also steps over function calls and
  "              sourced files
  "   interrupt: like quit, but returns to debug mode for the next command
  "   finish:    finishes the current script or function and returns to debug
  "              mode for the next command
  "
  " Levels of :verbose (for example :9verbose COMMAND)
  "   >= 1  When the viminfo file is read or written.
  "   >= 2  When a file is ":source"'ed.
  "   >= 5  Every searched tags file and include file.
  "   >= 8  Files for which a group of autocommands is executed.
  "   >= 9  Every executed autocommand.
  "   >= 12 Every executed function.
  "   >= 13 When an exception is thrown, caught, finished, or discarded.
  "   >= 14 Anything pending in a ":finally" clause.
  "   >= 15 Every executed Ex command (truncated at 200 characters).
  "
  " To set verbose permanently:
  "   set verbose=123
  "
  " To output :verbose to a file:
  "   set verbosefile=filename.txt
  "                                                                        }}}

  call bimlas#plugins#configure('themis')

endif

call bimlas#plugins#loadConfiguredPlugins()

"                              ALAPVETO MUKODES                           {{{1
" ============================================================================

" Disable GUI menubar - this flag (M) have to be in here (in the .vimrc,
" before `filetye syntax on`), not in .gvimrc.
set guioptions=M

" Fajltipus felismeres bekapcsolasa, a ra jellemzo formazas (pl. kommentkari)
" es behuzas stilusanak betoltese.
if exists(':filetype')
  filetype plugin indent on
endif

" Szintaxiskiemeles.
if has('syntax')
  syntax enable
endif

" Eger viselkedese.
behave xterm

" Manual bongeszesenek lehetosege.
if !has('win32')
  runtime ftplugin/man.vim
endif

"                                 COLORS                                  {{{1
" ============================================================================

" Use GUI colors in terminal.
set termguicolors

"                                DEFAULTS                                 {{{2
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

"                                 DESERT                                  {{{2
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

                                                                        " }}}2

" Ligh background at day, dark at night.
try
  if has('gui_running') && strftime("%H") >= 7 && strftime("%H") <= 17
    set background=light
  else
    set background=dark
  endif
  colorscheme NeoSolarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

"                            MODE-AWARE CURSOR                            {{{1
" ============================================================================

" https://github.com/blaenk/dots/blob/9843177fa6155e843eb9e84225f458cd0205c969/vim/vimrc.ln#L49-L64
set guicursor+=o:hor50-OperatorCursor
set guicursor+=n:Cursor
set guicursor+=i-ci-sm:ver25-InsertCursor
set guicursor+=r-cr:ReplaceCursor-hor20
set guicursor+=c:Cursor
set guicursor+=v-ve:VisualCursor

"                               STATUSLINE                                {{{1
" ============================================================================

" Mindig mutassa a statusline-t.
set laststatus=2

let stat_argnr        = '%a'
let stat_buftype      = '%w%h%q'
let stat_filename     = '%t'
let stat_flags        = '%r%m'
let stat_binary       = '%{&binary ? "BINARY" : ""}'
let stat_filetype     = '%{&filetype}'
let stat_fileformat   = '%{&fenc ? &fenc : &enc}%{&bomb ? "-bom" : ""} %{&ff}'

let &statusline  = stat_argnr . ' '
let &statusline .= '%#StatInfo#' . stat_buftype . ' '
let &statusline .= '%#StatFilename#' . stat_filename . '%(' . stat_flags . ' %)'
let &statusline .= '%#StatWarning#%( ' . stat_binary . ' %)'
let &statusline .= '%#StatInfo# [%#StatFileformat#' .stat_filetype . '%#StatInfo#]'
let &statusline .= '[%#StatFileformat#' . stat_fileformat . '%#StatInfo#] '
let &statusline .= '%*'

"                                 ALTALANOS                               {{{1
" ============================================================================

" Fajlnev es current working directory kiirasa a cimsorban.
let &titlestring = '%f | CWD: %{getcwd()}'

" Szoveg szelessege - ugyan a fajlok beallitasahoz kene tenni, de szamitasok
" miatt itt mar be kell allitani.
set textwidth=78

" Sorok szamozasara szant oszlop szelessege.
set numberwidth=6

" Minden valtoztatasrol tajekoztasson.
set report=0

" Operatorra varo parancs mutatasa (pl. makro rogzitesehez hasznalt 'q'),
" kijelolesnel a kijeloles merete.
set showcmd

" Mod (insert, visual, stb.) mutatasa.
set showmode

" Kellokepp magas legyen a statusline alatti terulet.
set cmdheight=2

" Completion in the command line:
" - <Tab> expands string to the longest common part
" - Second <Tab> shows all match
" - Starting from the third will iterate on the list
set wildmode=longest,list,full

" Use only buffer's dir.
set path=.

" Mindig mutassa a tabokat (megnyitott fajlokat, nem a TAB karakteret).
set showtabline=2

" Az ablakok kozti elvalaszto ne tartalmazzon karaktereket, csak a szinezes jelolje a hatarokat.
let &fillchars = 'vert: ,stl: ,stlnc: '

" Kurzor koruli 'ter' gorgetesnel.
set scrolloff=3

" A sor utolso karaktere utan egyel is allhat a kurzor.
" NAGYON HASZNOS TUD LENNI!
set virtualedit=onemore

" Mindig legyen eger.
set mouse=a

" Makrok futtatasanal ne frissitse a kepernyot, csak ha vegzett.
set lazyredraw

" Do not make visual/audio bell (have to be in .gvimrc too).
set visualbell t_vb=
set belloff=all

" Tordelje el a hosszu sorokat. (softbreak)
set wrap

" ... csak a megadott karakterek utan (a szavakat ne torje el).
set linebreak
let &breakat = " \t;:,/])}"

" A wrap-al tort sorokat huzza be ugy, hogy az elozo sor behuzasat kovesse.
set breakindent

" Sorok osszefuzesenel ket szokoz helyett csak egyet tegyen.
set nojoinspaces

" Bufferek kozti valtasnal ne mentse automatikusan azok tartalmat.
set hidden

" Mindig az aktualis fajl konyvtara legyen a cwd.
" Tapasztalatbol mondhatom, hogy nem minden plugin szereti (pl. netrw,
" fugitive).
" UPDATE: a fugitive ugy tunik mar jol kezeli, viszont a vimfiler es unite
" nem.
" set autochdir

" CursorHold-hoz kell es a swap fajl mentesenek idejet is befolyasolja.
set updatetime=1000

" Terminalban ne varakozzon az <Esc>
set ttimeout ttimeoutlen=0 notimeout

" Uj ablakok alulra / jobbra keruljenek. (a help is)
set splitbelow splitright

" Ablakok nyitasanal / bezarasanal mindig ugyanakkorara meretezze ujra oket.
set equalalways

" A help ablak se foglaljon nagyobb helyet.
set helpheight=0

" A Vim alapertelmezett karakterkodolasa. (nem a fajloke)
set encoding=utf8

"                             FAJLOK BEALLITASAI                          {{{1
" ============================================================================

" Fajlok elore megadott beallitasait hasznalhatja. (fajl elejen, vagy vegen
" talalhato vim-specifikus beallitasok)
set modeline

" Lehetseges sorvegzodesek/karakterkodolasok. Uj fajl letrehozasanal az elso
" parametert hasznalja.
" utf8:     amit mindenkinek hasznalnia kene
" utf-16le: Windows registry fajlok (.reg) kodolasa
" cp1250:   magyar Windows default
" default:  a rendszer alapertelmezese
set fileformats=unix,dos fileencodings=utf8,ucs-bom,cp1250,default,utf-16le

" Uj fajlok letrehozasanal nem jelzi ki a karakterkodolast e nelkul.
let &fileencoding = matchstr(&fileencodings, '^[^,]\+')

" Ne csinaljon biztonsagi masolatokat a fajl mentese elott.
set nobackup nowritebackup

" A swap fajlokat csak arra hasznalja, hogy egy szerkesztes alatt levo fajl
" ujboli megnyitasanal figyelmeztessen. A fugitive plugin helyes mukodesehez
" kell.
" Hogy ertsd, mit is csinal, nyiss meg ket ugyanolyan nevu, de kulonbozo
" konyvtarban levo fajlt es figyeld a swap konyvtarat. Zard be oket ugy, hogy
" a swap fajl megmaradjon (pl.: kill, <Ctrl-Alt-Del>), majd nyisd meg oket
" ismet, de most forditott sorrendben. A recovery igy nem fog mukodni.
let s:swapdir = $HOME.'/.vim/swap'
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir

" Persistent undo.
let s:undodir = $HOME.'/.vim/undo'
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
let &undodir = s:undodir
set undofile

"                                  KERESES                                {{{1
" ============================================================================

" NOTE: a vimgrep kihagyja azokat a fajlokat, amik a wildignore-ban
" szerepelnek, valamint a rejtett konyvtarakat is (pl. .git).

" Case insensitive keresesnel, de nagybetus szoveg eseten case sensitive-re
" valt.
set ignorecase smartcase

" Kereses talalatainak kiemelese mar begepeles kozben.
set hlsearch incsearch

" Mivel nem mindig veszem eszre, hogy a fajl vegerol mar atugrottam az
" elejere, ezert inkabb le is tiltom ezt a lehetoseget.
set nowrapscan

" I using Git grep most of the time instead of standard grepping tools.
let &grepprg = 'git grep -n'

if has('nvim')
  set inccommand=nosplit
endif

"                             SZINTAXIS KIEMELES                          {{{1
" ============================================================================

" Hide what intend to be hidden
set conceallevel=2

" Shell-scrip-eknel ne jelezze hibanak: $()
let is_posix = 1

" Specialis karakterek (tabulator, sor vegi whitespace) mutatasa.
if has('gui_running')
  set list listchars=tab:▶‒,nbsp:∙,trail:∙,extends:▶,precedes:◀
else
  set list listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<
endif

" Sortores mutatasa.
if has('gui_running')
  let &showbreak = '↳'
else
  let &showbreak = '^'
endif

" Helyesiras ellenorzes magyarra es angolra allitasa.
set spelllang=hu,en

"                                  BEHUZAS                                {{{1
" ============================================================================

" Automatikus behuzas { utan is.
set autoindent smartindent

" A behuzas merteke szokozokben megadva - a > es < karakterekkel toreno
" behuzasnal a shiftwidth tobbszorosere mozgassa a szoveget.
set shiftwidth=2 shiftround

" Tab helyett szokozok hasznalata.
set expandtab

" 1 tabulator a shiftwidth-nek megfelelo szokozt fog beirni.
let &softtabstop = &sw

" A backspace ezeket torolje: indent, end of line, start
set backspace=2

" Ha a formatoptions-ben szerepel az 'n', akkor a mintara illeszkedo reszeket
" fogja listaelem-jelolonek tekinteni. Mivel az asciidoc tobb karaktert is
" hasznal a listakhoz, ezert modositani kellett ezt a beallitast.
let &formatlistpat = '^\s*[0-9\.]\+[\]:.)}\t ]\s*'

" C forraskod formazasa.
" (0    Nyitottan maradt zarojelekel egy oszlopban kezdje az uj sort.
" t0    A fuggveny tipusa maradjon a margon.
" W2    Ha egy zarojelparos kulon sorban van, es a nyito zarojel utan
"       nincs non-white kari, akkor a kovetkezo sort 2 szokozzel bentebb
"       kezdi.
set cinoptions=(0,t0,W2

"                                  FOLDING                                {{{1
" ============================================================================

" Behuzas szerint kulonuljenek el a blokkok.
set foldmethod=marker

"                                  DIFFEXPR                               {{{1
" ============================================================================
"
" :help diff-diffexpr: a --minimal kapcsolot hozzatettem.
" A diff manual-bol:
"
"   -d
"   --minimal
"      Change the algorithm perhaps find a smaller set of changes. This makes
"      diff slower (sometimes much slower)

if &diffexpr == ''
  set diffexpr=MyDiff()
endif
function! MyDiff()
    let opt = ''
    if &diffopt =~ 'icase'
      let opt = opt . '-i '
    endif
    if &diffopt =~ 'iwhite'
      let opt = opt . '-b '
    endif
    silent execute '!diff -a --binary --minimal ' . opt . ' "' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
endfunction

"                               KODKIEGESZITES                            {{{1
" ============================================================================

" <C-N> kiegeszitesnel a sztringeket vegye:
" .  ebbol a fajlbol
" i  include fajlokbol
" t  tags fajlbol
" set complete=.,i,t

" Behaviour of insert-mode completion (omnicomplete):
" menuone  Show popup menu even if there is only one item
" noinsert,noselect  Let the user choose the item
set completeopt=menuone,noinsert,noselect

" Fuggvenyek parametereit is mutatja kiegeszitesnel.
set showfulltag

"                                COMMANDS                                 {{{1
" ============================================================================

command W noautocmd w
command Wall noautocmd wall

"                             ABBREVATIONS                                {{{1
" ============================================================================

cabbrev argdo silent argdo silent

"                                    MAP                                  {{{1
" ============================================================================
"
" A specialis gombok kombinacioi (pl.: <S-Up>) TTY-ben nem mukodnek.
"
" HA TERMINALBAN NEM MUKODNENEK A KURZORBILLENTYUK:
"   :verbose imap <Esc>
" Ezen map-ok valamelyike okozza a hibat.

"                                ALTALANOS                                {{{2
" ____________________________________________________________________________

" Almighty homerow.
inoremap <C-F>      <C-X><C-O>
noremap  <C-H>      @
noremap  <C-H><C-H> @@
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

" Take some keys from english keyboard.
noremap é ;
noremap É ,
noremap ő [
noremap ú ]
noremap Ő {
noremap Ú }

" I don't using the ex-mode directly.
nnoremap Q <Nop>

" Show the full path.
nnoremap <C-G> 1<C-G>

" Update everything, not just the screen.
nnoremap <C-L> :nohlsearch <Bar> checktime <Bar> diffupdate <Bar> syntax sync fromstart<CR><C-L>

" Inserting digraphs.
nnoremap <Leader><C-K> a<C-K>

" Don't move to the first match, just highlight those.
nnoremap * *Nzz

" Repeat last :substitute with all of its flags.
nnoremap & :&&<CR>
vnoremap & :&&<CR>

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

" A torles ne masolja a vagolapra a szoveget.
" Azert nem `noremap`, mert az `onoremap` is beletartozna, igy pl. a `cc`
" beutese `"_c"_c` lenne `"_cc` helyett.
" noremap s     "_s
nnoremap S     "_S
vnoremap S     "_S
nnoremap c     "_c
vnoremap c     "_c
nnoremap C     "_C
vnoremap C     "_C
nnoremap d     "_d
vnoremap d     "_d
nnoremap D     "_D
vnoremap D     "_D
nnoremap <Del> "_<Del>
vnoremap <Del> "_<Del>
" Kivagas motion-nel.
nnoremap x     d
nnoremap xx    dd
vnoremap x     d
nnoremap X     dd
vnoremap X     dd
" ... viszont a karakterek felcsereleset meghagyjuk.
nnoremap xp    xp
nnoremap xP    xP

" Az ablakkezelo vagolapjanak hasznalata.
" Hogy a <S-Insert> a sor vegen is normalisan mukodjon:
" set virtualedit=onemore
noremap  <C-Insert> "+y
cnoremap <C-Insert> <C-Y>
cnoremap <S-Insert> <C-R>+
noremap  <S-Insert> "+P
imap     <S-Insert> <C-O><S-Insert>

" Kurzor alatti parancs sugojanak megnyitasa.
autocmd vimrc FileType man call ManMap()
function! ManMap()
  map   <buffer> K    <C-]>
  map   <buffer> <CR> <C-]>
endfunction

"                             NEOVIM SPECIFIC                             {{{2
" ____________________________________________________________________________

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

"                                PLUGINOK                                 {{{2
" ____________________________________________________________________________

"                                  NETRW                                  {{{3
" ............................................................................

" Lynx-szeru mozgas netrw-ben.
autocmd vimrc FileType netrw call NetrwLynxMap()
function! NetrwLynxMap()
  map <buffer> h -
  map <buffer> l <CR>
endfunction

"                               OPENBROWSER                               {{{3
" ............................................................................

" Url megnyitasa a bongeszoben, vagy google a kurzor alatti szora.
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"                              TEXTOBJ-USER                               {{{3
" ............................................................................

omap  i*   <Plug>(textobj-between-i)*
vmap  i*   <Plug>(textobj-between-i)*
omap  a*   <Plug>(textobj-between-a)*
vmap  a*   <Plug>(textobj-between-a)*
omap  i:   <Plug>(textobj-between-i):
vmap  i:   <Plug>(textobj-between-i):
omap  a:   <Plug>(textobj-between-a):
vmap  a:   <Plug>(textobj-between-a):
omap  i#   <Plug>(textobj-between-i)#
vmap  i#   <Plug>(textobj-between-i)#
omap  a#   <Plug>(textobj-between-a)#
vmap  a#   <Plug>(textobj-between-a)#
omap  i/   <Plug>(textobj-between-i)/
vmap  i/   <Plug>(textobj-between-i)/
omap  a/   <Plug>(textobj-between-a)/
vmap  a/   <Plug>(textobj-between-a)/
omap  i\|  <Plug>(textobj-between-i)<Bar>
vmap  i\|  <Plug>(textobj-between-i)<Bar>
omap  a\|  <Plug>(textobj-between-a)<Bar>
vmap  a\|  <Plug>(textobj-between-a)<Bar>

autocmd vimrc FileType ruby call TextObjMapsRuby()
function! TextObjMapsRuby()
  omap <buffer> ab <Plug>(textobj-ruby-block-a)
  omap <buffer> ib <Plug>(textobj-ruby-block-i)
  omap <buffer> af <Plug>(textobj-ruby-function-a)
  omap <buffer> if <Plug>(textobj-ruby-function-i)

  vmap <buffer> ab <Plug>(textobj-ruby-block-a)
  vmap <buffer> ib <Plug>(textobj-ruby-block-i)
  vmap <buffer> af <Plug>(textobj-ruby-function-a)
  vmap <buffer> if <Plug>(textobj-ruby-function-i)
endfunction

autocmd vimrc FileType python call TextObjMapsPython()
function! TextObjMapsPython()
  omap <buffer> af <Plug>(textobj-python-function-a)
  omap <buffer> if <Plug>(textobj-python-function-i)

  vmap <buffer> af <Plug>(textobj-python-function-a)
  vmap <buffer> if <Plug>(textobj-python-function-i)
endfunction

function! AdocBlockA()
  if search('^\(.\)\1\+$\|^.=\+$', 'Wb') == 0 | return 0 | endif
  let searchfor = getline('.')
  let block_start = getpos('.')
  call search(searchfor, 'W')
  let block_stop = getpos('.')
  return ['V', block_start, block_stop]
endfunction

function! AdocBlockI()
  if search('^\(.\)\1\+$\|^.=\+$', 'Wb') == 0 | return 0 | endif
  let searchfor = getline('.')
  normal j
  let block_start = getpos('.')
  call search(searchfor, 'W')
  normal k
  let block_stop = getpos('.')
  return ['V', block_start, block_stop]
endfunction

"                               SPACE MAPS                                {{{2
" ____________________________________________________________________________
"
" Idea taken from Spacemacs: https://github.com/syl20bnr/spacemacs

noremap  <Space>?       :Maps<CR>

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

map      <Space>j       <Plug>(easymotion-sol-j)
map      <Space>k       <Plug>(easymotion-sol-k)
" Stay in the same column.
map      <Space>J       <Plug>(easymotion-j)
map      <Space>K       <Plug>(easymotion-k)

nmap     <Space>c       <Plug>TComment_gc
vmap     <Space>c       <Plug>TComment_gc
nmap     <Space>cc      <Plug>TComment_gcc

"                         <Space>a - APPLICATIONS                         {{{3
" ............................................................................

" TODO: xterm cwd

" Simple calculator/evaulator.
map      <Space>ac g!
nnoremap <Space>aC :PP<CR>

" Open terminal (shell).
nnoremap <expr> <Space>as   has('win32')
                            \ ? ':silent !start conemu64.exe /dir "'.expand('%:p:h').'" /cmd powershell<cr>'
                            \ : ':silent !cd '.expand('%:p:h').'; xterm; cd -<CR>'

" Profiling.
nnoremap <Space>app :profile start ./profile.log <Bar> profile func * <Bar> profile file * <Bar>
                    \ echomsg "Profiling started, <lt>Space>apq to stop it (and quit from Vim!)."<CR>
nnoremap <Space>apq :profile pause <Bar> noautocmd qall<CR>
nnoremap <Space>apb :BenchVimrc<CR>

"                           <Space>b - BUFFERS                            {{{3
" ............................................................................

nnoremap <Space>bb :Buffers<CR>
nnoremap <Space>bd :bdelete<CR>
nnoremap <Space>bD :bdelete!<CR>
" Move to next/previous argument (:args).
nnoremap <Space>bn :next<CR>
nnoremap <Space>bp :previous<CR>
nnoremap <Space>bf :first<CR>

"                             <Space>d - DIFF                             {{{3
" ............................................................................

nnoremap <Space>dn ]c
nnoremap <Space>dp [c
nnoremap <Space>dt :diffthis<CR>
vnoremap <Space>dt :Linediff<CR>
nnoremap <Space>do :let b=bufnr('%')<CR>:bufdo diffoff!<CR>:exe 'buffer ' . b<CR>
nnoremap <Space>du :diffupdate<CR>

"                            <Space>f - FILES                             {{{3
" ............................................................................

" TODO: UniteWithBufferDir - ~ not goes to $HOME; Unite file:%:p:h not goes to ../
nnoremap <Space>F   :find<Space>
nnoremap <Space>fe  :VimFilerExplorer<CR>
nnoremap <Space>ff  :Dirvish %<CR>
nnoremap <Space>fF  :Dirvish<CR>
nmap     <Space>fp  :Files<CR>
nnoremap <Space>fvg :edit $MYGVIMRC<CR>
nnoremap <Space>fvm :edit ~/.vimrc_minimal<CR>
nnoremap <Space>fvv :edit $MYVIMRC<CR>

"                             <Space>g - GIT                              {{{3
" ............................................................................

nnoremap <Space>ga :Gina commit --amend<CR>
nnoremap <Space>gb :Gina branch<CR>
nnoremap <Space>gB :Gina blame :<CR>
nnoremap <Space>gc :Gina commit<CR>
nnoremap <Space>gd :Gina diff<CR>
nmap     <Space>gD <Plug>(GitGutterPreviewHunk)
nnoremap <Space>gg :silent Gina grep --ignore-case -C3 '' -- ':/'<S-Left><S-Left><S-Left><Right>
nnoremap <Space>gG :silent Gina qrep --ignore-case '' -- ':/'<S-Left><S-Left><S-Left><Right>
nnoremap <Space>gl :Gina l<CR>
nnoremap <Space>gL :Gina l -- %<CR>
nnoremap <Space>gm :Gina chaperon<CR>
nnoremap <Space>gn :GitGutterNextHunk<CR>
nnoremap <Space>gp :GitGutterPrevHunk<CR>
nmap     <Space>gr :Gina checkout %<CR><C-L>
nmap     <Space>gR <Plug>(GitGutterUndoHunk)
nnoremap <Space>gs :Gina status<CR>
nmap     <Space>gw :Gina add %<CR><C-L>
nmap     <Space>gW <Plug>(GitGutterStageHunk)

"                    <Space>m - MODE (FILETYPE) AWARE                     {{{3
" ............................................................................

map             <Space>mK  <Plug>Zeavim
nnoremap        <Space>mg  :noautocmd vimgrep //j <C-R>=expand('%:p:h')<CR>/**/*.%:e <Bar> copen<Home><C-Right><C-Right><Right><Right>
noremap         <Space>mr  :QuickRun<CR>
noremap  <expr> <Space>mR  ':QuickRun ' . &filetype . 'Custom<CR>'
nnoremap        <Space>mt  :Tags<CR>

" Testing (checking
nnoremap        <Space>mcc :TestNearest<CR>
nnoremap        <Space>mcf :TestFile<CR>
nnoremap        <Space>mcl :TestLast<CR>
nnoremap        <Space>mcv :TestVisit<CR>

" Definition
nnoremap         <Space>mOd :Gtags -i <C-R>=expand('<cword>')<CR><CR>
" Reference
nnoremap         <Space>mOr :Gtags -ir <C-R>=expand('<cword>')<CR><CR>
" Symbol (usefull for variables)
nnoremap         <Space>mOs :Gtags -si <C-R>=expand('<cword>')<CR><CR>

" __ VIM ________________________________

autocmd vimrc FileType vim noremap <buffer> <Space>m8
\ :call EightHeader(78, 'left', 1, ' ', '{'.'{{2' , '')<CR><CR>

autocmd vimrc FileType vim nnoremap <buffer> <Space>ms  :PP<CR>

" __ VIMHELP ____________________________

autocmd vimrc FileType help nnoremap <buffer> <Space>m1
\ :call EightHeader(78, 'left', 1, ' ', '\= "*".matchstr(s:str, ";\\@<=.*")."*"', '\= matchstr(s:str, ".*;\\@=")')<CR><CR>

autocmd vimrc FileType help noremap <buffer> <Space>m2
\ :call EightHeader(78, 'left', 1, '.', '\= "\|".matchstr(s:str, ";\\@<=.*")."\|"', '\= matchstr(s:str, ".*;\\@=")')<CR><CR>

" __ ASCIIDOC ___________________________

autocmd vimrc FileType asciidoc,asciidoctor vnoremap <Space>mq :AdocFormat<CR>$hD

" __ RUBY _______________________________

autocmd vimrc FileType ruby nnoremap <buffer>       <Space>mb Orequire 'pry'; binding.pry<Esc>
autocmd vimrc FileType ruby nnoremap <buffer><expr> <Space>ms has('win32')
                                                              \ ? ':silent !start conemu64.exe /cmd irb.bat<CR>'
                                                              \ : ':silent !xterm -c irb &<CR>'

" __ PYTHON _____________________________

autocmd vimrc FileType python nnoremap <buffer><expr> <Space>ms has('win32')
                                                                \ ? ':silent !start conemu64.exe /cmd python.exe<CR>'
                                                                \ : ':silent !xterm -c python &<CR>'

"                        <Space>n - PLUGIN MANAGER                        {{{3
" ............................................................................

nnoremap <Space>nc :PlugClean<CR>
nnoremap <Space>nd :Plug '' <Bar> PlugInstall<S-Left><S-Left><S-Left><Right>
nnoremap <Space>ni :PlugInstall<CR>
nnoremap <Space>nl :PlugDiff<CR>
nnoremap <Space>nu :PlugUpdate <Bar> PlugUpgrade<CR>

"                <Space>q - QUOTES, SURROUNDS, CHANGE CASE                {{{3
" ............................................................................

nmap <Space>qa  <Plug>(operator-sandwich-add)
vmap <Space>qa  <Plug>(operator-sandwich-add)
nmap <Space>qs  <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <Space>qd  <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

nmap <Space>qcc <Plug>Coercec
nmap <Space>qcm <Plug>Coercem
nmap <Space>qc_ <Plug>Coerce_
nmap <Space>qcs <Plug>Coerces
nmap <Space>qcu <Plug>Coerceu
nmap <Space>qcU <Plug>CoerceU

"                            <Space>s - SEARCH                            {{{3
" ............................................................................

nnoremap <Space>ss :Rg<CR>
nnoremap <Space>sg :noautocmd vimgrep //j ## <Bar> copen<Home><C-Right><C-Right><Right><Right>
nnoremap <Space>sl :Lines<CR>

"                            <Space>t - TOGGLE                            {{{3
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

"                    <Space>w - WINDOW/TAB MANAGEMENT                     {{{3
" ............................................................................

nnoremap <Space>wo  :tab split<CR>
nnoremap <Space>wn  :botright 78 vnew [NOTES]<Bar> set ft=asciidoc buftype=nofile nonumber norelativenumber<CR>
nnoremap <Space>wm  :let ft=&filetype <Bar> exe 'new [' . ft . ']' <Bar> let &filetype=ft <Bar> set buftype=nofile<CR>
nnoremap <Space>wtt :tabnew<CR>
nnoremap <Space>wtq :tabclose<CR>

"                      <Space>x - TEXT MODIFICATION                       {{{3
" ............................................................................

nnoremap <Space>x0  :silent call dotvim#contact#call()<CR><CR>
nnoremap <Space>x1  :silent call EightHeader(&tw, 'center', 0, '=', ' {' . '{{1', '')<CR><CR>
nnoremap <Space>x2  :silent call EightHeader(&tw, 'center', 0, '_', ' {' . '{{2', '')<CR><CR>
nnoremap <Space>x3  :silent call EightHeader(&tw, 'center', 0, '.', ' {' . '{{3', '')<CR><CR>
nnoremap <Space>x4  :silent call EightHeader(0 - (&tw / 2), 'left', 1, ['__', '_', ''], '', '\= " " . s:str . " "')<CR><CR>
nnoremap <Space>x8  :silent call EightHeader(78, 'left', 1, ' ', '{'.'{{' , '')<CR><CR>
nnoremap <Space>x9  :silent call EightHeader(78, 'left', 1, ' ', '}'.'}}' , '')<CR><CR>

nmap     <Space>xcc <Plug>(EasyAlign)ip
nmap     <Space>xc  <Plug>(EasyAlign)
vmap     <Space>xc  <Plug>(EasyAlign)

"                                AUTOCOMMAND                              {{{1
" ============================================================================
"
" WARNING: The order of autocommands can lead to unexpected behaviour! Try to
" reorder in this case.

autocmd vimrc BufEnter *.adoc set filetype=asciidoctor

" Set up omni-completion if not already set.
autocmd vimrc FileType * if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif

" Splits has to be equal even if Vim itself resized.
autocmd vimrc VimResized * wincmd =

" Disable the fancy things for view-only buffers.
autocmd vimrc FileType man,qf  setlocal nonumber nolist
autocmd vimrc BufNew   __doc__ setlocal nonumber nolist   " pydoc buffer

" Disable folding in diffs.
autocmd vimrc FileType diff setlocal nofoldenable

" Auto-open quickfix window - I don't like to open it up by Neomake.
" See `:help QuickFixCmdPost` and https://github.com/tpope/vim-fugitive#faq
autocmd vimrc QuickFixCmdPost *grep* nested botright cwindow

" Load project settings.
"
" Usefull for setting up tags to include another
" project's tag file.
" Before loading project-specific settings, reset `tags` to prevent mixing of
" not relevant tag files.
"
" Using a Git hook to generate tags.
" http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
" Triggered by vim-rooter's autocommand.
" https://github.com/airblade/vim-rooter
autocmd vimrc VimEnter * call LoadProjectSettings()
autocmd vimrc User RooterChDir call LoadProjectSettings()

function! LoadProjectSettings() "{{{
  set tags=.git/tags
  try
    source .lvimrc
  catch /^Vim\%((\a\+)\)\=:E484/
  endtry
endfunction "}}}

"                               FIRENVIM                                  {{{1
" ============================================================================

if exists('g:started_by_firenvim')
  " Statusline
  set laststatus=0
  " Tabline
  set showtabline=0

  colorscheme morning

  autocmd FileType * set filetype=tiddlywiki textwidth=0
endif
