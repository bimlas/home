" Fajltipus felismeres bekapcsolasa, a ra jellemzo formazas (pl. kommentkari)
" es behuzas stilusanak betoltese.
if exists(':filetype')
  filetype plugin indent on
endif

" Szintaxiskiemeles.
if has('syntax')
  syntax enable
endif

" Kurzor koruli 'ter' gorgetesnel.
set scrolloff=3

" A sor utolso karaktere utan egyel is allhat a kurzor.
" NAGYON HASZNOS TUD LENNI!
set virtualedit=onemore

" Tordelje el a hosszu sorokat. (softbreak)
set wrap

" ... csak a megadott karakterek utan (a szavakat ne torje el).
set linebreak
let &breakat = " \t;:,/])}"

" A wrap-al tort sorokat huzza be ugy, hogy az elozo sor behuzasat kovesse.
set breakindent

" Sortores mutatasa.
if has('gui_running')
  let &showbreak = '↳'
else
  let &showbreak = '^'
endif

" Szoveg szelessege - ugyan a fajlok beallitasahoz kene tenni, de szamitasok
" miatt itt mar be kell allitani.
set textwidth=78

" Automatikus behuzas { utan is.
set autoindent smartindent

" Tab helyett szokozok hasznalata.
set expandtab

" A behuzas merteke szokozokben megadva - a > es < karakterekkel toreno
" behuzasnal a shiftwidth tobbszorosere mozgassa a szoveget.
set shiftwidth=2 shiftround

" 1 tabulator a shiftwidth-nek megfelelo szokozt fog beirni.
let &softtabstop = &sw

" A backspace ezeket torolje: indent, end of line, start
set backspace=2

" Specialis karakterek (tabulator, sor vegi whitespace) mutatasa.
if has('gui_running')
  set list listchars=tab:▶‒,nbsp:∙,trail:∙,extends:▶,precedes:◀
else
  set list listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<
endif

" Sorok osszefuzesenel ket szokoz helyett csak egyet tegyen.
set nojoinspaces

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

" Behuzas szerint kulonuljenek el a blokkok.
set foldmethod=marker

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

if has('nvim')
  set inccommand=nosplit
endif

" Helyesiras ellenorzes magyarra es angolra allitasa.
set spelllang=hu,en

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

" Set up omni-completion if not already set.
autocmd vimrc FileType * if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
