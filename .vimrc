" ~/.vimrc
"
" TIPP: Ha nem ismered a folding hasznalatat, a zR kinyitja az osszes
" konyvjelzot.
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.01.14 13:08 ==

" Sok plugin es beallitas igenyli.
set nocompatible
" Gyorsitja a vim mukodeset.
if v:version >= 704
  set regexpengine=1
endif

" FIGYELEM: Paros jelek kiemelesenek tiltasa - nagyon belassulhat tole az
" egesz vim. A lehetoseget meghagyom a bekapcsolasra, de alapbol ki van
" kapcsolva. (:DoMatchParen kapcsolja be)
autocmd VimEnter * if exists( ':NoMatchParen' ) | execute 'NoMatchParen' | endif
" Ezek sem segitenek:
" let g:matchparen_timeout = 5
" let g:matchparen_insert_timeout = 5

" "Nagyfelbontasu" terminal (pl. xterm), vagy gui eseten igaz az ertekkel ter
" vissza.
function BigTerm()
  return (&term !~ 'ansi\|linux\|win32') || (&columns >= (&textwidth + &numberwidth))
endfunction

"                    NEOBUNDLE PLUGIN-KEZELO INDITASA                     {{{1
" ============================================================================

let neobundle_dir = $HOME . '/.vim/bundle/neobundle.vim'

if isdirectory( neobundle_dir )

  exe 'set runtimepath+=' . neobundle_dir
  call neobundle#begin( $HOME . '/.vim/bundle' )
  filetype off

  " plugin-ok automatizalt telepitese git-en keresztul (is)
  NeoBundleFetch 'shougo/neobundle.vim'

  " Nehany plugin hasznalja. Windows dll:
  " https://github.com/Shougo/vimproc.vim/downloads
  NeoBundle 'Shougo/vimproc.vim', {
  \         'build' : {
  \             'windows' : 'mingw32-make -f make_mingw32.mak',
  \             'linux'   : 'make -f make_unix.mak',
  \            },
  \         }

  " __ GITHUB _____________________________

  " .. SAJAT ..............................

  " sajat fuggvenyek, parancsok, filetype, tippek, stb.
  NeoBundle 'bimbalaszlo/vim-eight'

  " (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...
  NeoBundle 'bimbalaszlo/vim-eightheader'

  " szamok manipulalasa regex segitsegevel
  NeoBundle 'bimbalaszlo/vim-numutils'

  " rovid leirasok programokhoz es programozasi nyelvekhez help formaban
  NeoBundle 'bimbalaszlo/vim-cheatsheets'

  " .. MEGJELENES .........................
  "
  " http://cocopon.me/app/vim-color-gallery/
  " http://vimcolors.com/

  " nagyon szep colorscheme (light es dark is)
  NeoBundle 'altercation/vim-colors-solarized'

  " terminalban jol mutat
  NeoBundle 'morhetz/gruvbox'

  " divatos, de minimalista statusline
  NeoBundle 'itchyny/lightline.vim'

  " .. ALAPVETO ...........................

  " normalisabb mozgas a text-objektumok kozott (w, b, ge, ...)
  NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'

  " gyors mozgas a buffer-en belul
  NeoBundle 'lokaltog/vim-easymotion'

  " tuningolt vimgrep
  NeoBundle 'dkprice/vim-easygrep'

  " quickfix-en beluli fajlokon parancsok vegrehajtasa (Qdo) es masolasa az
  " args-ba (Qargs)
  NeoBundle 'henrik/vim-qargs'

  " parancsok futtatasa visual block-on
  NeoBundle 'vis'

  " kijelolt szoveg keresese * gombbal
  NeoBundle 'thinca/vim-visualstar'

  " sajat text-object
  NeoBundle 'kana/vim-textobj-user'

  " fajlok/tag-ok/stb. gyors keresese - a lehetosegekert lasd :Unite source
  NeoBundle 'shougo/unite.vim'
  NeoBundle 'tsukkee/unite-tag'
  " nerdtree helyett: explorer, ketpaneles commander (unite kell hozza)
  NeoBundle 'shougo/vimfiler.vim'

  " szoveg igazitasa regex kifejezesekkel
  NeoBundle 'godlygeek/tabular'

  " Css szinek megjelenitese.
  " WARNING: Nagyon belassitja a megjelenitest.
  " Plugin 'ap/vim-css-color'

  " log fajlokhoz, mint pl. user.log
  " TODO: automatikus szintaxis felismeres
  NeoBundle 'rfc5424'

  " .. PROGRAMOZAS ........................

  " szovegreszek kommentelese (akar oszlopok is)
  NeoBundle 'scrooloose/nerdcommenter'

  " a fajlban talalhato tag-ek listaja
  " $ install ctags
  NeoBundle 'majutsushi/tagbar'

  " syntax checker
  NeoBundle 'scrooloose/syntastic'

  " automatikus kodkiegeszites
  " lua kell hozza (:version +lua)
  NeoBundle 'shougo/neocomplete.vim'

  " buffer, vagy kijelolt kod futtatasa
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'tyru/open-browser.vim'

  " python irasat nagyban megkonnyito kiegeszitesek / sugok
  " $ pip install jedi
  NeoBundle 'davidhalter/jedi-vim'

  " ruby motyok (pl. omni completion pontosabban mukodik)
  NeoBundle 'vim-ruby/vim-ruby'

  " .. GIT ................................

  " git integracio
  " $ install git
  NeoBundle 'tpope/vim-fugitive'

  " gitk a vim-en belul
  " $ install git
  NeoBundle 'gregsexton/gitv'

  call neobundle#end()

  " Meg van egy utasitas lejebb, a 'filetype plugin indent on' utan.
endif

"                               INSTALLVUNDLE                             {{{2
" ____________________________________________________________________________
"
" Cloning vundle to ~/.vim/bundle/vundle

