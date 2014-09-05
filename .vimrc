" ~/.vimrc
"
" TIPP: Ha nem ismered a folding hasznalatat, a zR kinyitja az osszes
" konyvjelzot.
"
" ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.15 17:53 ==

" Sok plugin es beallitas igenyli.
set nocompatible

" Gyorsitja a vim mukodeset.
if v:version >= 704
  set regexpengine=1
endif

" FIGYELEM: Paros jelek kiemelesenek tiltasa - nagyon belassulhat tole az
" egesz vim. A lehetoseget meghagyom a bekapcsolasra, de alapbol ki van
" kapcsolva. (:DoMatchParen kapcsolja be)
" autocmd VimEnter * if exists( ':NoMatchParen' ) | execute 'NoMatchParen' | endif
" Ezek sem segitenek:
" let g:matchparen_timeout = 5
" let g:matchparen_insert_timeout = 5

" "Nagyfelbontasu" terminal (pl. xterm), vagy gui eseten igaz az ertekkel ter
" vissza.

function HighTerm()
  return (&term !~ 'ansi\|linux\|win32') || (&columns >= (&textwidth + &numberwidth))
endfunction

"                    VUNDLE CSOMAGKEZELO PLUGIN INDITASA                  {{{1
" ============================================================================

set runtimepath+=$HOME/.vim/bundle/vundle/
runtime autoload/vundle.vim

if exists( '*vundle#rc' )
  filetype off
  call vundle#rc()

  " plugin-ok automatizalt telepitese git-en keresztul (is)
  Plugin 'gmarik/vundle'

  " __ GITHUB _____________________________

  " .. SAJAT ..............................

  " sajat fuggvenyek, parancsok, filetype, tippek, stb.
  Plugin 'bimbalaszlo/vim-eight'

  " (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...
  Plugin 'bimbalaszlo/vim-eightheader'

  " szamok manipulalasa regex segitsegevel
  Plugin 'bimbalaszlo/vim-numutils'

  " rovid leirasok programokhoz es programozasi nyelvekhez help formaban
  Plugin 'bimbalaszlo/vim-cheatsheets'

  " .. MEGJELENES .........................

  " nagyon szep colorscheme (light es dark is)
  Plugin 'altercation/vim-colors-solarized'

  " divatos, de minimalista statusline
  Plugin 'itchyny/lightline.vim'

  " .. ALAPVETO ...........................

  " info a kurzor poziciojaraol (fold, fuggveny, osztaly)
  Plugin 'locator'

  " tuningolt vimgrep
  Plugin 'easygrep'

  " parancsok futtatasa visual block-on
  Plugin 'vis'

  " kijelolt szoveg keresese * gombbal
  Plugin 'thinca/vim-visualstar'

  " szoveg igazitasa regex kifejezesekkel
  Plugin 'godlygeek/tabular'

  " .. PROGRAMOZAS ........................

  " szovegreszek kommentelese (akar oszlopok is)
  Plugin 'scrooloose/nerdcommenter'

  " a fajlban talalhato tag-ek listaja
  Plugin 'majutsushi/tagbar'

  " python irasat nagyban megkonnyito kiegeszitesek / sugok
  Plugin 'davidhalter/jedi-vim'

  " syntax checker
  Plugin 'scrooloose/syntastic'

  " .. GIT ................................

  " git integracio
  Plugin 'tpope/vim-fugitive'

  " gitk a vim-en belul
  Plugin 'gregsexton/gitv'

  " __ NEM GITHUB _________________________

  " Plugin 'https://www.bitbucket.org/user/repo'

  " __ HELYI ______________________________

  " Plugin 'file://~/.vim/bundle/repo'
endif

"                               INSTALLVUNDLE                             {{{2
" ____________________________________________________________________________
"
" Cloning vundle to ~/.vim/bundle/vundle

command  InstallVundle  call InstallVundle()
function InstallVundle()
  let vundle_repo = 'https://github.com/gmarik/vundle.git'
  let path = substitute( $HOME . '/.vim/bundle/vundle', '/', has( 'win32' ) ? '\\' : '/', 'g' )

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

  echo 'Cloning vundle...'
  let msg = system( 'git clone "' . vundle_repo . '" "' . path . '"'  )
  if msg =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . vundle_repo . ' to ' . path . ':' | echomsg msg | echohl None
    return
  endif

  echo 'Vundle installed. Please restart vim and run :PluginInstall'
  return