command  InstallNeoBundle  call InstallNeoBundle()
function InstallNeoBundle()
  let neobundle_repo = 'https://github.com/shougo/neobundle.vim'
  let path = substitute( $HOME . '/.vim/bundle/neobundle.vim', '/', has( 'win32' ) ? '\\' : '/', 'g' )

  if ! executable( 'git' )
    echohl ErrorMsg | echomsg 'Git is not available.' | echohl None
    return
  endif

  if ! isdirectory( path )
    silent! if ! mkdir( path, 'p' )
      echohl ErrorMsg | echomsg 'Cannot create directory (may be a regular file):' | echomsg path | echohl None
      return
    endif
  endif

  echo 'Cloning neobundle...'
  let msg = system( 'git clone "' . neobundle_repo . '" "' . path . '"'  )
  if msg =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . neobundle_repo . ' to ' . path . ':' | echomsg msg | echohl None
    return
  endif

  echo 'NoeBundle installed. Please restart vim.'
  return
endfunction

"                              ALAPVETO MUKODES                           {{{1
" ============================================================================

" Fajltipus felismeres bekapcsolasa, a ra jellemzo formazas (pl. kommentkari)
" es behuzas stilusanak betoltese.
if exists( ':filetype' )
  filetype plugin indent on
endif

" Itt kell lennie.
if exists( ':NeoBundleCheck' )
  NeoBundleCheck
endif

" Szintaxiskiemeles.
if has( 'syntax' ) && filereadable( $VIMRUNTIME . '/syntax/syntax.vim' )
  syntax enable
endif

" Eger viselkedese.
behave xterm

" Manual bongeszesenek lehetosege.
runtime ftplugin/man.vim

" Bovitett % (pl. <body> es </body> kozott ugralhatsz a % parancscsal)
runtime macros/matchit.vim

"                          WIN / NIX BEALLITASOK                          {{{1
" ============================================================================

if has( 'win32' )

  " :make ezt a programot hasznalja:
  set makeprg=mingw32-make

  " Ha egy tomoritett fajlt nyitunk meg, hianyolja ezt a valtozot ezert
  " hibauzenetet ir ki.
  let netrw_cygwin = 0

endif

"                                   SZINEK                                {{{1
" ============================================================================

" Szinsema beallitasa.
" Ha nappal van es a solarized elerheto, hasznaljuk azt.
if has( 'gui_running' )
\ && len( globpath( &runtimepath, 'colors/solarized.vim' ) )
\ && (strftime( "%H" ) >= 7 && strftime( "%H" ) <= 17)

  colorscheme solarized

  set background=light

  " A statusline szinet is beallitjuk.
  if !exists( 'g:lightline' )
    let g:lightline = {}
  endif
  let g:lightline.colorscheme = 'solarized'

elseif len( globpath( &runtimepath, 'colors/gruvbox.vim' ) )

  let g:gruvbox_invert_selection = 0
  let g:gruvbox_contrast = 'soft'

  colorscheme gruvbox
  set background=dark

elseif len( globpath( &runtimepath, 'colors/desert.vim' ) )

  colorscheme desert
  set background=dark

  " Popupmenu szinei nem tetszenek a desert-ben.
  highlight Pmenu      ctermbg=Black ctermfg=Gray  guibg=#FFFFCC guifg=DarkGray
  highlight PmenuSel   ctermbg=Black ctermfg=White guibg=#FFFFCC guifg=Black    gui=bold
  highlight PmenuSbar  ctermbg=Black ctermfg=Black guibg=#FFFFCC guifg=#FFFFCC
  highlight PmenuThumb ctermbg=White ctermfg=White guibg=Black   guifg=Black

endif

" A par nelkuli zarojelek kijelzese alig lathato.
highlight! link Error ErrorMsg

" A soremeles karakterek is egybeolvadnak a szoveggel. Ez a highlight a high
" visibility beallitasokol van atmasolva.
highlight! NonText term=bold ctermfg=9 gui=bold guifg=#dc322f

" A tab, whitespace, stb. szinei is ilyenek legyenek.
highlight! link SpecialKey NonText

" Ne legyenek alahuzva az osszecsukott foldok.
highlight Folded term=bold cterm=bold gui=bold

" Mivel a terminalos szinsema nincs definialva (?), igy nekunk kell erteket
" adni neki.
highlight TagbarHighlight term=inverse ctermfg=White

" A highlight-ok felulirasa nekem jobban tetszo szinekre.
highlight TagListTagName term=inverse ctermfg=White

"                           STATUSLINE (LIGHTLINE)                        {{{1
" ============================================================================

" Mindig mutassa a statusline-t.
set laststatus=2

" __ STATUSLINE _________________________
"
" Azert hasznalok valtozokat, hogy konnyebb legyen szinkronba hozni a
" statusline-t es a lightline-t.

autocmd  BufEnter,BufWritePost  *  let b:stat_curfiledir = expand( "%:p:h" )
let stat_filedir    = '%<%{exists( "b:stat_curfiledir" ) ? b:stat_curfiledir : ""}'
let stat_filename   = '%{&buflisted ? bufnr( "%" ) . ":" : ""}%w%t%r%m'
let stat_fileformat = '%{&binary ? "binary" : ((strlen( &fenc ) ? &fenc : &enc) . (&bomb ? "-bom" : "") . " ") . &ff}'
let stat_tagbar     = '%{winwidth( 0 ) > 120 ? tagbar#currenttag("%s","") : ""}'
let stat_lineinfo   = '%4l:%3p%%|%3v'

let &statusline  = stat_filename . ' | '
let &statusline .= stat_fileformat . ' | '
let &statusline .= '%{(winwidth(0) > 70) ? StatWarn() . " | " : ""}'
let &statusline .= '%{len( StatFugitive() ) ? StatFugitive() . " | " : ""}'
let &statusline .= stat_filedir . ' | '
let &statusline .= '%= '
let &statusline .= stat_tagbar . ' | '
let &statusline .= '%{len( StatSyntastic() ) ? StatSyntastic() . " | " : ""}'
let &statusline .= stat_lineinfo

" __ LIGHTLINE __________________________

" Szinek.
let s:statcolor_lgrey  = ['#eee8d5', '#93a1a1', 188, 109, 'bold']
let s:statcolor_dgrey  = ['#eee8d5', '#657b83', 188, 66,  'bold']
let s:statcolor_sand   = ['#586e75', '#eee8d5', 241, 188, 'bold']
let s:statcolor_red    = ['#eee8d5', '#dc322f', 188, 167, 'bold']
let s:statcolor_green  = ['#005f00', '#afdf00', 22,  148, 'bold']
let s:statcolor_blue   = ['#ffffff', '#268bd2', 17,  32,  'bold']
let s:statcolor_yellow = ['#ffffff', '#b58900', 17,  32,  'bold']

if !exists( 'g:lightline' )
  let g:lightline = {}
endif

let g:lightline.active = {
\     'left'          : [ ['filename'], ['fileformat'], ['statwarn'], ['fugitive'], ['filedir'] ],
\     'right'         : [ ['lineinfo'], ['syntastic'], ['tagbar'] ]
\   }

let g:lightline.inactive = {
\     'left'          : [ ['fullfilename'], ['fugitive'] ],
\     'right'         : [ [] ]
\   }

let g:lightline.component = {
\     'filename'      : stat_filename,
\     'fullfilename'  : '%w%F%r%m',
\     'filedir'       : stat_filedir,
\     'fileformat'    : stat_fileformat,
\     'tagbar'        : stat_tagbar,
\     'lineinfo'      : stat_lineinfo
\   }

let g:lightline.component_function = {
\     'statwarn'      : 'StatWarn',
\     'fugitive'      : 'StatFugitive',
\     'syntastic'     : 'StatSyntastic'
\   }

let g:lightline#colorscheme#solarized#palette = {
\   'normal': {
\     'left'          : [ s:statcolor_green,  s:statcolor_dgrey, s:statcolor_red, s:statcolor_lgrey ],
\     'middle'        : [ s:statcolor_sand ],
\     'right'         : [ s:statcolor_dgrey,  s:statcolor_red ]
\   },
\   'inactive': {
\     'left'          : [ s:statcolor_dgrey ],
\     'middle'        : [ s:statcolor_lgrey ],
\     'right'         : [ s:statcolor_lgrey ]
\   },
\   'insert': {
\     'left'          : [ s:statcolor_green,  s:statcolor_green, s:statcolor_red, s:statcolor_lgrey ],
\     'right'         : [ s:statcolor_green,  s:statcolor_red ]
\   },
\   'visual': {
\     'left'          : [ s:statcolor_blue,   s:statcolor_dgrey, s:statcolor_red, s:statcolor_lgrey ],
\     'right'         : [ s:statcolor_dgrey,  s:statcolor_red ]
\   },
\   'replace': {
\     'left'          : [ s:statcolor_yellow, s:statcolor_dgrey, s:statcolor_red, s:statcolor_lgrey ],
\     'right'         : [ s:statcolor_dgrey,  s:statcolor_red ]
\   },
\   'tabline': {
\     'left'          : [ ['#073642', '#93a1a1', 24,  109, 'bold'] ],
\     'middle'        : [ ['#93a1a1', '#073642', 109, 24,  'bold'] ],
\     'right'         : [ s:statcolor_dgrey, ['#586e75', '#93a1a1', 241, 109, 'bold'] ],
\     'tabsel'        : [ ['#073642', '#fdf6e3', 24,  230, 'bold'] ]
\   }
\ }

" __ STATSYNTASTIC __________________________
"
" Syntastic figyelmeztetesek sorszamai.

function StatSyntastic()
  return exists( ':SyntasticCheck' ) ? SyntasticStatuslineFlag() : ''
endfunction

" __ STATFUGITIVE ___________________________
"
" Branch : commit

" Halozati meghajton nagyon belassit.
let g:statfugitive_disabled = 0
function StatFugitive()
  return (exists( 'b:git_dir' ) && ! g:statfugitive_disabled) ? fugitive#head(7) . ':' . fugitive#buffer().commit()[0:6] : ''
endfunction

" __ STATWARN ___________________________
"
" Mixed end-of-line es -indent, valamint a textwidth-nel hosszabb sorok
" keresese.

" Set up after &textwidth.
let g:statwarn = [ { 'pattern' : '^ .*\n\zs\t\|^\t.*\n\zs ', 'format' : '^%d' },
\                  { 'pattern' : '^.\{79,}',                 'format' : '>%d', 'whitelist' : ['text', ''] },
\                  { 'pattern' : '\r',                       'format' : '$%d' },
\                  { 'pattern' : 'TODO\|FIXME',              'format' : 'T%d' }
\                ]

" Cursorhold max lines.
let g:statwarn_max_lines = 10000

autocmd CursorHold   * if line( '$' ) <= g:statwarn_max_lines | silent! unlet b:statwarn | endif
autocmd BufWritePost * silent! unlet b:statwarn

function StatWarn()

  if exists( 'b:statwarn' ) | return b:statwarn | endif

  let b:statwarn = ''

  if &binary | return b:statwarn | endif

  for searchfor in g:statwarn
    if (has_key( searchfor, 'whitelist' ) && (index( searchfor['whitelist'], &filetype ) <  0)) ||
    \  (has_key( searchfor, 'blacklist' ) && (index( searchfor['blacklist'], &filetype ) >= 0))
      continue
    endif

    let found = search( searchfor['pattern'], 'wnc' )
    if found != 0
      let b:statwarn .= printf( searchfor['format'], found )
    endif
  endfor

  return b:statwarn

endfunction

"                                 ALTALANOS                               {{{1
" ============================================================================

" Fajlnev es current working directory kiirasa a cimsorban.
let &titlestring = '%f | CWD: %{getcwd()}'

" Szoveg szelessege - ugyan a fajlok beallitasahoz kene tenni, de szamitasok
" miatt itt mar be kell allitani.
set textwidth=78

" Sorok szamozasara szant oszlop szelessege.
set numberwidth=6

" Sorok szamozasa, kiveve ha TTY, vagy Win-es parancssor alatt hasznaljuk es
" a szovegterulet nem elegendoen szeles.
if BigTerm()
  " set relativenumber
endif

" Minden valtoztatasrol tajekoztasson.
set report=0

" Operatorra varo parancs mutatasa (pl. makro rogzitesehez hasznalt 'q'),
" kijelolesnel a kijeloles merete.
set showcmd