endfunction

"                              ALAPVETO MUKODES                           {{{1
" ============================================================================

" Fajltipus felismeres bekapcsolasa, a ra jellemzo formazas (pl. kommentkari)
" es behuzas stilusanak betoltese.
if exists( ':filetype' )
  filetype plugin indent on
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

  " Globalis fuggvenykonyvtarak helye. A '\' karikat atalakitjuk '/' karakterre
  " a :help 'path' szerint.
  let mingw_path = substitute( system( 'set PATH' ), '.*[; =]\([^;]\+mingw\).*', '\1', '' )
  let &path      = '.,,' . tr( mingw_path . '/include', '\', '/' )

  " :make ezt a programot hasznalja:
  set makeprg=mingw32-make

  " Ha egy tomoritett fajlt nyitunk meg, hianyolja ezt a valtozot ezert
  " hibauzenetet ir ki.
  let netrw_cygwin = 0

endif

"                                   SZINEK                                {{{1
" ============================================================================

" Szinsema beallitasa.
if has( 'gui_running' ) && len( globpath( &runtimepath, 'colors/solarized.vim' ) )

  set background=light
  colorscheme solarized

  " A par nelkuli zarojelek kijelzese alig lathato.
  highlight! link Error ErrorMsg

  " A soremeles karakterek is egybeolvadnak a szoveggel. Ez a highlight a high
  " visibility beallitasokol van atmasolva.
  highlight! NonText term=bold ctermfg=9 gui=bold guifg=#dc322f

  " A tab, whitespace, stb. szinei is ilyenek legyenek.
  highlight! link SpecialKey NonText

  " A statusline szinet is beallitjuk.
  if !exists( 'g:lightline' )
    let g:lightline = {}
  endif
  let g:lightline.colorscheme = 'solarized'

elseif len( globpath( &runtimepath, 'colors/desert.vim' ) )

  set background=dark
  colorscheme desert

  " Popupmenu szinei nem tetszenek a desert-ben.
  highlight Pmenu      ctermbg=Black ctermfg=Gray  guibg=#FFFFCC guifg=DarkGray
  highlight PmenuSel   ctermbg=Black ctermfg=White guibg=#FFFFCC guifg=Black    gui=bold
  highlight PmenuSbar  ctermbg=Black ctermfg=Black guibg=#FFFFCC guifg=#FFFFCC
  highlight PmenuThumb ctermbg=White ctermfg=White guibg=Black   guifg=Black

endif

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
let stat_filedir    = '%<%{b:stat_curfiledir}'
let stat_filename   = '%w%t%r%m'
let stat_fileformat = '%{&binary ? "binary" : ((strlen( &fenc ) ? &fenc : &enc) . (&bomb ? "-bom" : "") . " ") . &ff}'
let stat_lineinfo   = '%3v|%4l:%3p%%'

let &statusline  = stat_filename . ' | '
let &statusline .= stat_fileformat . ' | '
let &statusline .= '%{exists( "b:mixed" ) && len( b:mixed ) ? b:mixed . " | " : ""}'
let &statusline .= '%{len( StatFugitive() ) ? StatFugitive() . " | " : ""}'
let &statusline .= stat_filedir . ' | '
let &statusline .= '%= '
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
\     'left'          : [ ['filename'], ['fileformat'], ['mixed'], ['fugitive'], ['filedir'] ],
\     'right'         : [ ['lineinfo'], ['syntastic'] ]
\   }

let g:lightline.inactive = {
\     'left'          : [ ['fullfilename'], ['fugitive'] ],
\     'right'         : [ [] ]
\   }

let g:lightline.component = {
\     'filename'      : stat_filename,
\     'fullfilename'  : '%F',
\     'filedir'       : stat_filedir,
\     'fileformat'    : stat_fileformat,
\     'mixed'         : '%{exists( "b:mixed" ) && len( b:mixed ) ? b:mixed : ""}',
\     'lineinfo'      : stat_lineinfo
\   }