" Mod (insert, visual, stb.) mutatasa.
set showmode

" Kiegesziteseknel a leghosszabb egyezo reszt irja be magatol, ezutan listazza
" ki a lehetosegeket. ('bash'-szeru)
set wildmode=longest,list

" Mutassa a tabokat (megnyitott fajlokat, nem a TAB karakteret), minimum 2 tab
" eseten.
set showtabline=1 tabline=%!eight#shorttabline#call()

" Az ablakok kozti elvalaszto ne tartalmazzon karaktereket, csak a szinezes jelolje a hatarokat.
let &fillchars = 'vert: ,stl: ,stlnc: '

" Kurzor koruli 'ter' gorgetesnel.
set scrolloff=3

" Mindig legyen eger.
set mouse=a

" Makrok futtatasanal ne frissitse a kepernyot, csak ha vegzett.
set lazyredraw

" Ne adjon ki hangot - a .gvimrc-nek is tartalmaznia kell.
set visualbell vb t_vb=

" Tordelje el a hosszu sorokat a szavak vegenel. (softbreak)
set wrap linebreak

" Sorok osszefuzesenel ket szokoz helyett csak egyet tegyen.
set nojoinspaces

" Bufferek kozti valtasnal ne mentse automatikusan azok tartalmat.
set hidden

" Mindig az aktualis fajl konyvtara legyen a cwd.
" Tapasztalatbol mondhatom, hogy nem minden plugin szereti (pl. netrw,
" fugitive).
" set autochdir

" Terminalban ne varakozzon az <Esc>
set ttimeout ttimeoutlen=0 notimeout

" Mindig az ablakkezelo vagolapjat hasznalja. (y, x, es a tobbi operatornal)
" set clipboard=unnamed

" Uj ablakok alulra / jobbra keruljenek. (a help is)
set splitbelow splitright

" Ablakok nyitasanal / bezarasanal mindig ugyanakkorara meretezze ujra oket.
set equalalways

" A help ablak se foglaljon nagyobb helyet.
set helpheight=0

" A Vim alapertelmezett karakterkodolasa. (nem a fajloke)
set encoding=utf8

" Changlelog beallitasok. (uj bejegyzes hozzaadasa a mai naphoz: \o)
let changelog_username   = 'BimbaLaszlo  <bimbalaszlo@gmail.com>'
let changelog_dateformat = '%Y.%m.%d'

" SQL beallitasok.
let g:ftplugin_sql_omni_key = '<C-X>'

"                             FAJLOK BEALLITASAI                          {{{1
" ============================================================================

" Fajlok elore megadott beallitasait hasznalhatja. (fajl elejen, vagy vegen
" talalhato vim-specifikus beallitasok)
set modeline

" Ne csinaljon biztonsagi masolatokat a fajl mentese elott.
set nobackup nowritebackup

" Lehetseges sorvegzodesek/karakterkodolasok. Uj fajl letrehozasanal az elso
" parametert hasznalja.
set fileformats=unix,dos fileencodings=utf8,cp1250,default

" Uj fajlok letrehozasanal nem jelzi ki a karakterkodolast e nelkul.
let &fileencoding = matchstr( &fileencodings, '^[^,]\+' )

" A swap fajlokat csak arra hasznalja, hogy egy szerkesztes alatt levo fajl
" ujboli megnyitasanal figyelmeztessen. A fugitive plugin helyes mukodesehez
" kell.
" Hogy ertsd, mit is csinal, nyiss meg ket ugyanolyan nevu, de kulonbozo
" konyvtarban levo fajlt es figyeld a swap konyvtarat. Zard be oket ugy, hogy
" a swap fajl megmaradjon (pl.: kill, <Ctrl-Alt-Del>), majd nyisd meg oket
" ismet, de most forditott sorrendben. A recovery igy nem fog mukodni.
" TODO: tempname()-bol fejtse vissza.
let &directory = has( 'win32' ) ? expand( '$TMP' ) : '/var/tmp,/tmp'

"                                  KERESES                                {{{1
" ============================================================================

" Case insensitive keresesnel, de nagybetus szoveg eseten case sensitive-re
" valt.
set ignorecase smartcase

" Kereses talalatainak kiemelese mar begepeles kozben.
set hlsearch incsearch

"                             SZINTAXIS KIEMELES                          {{{1
" ============================================================================

" Egy soron belul max. eddig a karakterig szinezze a szoveget. (hosszu
" soroknal nagyon belassul e nelkul)
set synmaxcol=500

" Shell-scrip-eknel ne jelezze hibanak: $()
let is_posix = 1

" Specialis karakterek (tabulator, sor vegi whitespace) mutatasa.
if has( 'gui_running' )
  set list listchars=tab:▶‒,trail:∙,extends:▶,precedes:◀
else
  set list listchars=tab:>-,trail:.,extends:>,precedes:<
endif

" Sortores mutatasa.
if has( 'gui_running' )
  let &showbreak = '↳ '
else
  let &showbreak = '^ '
endif

" Helyesiras ellenorzes magyarra allitasa.
set spelllang=hu

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

" Sajat foldheader.
let &foldtext = "EightHeaderFolds( '\\= s:fullwidth - 2', 'left', [ repeat( '  ', v:foldlevel - 1 ), repeat( ' ', v:foldlevel - 1 ) . '.', '' ], '\\= s:foldlines . \" lines\"', '' )"

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

set diffexpr=MyDiff()
function MyDiff()
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
set complete=.,i,t

" Kiegeszites menujenek mukodese:
" menuone  Egyetlen lehetoseg eseten is popup menu.
" longest  Nem valasztja ki magatol az elso lehetoseget.
set completeopt=menuone,longest

" Fuggvenyek parametereit is mutatja kiegeszitesnel.
set showfulltag

"                                  RUBY                                   {{{2
" ____________________________________________________________________________

" :help ft-ruby-omni
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1

"                                  PLUGINOK                               {{{1
" ============================================================================

"                               EIGHTHEADER                               {{{2
" ____________________________________________________________________________

let g:EightHeader_comment   = 'call NERDComment( "n", "comment" )'
let g:EightHeader_uncomment = 'call NERDComment( "n", "uncomment" )'

"                                  UNITE                                  {{{2
" ____________________________________________________________________________

" let g:unite_source_tag_show_location = 0
let g:unite_source_tag_max_fname_length = 70

"                                VIMFILER                                 {{{2
" ____________________________________________________________________________

" Ez legyen az alapertelmezett bongeszo.
let g:vimfiler_as_default_explorer = 1

" Egyeni ikonok.
let g:vimfiler_tree_leaf_icon   = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon        = '-'
let g:vimfiler_marked_file_icon = '*'

" Az alternate buffer maradjon a vimfiler, igy a ketpaneles modba konnyebb
" visszavaltani.
let g:vimfiler_restore_alternate_file = 0

" A rejtett fajlokat is mutassa.
let g:vimfiler_ignore_pattern = ''

" Ne ugorjon a konyvtar kinyitasa utan.
let g:vimfiler_expand_jump_to_first_child = 0

" Egyeni beallitasok.
" 'sort_type': 'extension'
if exists( '*vimfiler#custom#profile' )
  call vimfiler#custom#profile( 'default', 'context', { 'safe': 0 } )
endif

"                               EASYMOTION                                {{{2
" ____________________________________________________________________________

" A helymeghatarozashoz hasznalt betuk.
let g:EasyMotion_keys = 'asdfghjkluiopqwer'

"                                EASYGREP                                 {{{2
" ____________________________________________________________________________

" Alapjaba veve a megnyitott fajl tipusaval megegyezo fajlokban keressen.
let EasyGrepMode = 2

" A fajl konyvtaraban keressen, ne a cwd-ben.
let EasyGrepSearchCurrentBufferDir = 1

" Rekurzivan keressen a konyvtarakban.
let EasyGrepRecursive = 1

" De hagyja ki a kovetkezoket...
let g:EasyGrepFilesToExclude = ".svn,.git"

" Rejtett fajlokban is keressen.
let EasyGrepHidden = 1

" Soronkent tobb egyezest is talalhat. (mint pl.: :s///g)
let EasyGrepEveryMatch = 1

" Ne nyisson uj tab-okat a talalatokhoz.
let EasyGrepReplaceWindowMode = 2

"                                   NETRW                                 {{{2
" ____________________________________________________________________________

" Netrw ablakanak abszolut merete.
let g:netrw_winsize = -28

" Ne legyen fejlec.
let g:netrw_banner = 0

" Eger map-ok tiltasa:
let g:netrw_mousemaps = 0

" Alapbol tree nezetben nyissa meg.
" let g:netrw_liststyle = 3

" Csak az a lenyeg, hogy a konyvtarak legyenek elol.
let g:netrw_sort_sequence = '[\/]$,*'

" Mindig az elozo ablakban nyissa meg a fajlt. (:Vexplore-nal kell)
let g:netrw_browse_split = 4

"                                   TAGBAR                                {{{2
" ____________________________________________________________________________

" A tagbar megnyitasakkor a kurzor ugorjon ra.
let g:tagbar_autofocus = 1

" Ha entert nyomunk egy tagon, akkor a tagra ugras utan zarodjon be a tagbar.
" let g:tagbar_autoclose = 1

" Ne rendezze nev szerint a tagokat.
let g:tagbar_sort = 0

" A jobbra nyil is nyissa ki a fold-okat, a bal csukja ossze oket.
let g:tagbar_map_openfold  = ['<Right>', 'l']
let g:tagbar_map_closefold = ['<Left>',  'h']

" Hogy asciidoc fajlokkal is hasznalhato legyen, mentsuk el ezeket a sorokat a
" ~/.ctags fajlba:
" --langdef=asciidoc
" --langmap=asciidoc:.ad.adoc.asciidoc
" --regex-asciidoc=/^=[ \t]+(.*)/\1/h/
" --regex-asciidoc=/^==[ \t]+(.*)/. \1/h/
" --regex-asciidoc=/^===[ \t]+(.*)/. . \1/h/
" --regex-asciidoc=/^====[ \t]+(.*)/. . . \1/h/
" --regex-asciidoc=/^=====[ \t]+(.*)/. . . . \1/h/
" --regex-asciidoc=/^======[ \t]+(.*)/. . . . \1/h/
" --regex-asciidoc=/^=======[ \t]+(.*)/. . . . \1/h/
" --regex-asciidoc=/\[\[([^]]+)\]\]/\1/a/
" --regex-asciidoc=/<<([^,]+),([^>]+)>>/\1: \2/A/
" --regex-asciidoc=/^\.([^\|]+)$/\1/t/
" --regex-asciidoc=/image::([^\[]+)/\1/i/
" --regex-asciidoc=/image:([^:][^\[]+)/\1/I/
" --regex-asciidoc=/include::([^\[]+)/\1/n/
let g:tagbar_type_asciidoc =
\ { 'ctagstype' : 'asciidoc',
\   'kinds'     : [ 'h:table of contents',
\                   'a:anchors:1',
\                   'A:using of anchors:1',
\                   't:titles:1',
\                   'n:includes:1',
\                   'i:images:1',
\                   'I:inline images:1'
\                 ]
\ }

" ~/.ctags:
" --langdef=text
" --langmap=text:.txt
" --regex-text=/^[ \t]*(.*)\{\{\{1/\1/h/
" --regex-text=/^[ \t]*(.*)\{\{\{2/. \1/h/
" --regex-text=/^[ \t]*(.*)\{\{\{3/. . \1/h/
let g:tagbar_type_text =
\ { 'ctagstype' : 'text',
\   'kinds'     : [ 'h:table of contents' ]
\ }

"                                 SYNTASTIC                               {{{2
" ____________________________________________________________________________

let g:syntastic_stl_format = '%W{!W%fw}%E{!E%fe}'

" Irja ki, hogy melyik checker-tol szarmazik a figyelmeztetes.
let g:syntastic_aggregate_errors = 1

" __ C ______________________________________

let g:syntastic_c_checkers = [ 'gcc', 'splint' ]

" __ PYTHON _________________________________