let g:lightline.component_function = {
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

" __ FINDMIXED __________________________
"
" Mixed end-of-line es -indent, valamint a textwidth-nel hosszabb sorok
" keresese.

autocmd BufReadPost,BufWritePost * call FindMixed()

function FindMixed()
  " FIXME: a 0. sortol kezdje a keresest.

  let mixed = { 'eol' : 0, 'indent' : 0, 'long_line' : 0 }

  " Binary modban ne csinaljon semmit.
  if &binary
    let b:mixed = ''
  endif

  " __ MIXED EOL __________________________

  let mixed['eol'] = search( '\r', 'wnc' )

  " Ha a fileformat 'dos'-ra van allitva, akkor az a sor szamit hibasnak,
  " amelyik nem '\r' karival vegzodik. (a normalis sorok vegen ilyenkor
  " latszodnia kell a '\r' karinak)
  if (&fileformat == 'dos') && mixed['eol']
    let eol = search( '[^\r]$\|^$', 'wnc' )

    " Ha megis csak '\r'-el vegzodik minden sor, akkor azokat jelezzuk
    " hibasnak.
    if eol
      let mixed['eol'] = eol
    endif
  endif

  " __ MIXED INDENT _______________________

  let tab   = search( '^ *\t', 'wnc' )
  let space = search( '^\t* ', 'wnc' )

  if tab && space
    let mixed['indent'] = (tab > space) ? tab : space
  else
    let mixed['indent'] = 0
  endif

  " __ LONG LINE ______________________________
  "
  " FIXME: tabulator csak 1 karinak szamit.

  if &filetype == 'text'
    let mixed['long_line'] = search( '^.\{' . (&textwidth + 1) . ',}', 'wnc' )
  endif

  let b:mixed  = mixed['indent']    ? '^' . mixed['indent']    : ''
  let b:mixed .= mixed['eol']       ? '$' . mixed['eol']       : ''
  let b:mixed .= mixed['long_line'] ? '<' . mixed['long_line'] : ''
endfunction

"                                 ALTALANOS                               {{{1
" ============================================================================

" Current working directory kiirasa a cimsorban.
set titlestring=CWD:\ %{getcwd()}

" Szoveg szelessege - ugyan a fajlok beallitasahoz kene tenni, de szamitasok
" miatt itt mar be kell allitani.
set textwidth=78

" Sorok szamozasara szant oszlop szelessege.
set numberwidth=6

" Sorok szamozasa, kiveve ha TTY, vagy Win-es parancssor alatt hasznaljuk es
" a szovegterulet nem elegendoen szeles.
if HighTerm()
  set number
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
set showtabline=1

" A tabok listazasanak modja.
set tabline=%!eight#shorttabline#call()

" Az ablakok kozti elvalaszto ne tartalmazzon karaktereket, csak a szinezes jelolje a hatarokat.
let &fillchars = 'vert: ,stl: ,stlnc: '

" Kurzor koruli 'ter' gorgetesnel.
set scrolloff=3

" Mindig legyen eger.
set mouse=a

" Makrok futtatasanal ne frissitse a kepernyot, csak ha vegzett.
set lazyredraw

" Ne adjon ki hangot - a .gvimrc-nek is tartalmaznia kell.
set vb t_vb=
set visualbell

" Tordelje el a hosszu sorokat. (softbreak)
set wrap

" Sorok osszefuzesenel ket szokoz helyett csak egyet tegyen.
set nojoinspaces

" Bufferek kozti valtasnal ne mentse automatikusan azok tartalmat.
set hidden

" Mindig az aktualis fajl konyvtara legyen a cwd.
" Tapasztalatbol mondhatom, hogy nem minden plugin szereti (pl. netrw,
" fugitive), de ettol fuggetlenul en szeretem, de sajnos tul sok baj van vele.
" set autochdir

" Terminalban ne varakozzon az <Esc>
set ttimeout
set ttimeoutlen=0
set notimeout

" Mindig az ablakkezelo vagolapjat hasznalja.
" set clipboard=unnamed

" Uj ablakok alulra / jobbra keruljenek. (a help is)
set splitbelow
set splitright

" Ablakok nyitasanal / bezarasanal mindig ugyanakkorara meretezze ujra oket.
set equalalways

" A help ablak se foglaljon nagyobb helyet.
set helpheight=0

" A Vim alapertelmezett karakterkodolasa. (nem a fajloke)
set encoding=utf8

" Changlelog beallitasok. (uj bejegyzes hozzaadasa a mai naphoz: \o)
let changelog_username   = 'BimbaLaszlo  <bimbalaszlo@gmail.com>'
let changelog_dateformat = '%Y.%m.%d'

" TOhtml beallitasok.
let html_number_lines = 0
let html_use_css      = 0

" SQL beallitasok.
let g:ftplugin_sql_omni_key = '<C-X>'

"                             FAJLOK BEALLITASAI                          {{{1
" ============================================================================

" Fajlok elore megadott beallitasait hasznalhatja. (fajl elejen, vagy vegen
" talalhato vim-specifikus beallitasok)
set modeline

" Ne csinaljon biztonsagi masolatokat a fajl mentese elott.
set nobackup
set nowritebackup

" Lehetseges sorvegzodesek. Uj fajl letrehozasanal az elso parametert
" hasznalja.
set fileformats=unix,dos

" Lehetseges karakterkodolasok. Uj fajl letrehozasanal az elso parametert
" hasznalja.
set fileencodings=utf8,cp1250,default

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
set ignorecase
set smartcase

" Kereses talalatainak kiemelese.
set hlsearch

" Kereses begepelese kozben mar emelje ki a talalatokat.
set incsearch

"                             SZINTAXIS KIEMELES                          {{{1
" ============================================================================

" Shell-scrip-eknel ne jelezze hibanak: $()
let is_posix = 1

" Specialis karakterek (tabulator, sor vegi whitespace) mutatasa.
set list
set listchars=tab:>-,trail:.,extends:→,precedes:←

" Sortores mutatasa.
let &showbreak = '↑ '

" Helyesiras ellenorzes magyarra allitasa.
set spelllang=hu

"                                  BEHUZAS                                {{{1
" ============================================================================

" Automatikus behuzas { utan is.
set autoindent
set smartindent

" A behuzas merteke szokozokben megadva.
set shiftwidth=2

" A > es < karakterekkel toreno behuzasnal a shiftwidth tobbszorosere mozgassa
" a szoveget.
set shiftround

" 1 tabulator a shiftwidth-nek megfelelo szokozt fog beirni - regi verzio.
let &softtabstop = &sw

" Tab helyett szokozok hasznalata.
set expandtab

" A backspace ezeket torolje: indent, end of line, start
set backspace=2

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
set completeopt=menuone,longest,preview

" Fuggvenyek parametereit is mutatja kiegeszitesnel.
set showfulltag

"                                  PLUGINOK                               {{{1
" ============================================================================

"                               EIGHTHEADER                               {{{2
" ____________________________________________________________________________

let g:EightHeader_comment   = 'call NERDComment( "n", "comment" )'
let g:EightHeader_uncomment = 'call NERDComment( "n", "uncomment" )'

"                               EASYMOTION                                {{{2
" ____________________________________________________________________________

" Enter leutesere az elso talalatra ugrik.
let g:EasyMotion_enter_jump_first = 1

" Kis/nagybetu erzekenyseg, ha nagybetu van a beirt szovegben.
let g:EasyMotion_smartcase = 1

"                                EASYGREP                                 {{{2
" ____________________________________________________________________________

" Alapjaba veve a megnyitott fajl tipusaval megegyezo fajlokban keressen.
let EasyGrepMode = 2

" Rekurzivan keressen a konyvtarakban.
let EasyGrepRecursive = 1

" Rejtett fajlokban is keressen.
let EasyGrepHidden = 1

" Soronkent tobb egyezest is talalhat. (mint pl.: :s///g)
let EasyGrepEveryMatch = 1

"                                   NETRW                                 {{{2
" ____________________________________________________________________________

" Netrw ablakanak abszolut merete:
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
let g:tagbar_map_openfold  = ['<Right>', '+']
let g:tagbar_map_closefold = ['<Left>',  '-']

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

"                               NERDCOMMENTER                             {{{2
" ____________________________________________________________________________

" Rakjon szokozoket a kommenterek kore.
let NERDSpaceDelims = 1

" :help NERDBlockComIgnoreEmpty
let NERDBlockComIgnoreEmpty = 0

" Az alapertelmezett map-ok kikapcsolasa. (mivel keves kommentelo parancsot
" hasznalok es azokat sajat map-okra allitottam, igy teljesen feleslegesek)
let NERDCreateDefaultMappings = 0

"                                 SYNTASTIC                               {{{2
" ____________________________________________________________________________

let g:syntastic_stl_format = '%W{!W%fw}%E{!E%fe}'

" Irja ki, hogy melyik checker-tol szarmazik a figyelmeztetes.
let g:syntastic_aggregate_errors = 1

" __ C ______________________________________

let g:syntastic_c_checkers = [ 'gcc', 'splint' ]

" __ PYTHON _________________________________

let g:syntastic_python_checkers = [ 'pylint', 'flake8' ]

" Pylint-nel nem erdekelnek a stilushibak.
let g:syntastic_python_pylint_args = '-d line-too-long -d bad-indentation -d bad-whitespace'

" Stilushibak figyelmen kivul hagyasa.
let g:syntastic_python_flake8_quiet_messages = { 'type' : 'style' }

"                                JEDI-VIM                                 {{{2
" ____________________________________________________________________________

" Bufferek hasznalata tab-ok helyett.
let g:jedi#use_tabs_not_buffers = 0

"                              OMNICPPCOMPLETE                            {{{2
" ____________________________________________________________________________

" Fuggveny prototipusanak mutatasa.
let OmniCpp_ShowPrototypeInAbbr = 1

" Ne egeszitse ki automatikusan a tagot a '.', '->' es '::' utan, csak ha
" <C-X><C-O>-t nyomunk.
" let OmniCpp_MayCompleteDot   = 0
" let OmniCpp_MayCompleteArrow = 0
" let OmniCpp_MayCompleteScope = 0

"                                   CSCOPE                                {{{2
" ____________________________________________________________________________

if has( 'cscope' )
  " Az altalanos tag-parancsokhoz is hasznalja a cscope-ot. (pl. definiciora
  " ugras)
  " set cscopetag

  " Egy tag definiciojanak keresese eloszor a cscope adatbazisban tortenjen,
  " csak utanna nezze meg a tags fajlt. (1, ha forditva akarjuk)
  set cscopetagorder=0

  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

"                                    GITV                                 {{{2
" ____________________________________________________________________________

" A commit uzeneteket roviditse le annyira, hogy minden info latszodjon.
let g:Gitv_TruncateCommitSubjects = 1

" Control key-eket ne map-oljon.
let g:Gitv_DoNotMapCtrlKey = 1

"                                    GVIM                                 {{{1
" ============================================================================

if has( 'gui_running' )
  if has( 'win32' )

    " set guifont=DejaVu_Sans_Mono:h11
    set guifont=Consolas:h11

    " Ablak teljes meretuve tetele.
    autocmd  GUIEnter  *  simalt ~xm

  else

    let &guifont = 'Liberation Mono 11'

  endif

  " Ablak mereteinek megadasa.
  set lines=50
  let &columns = &foldcolumn + (&number ? &numberwidth : 0) + &textwidth

  " Ne villogjon a 'visualbell'.
  autocmd  GUIEnter  *  set vb t_vb=

  " Linux-on belassul tole... (-_-')
  " set cursorcolumn
  " set cursorline

  " Toolbar kikapcsolasa.
  set guioptions-=T

  " Menusor kikapcsolasa.
  set guioptions-=m

  " A scroll-ok csak akkor latszodjanak, ha szukseg van rajuk?
  set guioptions-=L
  set guioptions-=R
  " Mindig latszodjanak?
  set guioptions-=l
  set guioptions-=r
  set guioptions+=b

  " A tabok neve ele irja ki a tab szamat.
  let &guitablabel = " %N \| %t %m "
endif

"                                    MAP                                  {{{1
" ============================================================================
"
" A specialis gombok kombinacioi (pl.: <S-Up>) TTY-ben nem mukodnek.
"
" HA TERMINALBAN NEM MUKODNENEK A KURZORBILLENTYUK:
"   :verbose imap <Esc>
" Ezen map-ok valamelyike okozza a hibat.

"                            TERMINAL KEYCODES                            {{{2
" ____________________________________________________________________________

if &term =~ 'xterm'
  map [3;5~   <C-Del>
endif

"                             ABLAK ATMERETEZESE                          {{{2
" ____________________________________________________________________________

" Windows-on is lehessen iranygombokkal atmeretezni az ablakot, ne csak
" Linux-on (az ablakkezelonek koszonhetoen).

if has( 'win32' )
  " Ablak teljes meretuve tetelenek valtogatasa: a '~x' megnyitja az ablak
  " menujet (amit az ikonjara kattintva erhetsz el), majd az 'm'
  " maximalizalja, az 'e' pedig elozo meretuve teszi. (allapotfuggo, hogy
  " mikor melyik lep ervenybe) Ezek magyar Win-nel mukodnek, mas nyelveknel
  " mas lehet a gyorsgombok neve.

  let maximized = 1

  nnoremap         <expr>  <M-Up>       ':simalt ~x' . (maximized ? 'e' : 'm') . ' \| let maximized = !maximized<CR>'
  imap                     <M-Up>       <C-O><M-Up>
endif

"                          MOZGAS AZ ABLAKON BELUL                        {{{2
" ____________________________________________________________________________

" A softbreak-kel tordelt sorokban is lepegethetunk.
noremap                    <Up>         g<Up>
imap               <expr>  <Up>         pumvisible() ? "<Up>"   : "<C-O><Up>"
noremap                    <Down>       g<Down>
imap               <expr>  <Down>       pumvisible() ? "<Down>" : "<C-O><Down>"

" Az <C-Left/Right> insert modban a legkozelebbi word helyett WORD-re ugorjon.
inoremap                   <C-Left>     <C-O><C-Left>
inoremap                   <C-Right>    <C-O><C-Right>

" PageUp/Down, ami a legelso/utolso sorra is elvisz.
noremap                    <S-Up>       <C-U>
imap               <expr>  <S-Up>       pumvisible() ? "<PageUp>"   : "<C-O><S-Up>"
noremap                    <S-Down>     <C-D>
imap               <expr>  <S-Down>     pumvisible() ? "<PageDown>" : "<C-O><S-Down>"

" SmartHome/End.
noremap            <expr>  <S-Left>     virtcol( '.' ) == match( getline( '.' ), '\S' ) + 1 ? 'g0' : 'g^'
imap                       <S-Left>     <C-O><S-Left>
noremap            <expr>  <S-Right>    virtcol( '.' ) == virtcol( '$' ) - 1 ? 'g_' : 'g$'
imap                       <S-Right>    <C-O><S-Right>
cmap                       <S-Left>     <Home>
cmap                       <S-Right>    <End>

"                          MOZGAS AZ ABLAKOK KOZOTT                       {{{2
" ____________________________________________________________________________

noremap                    <C-Up>       <C-W><Up>
imap                       <C-Up>       <C-O><C-Up>
noremap                    <C-Down>     <C-W><Down>
imap                       <C-Down>     <C-O><C-Down>
nnoremap                   <Tab>        <C-W>w
nnoremap                   <S-Tab>      <C-W>W
noremap                    <C-Del>      <C-W>q
imap                       <C-Del>      <C-O><C-Del>

"                          MOZGAS A BUFFEREK KOZOTT                       {{{2
" ____________________________________________________________________________

noremap   <silent>         <C-S-Right>  :bn<CR>
imap                       <C-S-Right>  <C-O><C-S-Right>
noremap   <silent>         <C-S-Left>   :bp<CR>
imap                       <C-S-Left>   <C-O><C-S-Left>

" Az alternativ buferre ugras.
nnoremap                   <C-S-Down>   <C-^>
nnoremap                   B            <C-^>

"                                 VEGYES                                  {{{2
" ____________________________________________________________________________

" Numpad atiranyitasa az eredeti karakterekre.
map                        <kPlus>      +
map                        <kMinus>     -
map                        <kDivide>    /

" Mivel igazan semmi hasznat nem latom, igy letiltom az ex-modot elohozo
" gombot.
nnoremap                   Q            <Nop>

" Az InsertLeave esemeny nem tortenik meg a <C-C> hatasara.
noremap                    <C-C>        <Esc>

" Gyorsabb hozzaferes a <C-O>-hoz.
inoremap                   <C-k0>       <C-O>
inoremap                   <C-CR>       <C-O>

" Insert modba lepes bal kezhez kozel.
nnoremap                   a            i
noremap                    A            I
nnoremap                   y            a
noremap                    Y            A

" Ha egy help dokumentumban nyomunk <Space>-t, akkor a kurzor alatti linket
" nyissa meg, ha forraskodban egy azonositon (fuggveny, vagy valtozo neven)
" nyomtuk meg, akkor a fuggveny definiciojahoz ugrik (tags, vagy cscope fajl
" szukseges hozza).
noremap                    <Space>      <C-]>

" A backspace normal modban visszaugrik az elozo 'oldalra'. (:help CTRL-T)
nnoremap                   <BS>         <C-T>

" Azon fuggvenyek listaja, amelyek meghivjak a kurzor alatti fuggvenyt.
" noremap                    ,            :scscope find c <C-R>=expand( '<cword>' )<CR><CR>

" A sztring osszes elofordulasanak helye. (valtozoknal lehet hasznos)
" noremap                    ;            :scscope find s <C-R>=expand( '<cword>' )<CR><CR>

" A , es ; felcserelese.
noremap                    ;            ,
noremap                    ,            ;

" Fold-ok kinyitasa / becsukasa.
nnoremap                   +            zo
nnoremap                   -            zc
nnoremap                   z+           zR
nnoremap                   z-           zM
map                        <S-kPlus>    z+
map                        <S-kMinus>   z-

" Gyorsabb omni completion.
inoremap                   <C-Space>    <C-X><C-O>
" Terminal-ban a <Nul> a <C-Space> megfeleloje.
inoremap                   <Nul>        <C-X><C-O>

" Minden modositas visszavonasa az utolso mentesig.
nnoremap                   U            :earlier 1f<CR>

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
if has( 'win32' )
  noremap                  <C-Insert>   "+y
  noremap                  <S-Insert>   "+P
  imap                     <S-Insert>   <C-O><S-Insert>
endif

" Kurzor alatti parancs sugojanak megnyitasa.
noremap  <silent>          K            :call eight#help#call( "<C-R>=escape( expand( '<cWORD>' ), '"\\' )<CR>" )<CR>
noremap  <silent>          L            :Szotar <C-R>=expand( '<cword>' )<CR><CR>

" Lynx-szeru mozgas netrw-ben.
autocmd  FileType  netrw  call NetrwLynxMap()
function NetrwLynxMap()
   map   <buffer>          <Left>       -
   map   <buffer>          <Right>      <CR>
endfunction

" Easymotion.
map                        s            <Plug>(easymotion-s)

" Nerdcommenter.
map                        <C-D>        <Plug>NERDCommenterComment
map                        <C-F>        <Plug>NERDCommenterUncomment

" Tabular.
noremap                    <leader>t\|  :Tabularize /\|/l0<CR>
noremap                    <leader>t,   :Tabularize /,\zs/<CR>
noremap                    <leader>t:   :Tabularize /:\zs/<CR>
noremap                    <leader>tsp  :Tabularize / \+\zs/<CR>
noremap                    <leader>t=   :Tabularize /[+-\*\/\.]\?=/l1c1<CR>

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
nnoremap           <expr>  <F4>         &filetype =~ 'gitv' ? ':normal q<CR>' : ':Gitv<CR>'
imap                       <F4>         <C-O><F4>

" Comp es Make egy gombnyomasra.
nnoremap                   <F5>         :Comp<CR>
imap                       <F5>         <C-O><F5>
nnoremap                   <F6>         :make<CR>
imap                       <F6>         <C-O><F6>

" Bongeszes a konyvtarban netrw-vel (v150 verzio kell hozza).
" nnoremap  <silent>         <F7>         :call ToggleBrowser()<CR>
nnoremap  <silent>         <F7>         :Lexplore<CR>
imap                       <F7>         <C-O><F7>

" Tagbar megnyitasa.
nnoremap  <silent>         <F8>         :TagbarToggle<CR>
imap                       <F8>         <C-O><F8>

" A lathato ablakok szinkronizalasa diff nelkul.
nnoremap                   <F10>        :call eight#syncwin#call()<CR>
imap                       <F10>        <C-O><F10>

" Kurzor oszlopanak kiemelesenek valtogatasa.
nnoremap  <silent>         <F11>        :let &colorcolumn = ((&cc == '') ? virtcol( '.' ) : '')<CR>
imap                       <F11>        <C-O><F11>

" Keresesi eredmenyek kiemelesenek torlese.
nnoremap  <silent>         <F12>        :nohlsearch<CR>
imap                       <F12>        <C-O><F12>

"                              HEADER MAP-OK                              {{{2
" ____________________________________________________________________________

" Eightheader - a sor foldheader-re alakitasa.
nnoremap                   <leader>0    :silent call eight#contact#call()<CR><CR>
nnoremap                   <leader>1    :silent call EightHeader( &tw, 'center', 0, '=', ' {' . '{{1', '' )<CR><CR>
nnoremap                   <leader>2    :silent call EightHeader( &tw, 'center', 0, '_', ' {' . '{{2', '' )<CR><CR>
nnoremap                   <leader>3    :silent call EightHeader( &tw, 'center', 0, '.', '', '' )<CR><CR>
nnoremap                   <leader>9    :silent call EightHeader( 0 - (&tw / 2), 'left', 1, ['__', '_', ''], '', '\= " " . s:str . " "' )<CR><CR>

"                                     HELP
" ............................................................................

autocmd  FileType  help  nnoremap <buffer>  <leader>1
\ :call EightHeader( 78, 'left', 1, ' ', '\= "*".matchstr( s:str, ";\\@<=.*" )."*"', '\= matchstr( s:str, ".*;\\@=" )' )<CR><CR>

autocmd  FileType  help  noremap <buffer>  <leader>2
\ :call EightHeader( 78, 'left', 1, '.', '\= "\|".matchstr( s:str, ";\\@<=.*" )."\|"', '\= matchstr( s:str, ".*;\\@=" )' )<CR><CR>

"                                AUTOCOMMAND                              {{{1
" ============================================================================
"
" FIGYELEM! Az azonos esemenyekre vonatkozo autocommand-ok az itt megadott
" sorrend szerint hajtodnak vegre - ez neha nem vart eredmenyt okozhat!

" __ FAJLOK BEALLITASAI _________________

" Az ujonnan letrehozott .txt fajloknal legyen <CR><NL> a sorvegzodes. Azert
" kell ilyen nyakatekerten megoldani, mert ha pl. Krusader-bol, vagy Tcmd-bol
" hozunk letre egy uj fajt, akkor a BufNewFile nem ervenyes ra, mivel a fajl
" mar letezik, mikor a Vim megnyitja azt.
autocmd  BufNewFile  *.txt  set fileformat=dos
autocmd  BufRead     *.txt  if ! getfsize( expand( '%' ) ) | set fileformat=dos | endif

" :help fo-table. Azert autocmd, mert minden fajltipus felulirja a
" formatoptions-t a sajat beallitasaival, igy ez elveszne, ha csak mezei set
" lenne.
autocmd  FileType  *                         setlocal formatoptions+=co formatoptions-=l
if v:version >= 704
  autocmd  FileType  *                       setlocal formatoptions+=j
endif

" Sorvegi whitespace-ek es a fajl vegi ures sorok torlese, majd a datum
" aktualizalasa.
autocmd  BufWritePre  *  call eight#writepre#call()

" __ COMPLETION _________________________

" Fajltipus alapjan allitsa be a user-completion-t (<C-X><C-U>), hogy ha az
" omnifunc nem is mukodik, azert legyen valami kiegeszites.
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

" __ EGYEB __________________________________

" Ftp-n a fugitive meghulyul, ha az autochdir be van kapcsolva.
" A netrw viszont nem foglalkozik vele, pl. mindig a megnyitott url-hez
" viszonyitva kell megadni az uj fajlok nevet.
" autocmd  BufEnter  *://*  set noautochdir