let g:syntastic_python_checkers = [ 'pylint', 'flake8' ]

" Stilushibak figyelmen kivul hagyasa.
let g:syntastic_python_pylint_args           = '-d line-too-long -d bad-indentation -d bad-whitespace'
let g:syntastic_python_flake8_quiet_messages = { 'type' : 'style' }

"                               NERDCOMMENTER                             {{{2
" ____________________________________________________________________________

" Rakjon szokozoket a kommenterek kore.
let NERDSpaceDelims = 1

" :help NERDBlockComIgnoreEmpty
let NERDBlockComIgnoreEmpty = 0

" Az alapertelmezett map-ok kikapcsolasa. (mivel keves kommentelo parancsot
" hasznalok es azokat sajat map-okra allitottam, igy teljesen feleslegesek)
let NERDCreateDefaultMappings = 0

"                               NEOCOMPLETE                               {{{2
" ____________________________________________________________________________

" Engedelyezes.
let g:neocomplete#enable_at_startup = 1

" Smartcase.
let g:neocomplete#enable_smart_case = 1

" Nem szeretnek fuzzy completion-t.
let g:neocomplete#enable_fuzzy_completion = 0

" Csak iras kozben jelenjen meg, mozgas kozben ne.
let g:neocomplete#enable_insert_char_pre = 1

" Automatikusan valassza ki az elso lehetoseget.
" let g:neocomplete#enable_auto_select = 1

" A kiegeszitesek mire legyenek ervenyesek, honnan vegye?
if !exists( 'g:neocomplete#sources' )
  let g:neocomplete#sources = {}
endif
let g:neocomplete#sources._ = ['omni', 'member', 'syntax', 'vim']

" Ruby-nal le van tilva az omnifunc, mert lassu, viszont igy engedelyezni
" tudjuk.
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"                                  BEXEC                                  {{{2
" ____________________________________________________________________________

" Fajltipus beallitasok.
let g:bexec_filter_types = {'asciidoc': 'asciidoctor'}

"                                QUICKRUN                                 {{{2
" ____________________________________________________________________________

" Alapertelmezesben nyissa meg a quickfix-et is, ha hiba tortent.
let g:quickrun_config = {
\ '_':
\   {
\     'outputter': 'multi',
\     'outputter/multi/targets': ['buffer', 'quickfix'],
\     'runner/vimproc/updatetime': 1000,
\     'outputter/buffer/running_mark': '... RUNNING ...'
\   },
\ 'asciidoc':
\   {
\     'type': 'asciidoctor',
\     'cmdopt': '-o -',
\     'outputter': 'browser'
\   }
\ }

"                                JEDI-VIM                                 {{{2
" ____________________________________________________________________________

" Ha ez nincs megadva, akkor ütközik a neocomplete-tal es automatikusan ki
" akarja valasztani az elso elemet ha pontot irunk egy objektum utan.
" let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0

" Bufferek hasznalata tab-ok helyett.
let g:jedi#use_tabs_not_buffers = 0

" Ne valassza ki az elso lehetoseget.
let g:jedi#popup_select_first = 0

"                                   CSCOPE                                {{{2
" ____________________________________________________________________________

if has( 'cscope' )
  " Az altalanos tag-parancsokhoz is hasznalja a cscope-ot. (pl. definiciora
  " ugras)
  " set cscopetag

  " Egy tag definiciojanak keresese eloszor a cscope adatbazisban tortenjen,
  " csak utanna nezze meg a tags fajlt. (1, ha forditva akarjuk)
  set cscopetagorder=0

  " :help cscopequickfix
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

"                                    GITV                                 {{{2
" ____________________________________________________________________________

" A commit uzeneteket roviditse le annyira, hogy minden info latszodjon.
let g:Gitv_TruncateCommitSubjects = 1

" Control key-eket ne map-oljon.
let g:Gitv_DoNotMapCtrlKey = 1

"                                    MAP                                  {{{1
" ============================================================================
"
" A specialis gombok kombinacioi (pl.: <S-Up>) TTY-ben nem mukodnek.
"
" HA TERMINALBAN NEM MUKODNENEK A KURZORBILLENTYUK:
"   :verbose imap <Esc>
" Ezen map-ok valamelyike okozza a hibat.

"                          MOZGAS AZ ABLAKON BELUL                        {{{2
" ____________________________________________________________________________

" A valodi sorok helyett a megjelenitett sorokban mozogjon a kurzor.
noremap                    j            gj
noremap                    k            gk

" Ugras a sor elejere/vegere.
noremap                    H            g^
noremap                    L            g$

"                          MOZGAS AZ ABLAKOK KOZOTT                       {{{2
" ____________________________________________________________________________

nnoremap                   <C-H>        <C-W>q
nnoremap                   <C-Y>        <C-W>w
nnoremap                   <C-E>        <C-W>W

"                                 VEGYES                                  {{{2
" ____________________________________________________________________________

" Sokkal jobban kezre esnek.
map                        <C-J>        <CR>
imap                       <C-J>        <CR>
noremap                    é            ;
noremap                    É            ,
inoremap                   <C-L>        <Del>
cnoremap                   <C-B>        <C-Left>
cnoremap                   <C-E>        <C-Right>

" Hogy a kiegesziteseknel se kelljen a nyilakhoz nyulni. (probald ki, hogy egy
" elozoleg beirt parancs elso betuje utan a <C-P>-t nyomogatod, majd ugyanigy
" a felfele nyillal keresed az elozmenyeket)
cnoremap                   <C-N>        <Up>
cnoremap                   <C-P>        <Down>

" Bufferek kozti mozgas.
nnoremap                   <C-K>        :b#<CR>
nnoremap                   &            :bnext<CR>
nnoremap                   #            :bprevious<CR>

" Mivel igazan semmi hasznat nem latom, igy letiltom az ex-modot elohozo
" gombot.
nnoremap                   Q            <Nop>

" Az InsertLeave esemeny nem tortenik meg a <C-C> hatasara.
noremap                    <C-C>        <Esc>

" Ha egy help dokumentumban nyomunk <Space>-t, akkor a kurzor alatti linket
" nyissa meg, ha forraskodban egy azonositon (fuggveny, vagy valtozo neven)
" nyomtuk meg, akkor a fuggveny definiciojahoz ugrik (tags, vagy cscope fajl
" szukseges hozza).
noremap                    <Space>      <C-]>

" Azon fuggvenyek listaja, amelyek meghivjak a kurzor alatti fuggvenyt.
" noremap                    ,            :scscope find c <C-R>=expand( '<cword>' )<CR><CR>

" A sztring osszes elofordulasanak helye. (valtozoknal lehet hasznos)
" noremap                    ;            :scscope find s <C-R>=expand( '<cword>' )<CR><CR>

" Completion.
inoremap           <expr>  <C-Space>    (&completefunc != '') ? "<C-X><C-U>" : "<C-X><C-O>"
" Terminal-ban a <Nul> a <C-Space> megfeleloje.
inoremap           <expr>  <Nul>        (&completefunc != '') ? "<C-X><C-U>" : "<C-X><C-O>"

" A torles ne masolja a vagolapra a szoveget.
noremap                    s            "_s
noremap                    S            "_S
noremap                    c            "_c
noremap                    C            "_C
noremap                    d            "_d
nnoremap                   dd           "_dd
noremap                    D            "_D
noremap                    <Del>        "_<Del>

" Az ablakkezelo vagolapjanak hasznalata - command-modban hatastalan, a
" kijelolt szoveget illeszti be, nem pedig azt, amire <C-Insert>-et nyomtunk.
noremap                    <C-Insert>   "+y
noremap                    <S-Insert>   "+P
imap                       <S-Insert>   <C-O><S-Insert>

" Kurzor alatti parancs sugojanak megnyitasa.
noremap  <silent>          K            :call eight#help#call( "<C-R>=escape( expand( '<cWORD>' ), '"\\' )<CR>" )<CR>
autocmd  FileType  man  call ManMap()
function ManMap()
  map    <buffer>          K            <C-]>
  map    <buffer>          <CR>         <C-]>
endfunction

" Lynx-szeru mozgas netrw-ben.
autocmd  FileType  netrw  call NetrwLynxMap()
function NetrwLynxMap()
  map    <buffer>          <Left>       -
  map    <buffer>          h            -
  map    <buffer>          <Right>      <CR>
  map    <buffer>          l            <CR>
endfunction

" Kereses a buffer konyvtaraban rekurzivan.
nnoremap                   <Leader>ur   :UniteWithBufferDir file_rec -sync<CR>

" ... nem rekurzivan.
nnoremap                   <Leader>uf   :UniteWithBufferDir file -sync<CR>

" ... a project fajlok kozott, vagy ha nincs .git, akkor csak a jelenlegi
" konyvtarban (pwd) rekurzivan.
nnoremap                   <Leader>upr  :UniteWithProjectDir file_rec -sync<CR>

" ... nem rekurzivan.
nnoremap                   <Leader>upf  :UniteWithProjectDir file -sync<CR>

" ... a bufferek kozott.
nnoremap                   <Leader>ub   :Unite -start-insert buffer -sync<CR>

" ... a konyjelzok kozott.
nnoremap                   <Leader>uB   :Unite -start-insert bookmark -sync<CR>

" ... a tag-ok kozott.
nnoremap                   <Leader>ut   :Unite -start-insert tag -sync<CR>

autocmd  FileType  unite  call UniteMaps()
function UniteMaps()
  if has( 'gui_running' )
    map    <buffer>        <Esc>        <Plug>(unite_all_exit)
    nmap   <buffer>        h            i<C-C>A../<C-C>
    nmap   <buffer>        l            <CR>
    nmap   <buffer>        x            astart<CR>
  endif
endfunction

" Easymotion.
map                        s            <Plug>(easymotion-s)

" Nerdcommenter.
map                        <C-F>        <Plug>NERDCommenterComment
map                        <C-G>        <Plug>NERDCommenterUncomment

" Tabular.
noremap                    <Leader>t\|  :Tabularize /\|/l0<CR>
noremap                    <Leader>t,   :Tabularize /,\zs/<CR>
noremap                    <Leader>t:   :Tabularize /:\zs/<CR>
noremap                    <Leader>t+   :Tabularize /+$/<CR>
noremap                    <Leader>tsp  :Tabularize / \+\zs/<CR>
noremap                    <Leader>ttab :Tabularize /\t\+\zs/<CR>
noremap                    <Leader>t=   :Tabularize /[+-\*\/\.]\?=/l1c1<CR>

" Menusor megjelenitese/elrejtese.
nnoremap  <silent> <expr>  <F1>         ':set guioptions' . (&guioptions =~ 'm' ? '-' : '+') . '=m<CR>'
imap                       <F1>         <C-O><F2>

" Terminal megnyitasa.
nnoremap  <silent> <expr>  <F2>         has( 'win32' ) ? ':silent !start conemu<CR>' : ':silent !xterm &<CR>'
imap                       <F2>         <C-O><F2>

" Gitv - git commit-ok amelyben a fajl valtozott.
nnoremap                   <F3>         :Gitv!<CR>
imap                       <F3>         <C-O><F3>

" Gitv - gitk-szeru log.
map                <expr>  <F4>         &filetype =~ 'gitv\?' ? 'q' : ':Gitv<CR>'
imap                       <F4>         <C-O><F4>

" Compile es make egy gombnyomasra.
noremap                    <F5>         :QuickRun -runner vimproc<CR>
imap                       <F5>         <C-O><F5>
nnoremap                   <F6>         :Comp<CR>
imap                       <F6>         <C-O><F6>

" Bongeszes a konyvtarban.
nnoremap  <silent>         <F7>         :VimFiler<CR>
imap                       <F7>         <C-O><F7>

" Ketpaneles commander megnyitasa.
nnoremap  <silent>         <S-F7>       :VimFilerDouble<CR>
imap                       <S-F7>       <C-O><S-F7>

" Tagbar megnyitasa.
nnoremap  <silent>         <F8>         :TagbarToggle<CR>
imap                       <F8>         <C-O><F8>

" A lathato ablakok szinkronizalasa diff nelkul.
nnoremap           <expr>  <F10>        ':set virtualedit=' . ( len( &virtualedit ) ? '' : 'all'). '<CR>'
imap                       <F10>        <C-O><F10>

" Kurzor oszlopanak kiemelesenek valtogatasa.
nnoremap  <silent>         <F11>        :let &colorcolumn = ((&cc == '') ? virtcol( '.' ) : '')<CR>
imap                       <F11>        <C-O><F11>

" Keresesi eredmenyek kiemelesenek torlese.
nnoremap  <silent>         <F12>        :nohlsearch<CR>
imap                       <F12>        <C-O><F12>

"                                 HEADER                                  {{{2
" ____________________________________________________________________________

" Eightheader - a sor foldheader-re alakitasa.
nnoremap                   <Leader>0    :silent call eight#contact#call()<CR><CR>
nnoremap                   <Leader>1    :silent call EightHeader( &tw, 'center', 0, '=', ' {' . '{{1', '' )<CR><CR>
nnoremap                   <Leader>2    :silent call EightHeader( &tw, 'center', 0, '_', ' {' . '{{2', '' )<CR><CR>
nnoremap                   <Leader>3    :silent call EightHeader( &tw, 'center', 0, '.', ' {' . '{{3', '' )<CR><CR>
nnoremap                   <Leader>9    :silent call EightHeader( 0 - (&tw / 2), 'left', 1, ['__', '_', ''], '', '\= " " . s:str . " "' )<CR><CR>

"                                     HELP                                {{{3
" ............................................................................

autocmd  FileType  help  nnoremap <buffer>  <Leader>1
\ :call EightHeader( 78, 'left', 1, ' ', '\= "*".matchstr( s:str, ";\\@<=.*" )."*"', '\= matchstr( s:str, ".*;\\@=" )' )<CR><CR>

autocmd  FileType  help  noremap <buffer>  <Leader>2
\ :call EightHeader( 78, 'left', 1, '.', '\= "\|".matchstr( s:str, ";\\@<=.*" )."\|"', '\= matchstr( s:str, ".*;\\@=" )' )<CR><CR>

"                              TEXTOBJ-USER                               {{{2
" ____________________________________________________________________________

autocmd  VimEnter  *  if isdirectory( $HOME . '/.vim/bundle/vim-textobj-user' ) | call TextObjMaps() | endif

function! TextObjMaps()
  call textobj#user#plugin( 'sharp', {
  \   'sharp-i': {
  \     'pattern': '#\zs[^#]*\ze#',
  \     'select':  ['i#']
  \   },
  \   'sharp-a': {
  \     'pattern': '#[^#]*#',
  \     'select':  ['a#']
  \   }
  \ })

  call textobj#user#plugin( 'colon', {
  \   'colon-i': {
  \     'pattern': ':\zs[^:]*\ze:',
  \     'select':  ['i:']
  \   },
  \   'colon-a': {
  \     'pattern': ':[^:]*:',
  \     'select':  ['a:']
  \   }
  \ })

  call textobj#user#plugin( 'asterisk', {
  \   'asterisk-i': {
  \     'pattern': '\*\zs[^\*]*\ze\*',
  \     'select':  ['i*']
  \   },
  \   'asterisk-a': {
  \     'pattern': '\*[^\*]*\*',
  \     'select':  ['a*']
  \   }
  \ })

  call textobj#user#plugin( 'bar', {
  \   'bar-i': {
  \     'pattern': '|\zs[^|]*\ze|',
  \     'select':  ['i\|']
  \   },
  \   'bar-a': {
  \     'pattern': '|[^|]*|',
  \     'select':  ['a\|']
  \   }
  \ })
endfunction

"                                AUTOCOMMAND                              {{{1
" ============================================================================
"
" FIGYELEM! Az azonos esemenyekre vonatkozo autocommand-ok az itt megadott
" sorrend szerint hajtodnak vegre - ez neha nem vart eredmenyt okozhat!

" __ FAJLOK BEALLITASAI _________________

" Az ujonnan letrehozott .txt fajloknal legyen <CR><NL> a sorvegzodes. Azert
" kell ilyen nyakatekerten megoldani, mert ha pl. krusader-bol, vagy tcmd-bol
" hozunk letre egy uj fajt, akkor a BufNewFile nem ervenyes ra, mivel a fajl
" mar letezik, mikor a Vim megnyitja azt.
autocmd  BufNewFile  *.txt  set fileformat=dos
autocmd  BufRead     *.txt  if ! getfsize( expand( '%' ) ) | set fileformat=dos | endif

" :help fo-table. Azert autocmd, mert minden fajltipus felulirja a
" formatoptions-t a sajat beallitasaival, igy ez elveszne, ha csak mezei set
" lenne.
autocmd  FileType  *    setlocal formatoptions+=con formatoptions-=l
if v:version >= 704
  autocmd  FileType  *  setlocal formatoptions+=j
endif

" Sorvegi whitespace-ek es a fajl vegi ures sorok torlese, majd a datum
" aktualizalasa.
autocmd  BufWritePre  *  call eight#writepre#call()

" __ COMPLETION _________________________

" Tags fajl ujrageneralasa, ha a fajl egy git repository-ban van.
" autocmd  BufWritePost  *  call Tags( 1 )
" autocmd  BufReadPost   *  call Tags( 0 )

" Fajltipus alapjan allitsa be az omni-completion-t.
if filereadable( $VIMRUNTIME . '/autoload/syntaxcomplete.vim' )
  autocmd  FileType  *  if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
endif

" __ MEGJELENES _________________________

" Ha atmeretezzuk a vim ablakat, akkor az ablakokat is meretezze ujra.
autocmd  VimResized  *  wincmd =

" Sorok szamozasanak es a specialis karakterek mutatasanak kikapcsolasa a man,
" quickfix es pydoc buffereknel.
autocmd  FileType  man,qf   setlocal nonumber nolist
autocmd  BufNew    __doc__  setlocal nonumber nolist

" Make hiba eseten nyissa meg a hibaablakot.
autocmd  QuickFixCmdPost  *  botright cwindow

" }}}1
