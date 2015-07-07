" ~/.vimrc
"
" TIPP: Ha nem ismered a folding hasznalatat, a zR kinyitja az osszes
" konyvjelzot.
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.07.07 12:54 ==

" Sok plugin es beallitas igenyli.
set nocompatible

" Windows-on nincs a runtimepathban.
set runtimepath+=$HOME/.vim

" Gyorsitja a vim mukodeset.
if v:version >= 704
  set regexpengine=1
endif

" Nem szeretem a magyar uzeneteket.
if ! has('win32')
  language en_US.utf8
endif

" Letrehozunk egy autocmd group-ot.
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
augroup vimrc
  autocmd!
augroup END

" "Nagyfelbontasu" terminal (pl. xterm), vagy gui eseten igaz az ertekkel ter
" vissza.
function! BigTerm()
  return  &columns >= (&textwidth + &numberwidth)
endfunction

"                                PLUGINOK                                 {{{1
" ============================================================================

let bundle_dir = $HOME . '/.vim_local/bundle'

if isdirectory(bundle_dir . '/vundle.vim')

  exe 'set runtimepath+=' . bundle_dir . '/vundle.vim'
  call vundle#begin(bundle_dir)
  filetype off

  Plugin 'gmarik/vundle.vim'                                            " {{{2
  " plugin-ok automatizalt telepitese git-en keresztul (is)

  Plugin 'shougo/vimproc.vim'                                           " {{{2
  " nehany plugin hasznalja - windows dll:
  " https://github.com/Shougo/vimproc.vim/downloads

                                                                        " }}}2

  " .. SAJAT ..............................

  Plugin 'bimbalaszlo/vim-eightheader'                                  " {{{2
  " (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...

    let g:EightHeader_comment   = 'call tcomment#Comment(line("."), line("."), "CL")'
    let g:EightHeader_uncomment = 'call tcomment#Comment(line("."), line("."), "UL")'

  Plugin 'bimbalaszlo/vim-eightstat'                                    " {{{2
  " statusline helper functions

    " autocmd  vimrc  BufEnter,BufWritePost  *  let b:stat_curfiledir = expand("%:p:h")

  Plugin 'bimbalaszlo/vim-numutils'                                     " {{{2
  " szamertekek modositasa regex alapjan

                                                                        " }}}2

  " .. MEGJELENES .........................
  " http://bytefluent.com/vivify/
  " http://cocopon.me/app/vim-color-gallery/
  " http://vimcolors.com/

  Plugin 'altercation/vim-colors-solarized'                             " {{{2
  " szep, finom colorscheme (light es dark is)

  " Plugin 'blueyed/vim-diminactive'                                      " {{{2
  " Aktiv ablak/buffer kiemelese.

    let g:diminactive_buftype_blacklist  = []
    let g:diminactive_filetype_blacklist = []

  Plugin 'nathanaelkane/vim-indent-guides'                              " {{{2
  " sor behuzasanak szinezese, hogy a blokkok jobban kovethetoek legyenek

    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_color_change_percent  = 4
    let g:indent_guides_default_mapping       = 0
    " let g:indent_guides_guide_size            = 1

  " Plugin 'yggdroot/indentline'                                          " {{{2
  " sor behuzasanak jelolese, hogy a blokkok jobban kovethetoek legyenek

  Plugin 'lilydjwg/colorizer'                                           " {{{2
  " rgb szinek megjelenitese, :ColorHighlight

    let g:colorizer_startup  = 0
    let g:colorizer_nomap    = 1
    let g:colorizer_maxlines = 1000
                                                                        " }}}2

  " .. KURZOR MOZGATASA ...................

  " Plugin 'tpope/vim-sexp-mappings-for-regular-people'                 " {{{2
  " normalisabb mozgas a text-objektumok kozott (w, b, ge, ...)

  Plugin 'vim-scripts/matchit.zip'                                      " {{{2
  " paros jelek kozti ugralas

    " FIGYELEM: nagyon belassulhat tole az egesz vim. Ezek sem segitenek:
    " let g:matchparen_timeout = 5
    " let g:matchparen_insert_timeout = 5

  Plugin 'easymotion/vim-easymotion'                                    " {{{2
  " gyors mozgas a buffer-en belul

    " Az alapertelmezett map-ok tiltasa.
    let g:EasyMotion_do_mapping = 0

    " A celt nagybetuvel mutassa, de engedje a kisebtuvel ugrast.
    let g:EasyMotion_use_upper = 1

    " A helymeghatarozashoz hasznalt betuk.
    let g:EasyMotion_keys = 'ASDFGHJKLUIOPQWER'

    " Az osszecsukottfold-okra is ugorhassunk.
    let g:EasyMotion_skipfoldedline = 0

    " Lasd a sugot.
    let g:EasyMotion_move_highlight = 0

  Plugin 't9md/vim-choosewin'                                           " {{{2
  " easymotion az ablakokon is

    let g:choosewin_label_align        = 'left'
    let g:choosewin_label_padding      = 1
    " let g:choosewin_overlay_enable     = 1
    " let g:choosewin_statusline_replace = 0
    " let g:choosewin_tabline_replace    = 0

    let g:choosewin_label              = 'ASDFHJKL'
    let g:choosewin_keymap             = {"\<C-L>": 'previous'}
                                                                        " }}}2

  " .. TEXTOBJ-USER .......................

  Plugin 'kana/vim-textobj-user'                                        " {{{2
  " sajat text-object

  Plugin 'thinca/vim-textobj-between'                                   " {{{2
  " ifX/afX az X-eken beluli kivalasztahoz

  Plugin 'julian/vim-textobj-variable-segment'                          " {{{2
  " _privat*e_thing -> civone -> _one_thing
  " eggsAn*dCheese  -> dav    -> eggsCheese
  " foo_ba*r_baz    -> dav    -> foo_baz
  " _privat*e_thing -> dav    -> _thing
  " _g*etJiggyYo    -> dav    -> _jiggyYo

  Plugin 'tek/vim-textobj-ruby'                                         " {{{2
  " ir/ar: block, if/af: method, ic/ac: class

    let g:textobj_ruby_no_mappings = 1

    " A comment-eket ne vegye bele.
    let g:textobj_ruby_inclusive = 0

  Plugin 'bps/vim-textobj-python'                                       " {{{2
  " if/af: function, ic/ac: class

    let g:textobj_python_no_default_key_mappings = 1

                                                                        " }}}2

  " .. SZOVEG KERESESE/MODOSITASA .........

  Plugin 'thinca/vim-visualstar'                                        " {{{2
  " kijelolt szoveg keresese * gombbal

  Plugin 'dkprice/vim-easygrep'                                         " {{{2
  " tuningolt vimgrep

    " Nem kellenek a default map-ok.
    " TODO: nem mukodik
    let g:EasyGrepOptionPrefix = ''

    " Ha csak lehet, hasznaljon gyorsabb grep-et mint a vimgrep.

    " Alapjaba veve a megnyitott fajl tipusaval megegyezo fajlokban keressen.
    " if executable('ag') || executable('pt')
    "   let g:EasyGrepCommand = 1
    " endif

    " A fajl konyvtaraban keressen, ne a cwd-ben.
    let g:EasyGrepSearchCurrentBufferDir = 1

    " Rekurzivan keressen a konyvtarakban.
    let g:EasyGrepRecursive = 1

    " De hagyja ki a kovetkezoket...
    let g:EasyGrepFilesToExclude = ".svn,.git"

    " Rejtett fajlokban is keressen.
    let g:EasyGrepHidden = 1

    " Soronkent tobb egyezest is talalhat. (mint pl.: :s///g)
    let g:EasyGrepEveryMatch = 1

    " Ne nyisson uj tab-okat a talalatokhoz.
    let g:EasyGrepReplaceWindowMode = 2

  Plugin 'vis'                                                          " {{{2
  " parancsok futtatasa visual block-on

  " Plugin 'jiangmiao/auto-pairs'                                         " {{{2

    " lasd a weboldalon: https://github.com/jiangmiao/auto-pairs
    " let g:AutoPairsFlyMode        = 1
    let g:AutoPairsCenterLine     = 0
    let g:AutoPairsMultilineClose = 0

  Plugin 'tpope/vim-surround'                                           " {{{2
  " paros jelek gyors cserelese/torlese

    let g:surround_no_insert_mappings = 1
    let g:surround_no_mappings        = 1

  Plugin 'tpope/vim-abolish'                                            " {{{2
  " intelligens substitute
  "   :%Subvert/facilit{y,ies}/building{,s}/g

  Plugin 'junegunn/vim-easy-align'                                      " {{{2
  " szoveg igazitasa nagyon intelligens modon, regex kifejezesekkel

    " A | az asciidoctor-nak megfelelo formazasokat is felismeri, az
    " 'ignore_unmatched' miatt a leghosszabb sor vege utan fog kerulni a pattern,
    " fuggetlenul attol, hogy abban szerepelt-e.
    let g:easy_align_delimiters = {
    \ '|': {'pattern': '\(\(^\|\s\)\@<=\(\d\+\*\)\?\(\(\d\+\|\.\d\+\|\d\+\.\d\+\)+\)\?\([\^<>]\|\.[\^<>]\|[\^<>]\.[\^<>]\)\?[a-z]\?\)\?|', 'filter': 'v/^|=\+$/'},
    \ 't': {'pattern': '\t'},
    \ '\': {'pattern': '\\$', 'stick_to_left': 0},
    \ '<': {'pattern': '<<$', 'stick_to_left': 0, 'ignore_unmatched': 0},
    \ '+': {'pattern': ' +$', 'stick_to_left': 0, 'filter': 'v/^+$/', 'ignore_unmatched': 0},
    \ }

  Plugin 'henrik/vim-qargs'                                             " {{{2
  " quickfix-en beluli fajlokon parancsok vegrehajtasa (Qdo) es masolasa az
  " args-ba (Qargs)

  Plugin 'stefandtw/quickfix-reflector.vim'                             " {{{2
  " quickfix-en keresztul a fajlok sorainak szerkesztese (:copen, ha nem lehet
  " szerkeszteni a quickfix-et)

                                                                        " }}}2

  " .. FAJLOK/BUFFEREK/STB. BONGESZESE ....

  Plugin 'shougo/unite.vim'                                             " {{{2
  " fajlok/tag-ok/stb. gyors keresese - a lehetosegekert lasd :Unite

    let g:unite_source_history_yank_enable  = 1
    " let g:unite_source_tag_show_location = 0
    let g:unite_source_tag_max_fname_length = 70
    let g:unite_enable_auto_select          = 0
    let g:unite_source_buffer_time_format   = ''

    " " Silver Searcher
    " if executable('ag')
    "   let g:unite_source_rec_async_command  = 'ag --follow --nocolor --nogroup --hidden -g ""'
    "   let g:unite_source_grep_command       = 'ag'
    "   let g:unite_source_grep_default_opts  =
    "   \ '-i --line-numbers --nocolor --nogroup --column --hidden --ignore ' .
    "   \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    "   let g:unite_source_grep_recursive_opt = ''
    " endif

    " Platinum Searcher
    if executable('pt')
      let g:unite_source_rec_async_command  = 'pt --hidden --follow --nocolor --nogroup --files-with-matches ""'
      let g:unite_source_grep_command       = 'pt'
      let g:unite_source_grep_default_opts  = '--hidden --nocolor --nogroup --column --smart-case'
      let g:unite_source_grep_recursive_opt = ''
      let g:unite_source_grep_encoding      = 'utf-8'
    endif

    " Alapertelmezett beallitasok.
    autocmd  vimrc  VimEnter  *  call unite#custom#profile('default', 'context', {
    \ 'prompt_direction': 'top',
    \ 'direction':        'botright',
    \ 'cursor_line_time': '0.0',
    \ 'sync':             1,
    \ 'start_insert':     1
    \ })

    autocmd  vimrc  VimEnter  *  call unite#custom#alias('file', 'delete', 'vimfiler__delete')

  Plugin 'shougo/vimfiler.vim'                                          " {{{2
  " nerdtree helyett: explorer, ketpaneles commander (unite kell hozza)

    let g:vimfiler_as_default_explorer = 1
    let g:unite_kind_file_use_trashbox = 0

    let g:vimfiler_tree_leaf_icon   = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon        = '-'
    let g:vimfiler_marked_file_icon = '*'

    let g:vimfiler_time_format = '%Y/%m/%d %H:%M'

    " Az alternate buffer maradjon a vimfiler, igy a ketpaneles modba konnyebb
    " visszavaltani.
    let g:vimfiler_restore_alternate_file = 0

    " A rejtett fajlokat is mutassa.
    let g:vimfiler_ignore_pattern = ''

    " Ne ugorjon a konyvtar kinyitasa utan.
    let g:vimfiler_expand_jump_to_first_child = 0

    autocmd  vimrc  VimEnter  *  call vimfiler#custom#profile('default', 'context', {
    \ 'safe':      0,
    \ 'sort_type': 'extension',
    \ 'columns':   'size:time'
    \ })

  Plugin 'shougo/unite-outline'                                         " {{{2
  " tagbar-szeru, de neha jobb
                                                                        " }}}2

  " .. EGYEB HASZNOSSAGOK .................

  Plugin 'locator'                                                      " {{{2
  " a gl megmutatja hol vagy (fold, func, stb.)

  Plugin 'moll/vim-bbye'                                                " {{{2
  " :Bdelete buffer torlesehez az ablakok buzeralasa nelkul

  Plugin 'tpope/vim-repeat'                                             " {{{2
  " repeat (.) plugin-okon is

  Plugin 'tyru/open-browser.vim'                                        " {{{2
  " netrw gx helyett

  " Plugin 'jceb/vim-orgmode'                                             " {{{2

    let maplocalleader=','
    let g:org_agenda_files = ['~/test.org']

  " Plugin 'hsitz/vimorganizer'
  " emacs org-mode in vim

    let g:agenda_files=['~/test.org']

  Plugin 'vimoutliner/vimoutliner'                                      " {{{2
  " talan a legteljesebb org-mode plugin
                                                                        " }}}2

  " .. BENCHMARK ..........................

  Plugin 'mattn/benchvimrc-vim'                                         " {{{2
  " :BenchVimrc
                                                                        " }}}2

  " .. PROGRAMOZAS ........................

  " Plugin 'scrooloose/nerdcommenter'                                     " {{{2
  " szovegreszek kommentelese (akar oszlopok is)

    " Rakjon szokozoket a kommenterek kore.
    let NERDSpaceDelims = 1

    " :help NERDBlockComIgnoreEmpty
    let NERDBlockComIgnoreEmpty = 0

    " Az alapertelmezett map-ok kikapcsolasa. (mivel keves kommentelo parancsot
    " hasznalok es azokat sajat map-okra allitottam, igy teljesen feleslegesek)
    let NERDCreateDefaultMappings = 0

  Plugin 'tomtom/tcomment_vim'                                          " {{{2
  " szovegreszek kommentelese

    let g:tcommentMaps = 0

  Plugin 'majutsushi/tagbar'                                            " {{{2
  " a fajlban talalhato tag-ek listaja
  " $ install ctags

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

  Plugin 'kabbamine/zeavim.vim'                                         " {{{2
  " talan a legnormalisabb referencia-bongeszo
  " $ install zeal @ http://zealdocs.org/

    let g:zv_disable_mapping = 1

    if isdirectory('c:/app/zeal/')
      let g:zv_zeal_directory = 'c:/app/zeal/zeal.exe'
    endif

    autocmd  vimrc  FileType  ruby  Docset ruby 2

  Plugin 'scrooloose/syntastic'                                         " {{{2
  " syntax checker

    " Statusline indikator formaja.
    let g:syntastic_stl_format = '%W{!W%fw}%E{!E%fe}'

    " Irja ki, hogy melyik checker-tol szarmazik a figyelmeztetes.
    let g:syntastic_aggregate_errors = 1

    " __ C __________________________________

    let g:syntastic_c_checkers = ['gcc', 'splint']

    " __ PYTHON _____________________________

    let g:syntastic_python_checkers = ['pylint', 'flake8']

    " Stilushibak figyelmen kivul hagyasa.
    " let g:syntastic_python_pylint_args           = '-d line-too-long -d bad-indentation -d bad-whitespace'
    " let g:syntastic_python_flake8_quiet_messages = { 'type' : 'style' }

    " __ RUBY _______________________________

    " let g:syntastic_ruby_checkers = ['mri', 'rubocop']

  if has('lua') | exe "Plugin 'shougo/neocomplete.vim'" | endif         " {{{2
  " automatikus kodkiegeszites
  " lua kell hozza (:version +lua)

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
    if !exists('g:neocomplete#sources')
      let g:neocomplete#sources = {}
    endif
    let g:neocomplete#sources._ = ['omni', 'tag', 'member', 'syntax', 'vim', 'neosnippet', 'calc']

    " Ruby-nal le van tilva az omnifunc, mert lassu, viszont igy engedelyezni
    " tudjuk.
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

  Plugin 'shougo/neco-vim'                                              " {{{2
  " vim kiegeszites a neocomplete-hez

  Plugin 'shougo/echodoc.vim'                                           " {{{2
  " fuggveny argumentumok kiirasa a statusline ala

    let g:echodoc_enable_at_startup = 1

  Plugin 'shougo/neosnippet.vim'                                        " {{{2
  " template-ek

    let g:neosnippet#disable_runtime_snippets      = {'_': 1}
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory            = bundle_dir . '/vim-snippets/snippets'

  Plugin 'honza/vim-snippets'                                           " {{{2
  " template-ek

  Plugin 'hrsh7th/vim-neco-calc'                                        " {{{2
  " aranyos szamologep a neovomplete-hez (calc source)

  Plugin 'thinca/vim-quickrun'                                          " {{{2
  " buffer, vagy kijelolt kod futtatasa

    let g:quickrun_no_default_key_mappings = 1
    " \     'hook/output_encode/encoding': 'default',
    let g:quickrun_config = {
    \ '_':
    \ {
    \   'outputter':                     'multi',
    \   'outputter/multi/targets':       ['buffer', 'quickfix'],
    \   'outputter/buffer/running_mark': '... RUNNING ...',
    \   'runner':                        'vimproc',
    \   'hook/cd/directory':             '%S:p:h',
    \ },
    \ 'asciidoc':
    \ {
    \   'command':   'asciidoctor',
    \   'cmdopt':    '-o -',
    \   'outputter': 'browser'
    \ },
    \ 'text':
    \ {
    \   'command':   'asciidoctor',
    \   'cmdopt':    '-o -',
    \   'outputter': 'browser'
    \ },
    \ 'rubyCustom':
    \ {
    \   'command': 'irb'
    \ },
    \ 'ruby.rspec':
    \ {
    \   'command':              'rspec',
    \   'cmdopt':               '-f d',
    \   'hook/unittest/enable': 1
    \ },
    \ 'ruby.minitest':
    \ {
    \   'command':              'ruby',
    \   'hook/unittest/enable': 1
    \ },
    \ 'php.unit':
    \ {
    \   'command':              'testrunner',
    \   'cmdopt':               'phpunit',
    \   'hook/unittest/enable': 1
    \ },
    \ 'python.unit':
    \ {
    \   'command':              'nosetests',
    \   'cmdopt':               '-v -s',
    \   'hook/unittest/enable': 1
    \ },
    \ 'python.pytest':
    \ {
    \   'command':              'py.test',
    \   'cmdopt':               '-v',
    \   'hook/unittest/enable': 1
    \ }
    \}

    autocmd vimrc FileType quickrun if has('win32') | set fileformat=dos | end

    autocmd vimrc BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
    autocmd vimrc BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
    " autocmd vimrc BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
    autocmd vimrc BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
    autocmd vimrc BufWinEnter,BufNewFile *_test.rb setlocal filetype=ruby.minitest

  Plugin 'heavenshell/vim-quickrun-hook-unittest'                       " {{{2
  " tesztek futtatasa kulon-kulon - a beallitasok a quickrun alatt vannak

  if has('python') | exe "Plugin 'davidhalter/jedi-vim'" | endif        " {{{2
  " python irasat nagyban megkonnyito kiegeszitesek / sugok
  " $ pip install jedi

    " Ha ez nincs megadva, akkor ütközik a neocomplete-tal es automatikusan ki
    " akarja valasztani az elso elemet ha pontot irunk egy objektum utan.
    " let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0

    " Bufferek hasznalata tab-ok helyett.
    let g:jedi#use_tabs_not_buffers = 0

    " Ne valassza ki az elso lehetoseget.
    let g:jedi#popup_select_first = 0

  Plugin 'vim-ruby/vim-ruby'                                            " {{{2
  " ruby motyok (pl. omni completion pontosabban mukodik)

    " :help ft-ruby-omni
    let g:rubycomplete_buffer_loading    = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails             = 1
    let g:rubycomplete_load_gemfile      = 1
    let g:ruby_no_comment_fold           = 1
    let g:ruby_operators                 = 1

  Plugin 'ekalinin/dockerfile.vim'                                      " {{{2
  " syntax

                                                                        " }}}2

  " .. GIT ................................

  Plugin 'tpope/vim-fugitive'                                           " {{{2
  " git integracio
  " $ install git

  Plugin 'gregsexton/gitv'                                              " {{{2
  " gitk a vim-en belul
  " $ install git

    " A commit uzeneteket roviditse le annyira, hogy minden info latszodjon.
    let g:Gitv_TruncateCommitSubjects = 1

    " Control key-eket ne map-oljon.
    let g:Gitv_DoNotMapCtrlKey = 1

                                                                        " }}}2
  call vundle#end()
else
  autocmd  vimrc  *  echomsg "Run :InstallVundle"
endif

"                              INSTALLVUNDLE                              {{{1
" ============================================================================
"
" Cloning vundle to ~/.vim/bundle/vundle

command!  InstallVundle  call InstallVundle()
function! InstallVundle()
  let vundle_repo = 'https://github.com/gmarik/vundle.vim'
  let path = substitute(g:bundle_dir . '/vundle.vim', '/', has('win32') ? '\\' : '/', 'g')

  if ! executable('git')
    echohl ErrorMsg | echomsg 'Git is not available.' | echohl None
    return
  endif

  if ! isdirectory(path)
    silent! if ! mkdir(path, 'p')
      echohl ErrorMsg | echomsg 'Cannot create directory (may be a regular file):' | echomsg path | echohl None
      return
    endif
  endif

  echo 'Cloning Vundle...'
  let msg = system('git clone "' . vundle_repo . '" "' . path . '"')
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
if exists(':filetype')
  filetype plugin indent on
endif

" Szintaxiskiemeles.
if has('syntax') && filereadable($VIMRUNTIME . '/syntax/syntax.vim')
  syntax enable
endif

" Eger viselkedese.
behave xterm

" Manual bongeszesenek lehetosege.
if !has('win32')
  runtime ftplugin/man.vim
endif

"                          WIN / NIX BEALLITASOK                          {{{1
" ============================================================================

if has('win32')

  " :make ezt a programot hasznalja:
  set makeprg=mingw32-make

  " Ha egy tomoritett fajlt nyitunk meg, hianyolja ezt a valtozot ezert
  " hibauzenetet ir ki.
  let netrw_cygwin = 0

endif

"                                   SZINEK                                {{{1
" ============================================================================

"                               ALAPERTEKEK                               {{{2
" ____________________________________________________________________________

" Statusline szinei.
autocmd  vimrc  ColorScheme  *
\ highlight! link StatFilename   DiffText   |
\ highlight! link StatFileformat DiffAdd    |
\ highlight! link StatInfo       DiffChange |
\ highlight! link StatWarning    WarningMsg

"                                SOLARIZED                                {{{2
" ____________________________________________________________________________

let g:solarized_menu = 0

" A par nelkuli zarojelek kijelzese alig lathato.
autocmd  vimrc  ColorScheme  solarized  highlight! link Error ErrorMsg

" A soremeles karakterek is egybeolvadnak a szoveggel. Ez a highlight a high
" visibility beallitasokol van atmasolva.
autocmd  vimrc  ColorScheme  solarized  highlight! NonText term=bold ctermfg=9 gui=bold guifg=#dc322f

" A tab, whitespace, stb. szinei is ilyenek legyenek.
autocmd  vimrc  ColorScheme  solarized  highlight! link SpecialKey NonText

" Ne legyenek alahuzva az osszecsukott foldok.
autocmd  vimrc  ColorScheme  solarized  highlight! Folded term=bold,italic cterm=bold,italic gui=bold,italic

" Mivel a terminalos szinsema nincs definialva (?), igy nekunk kell erteket
" adni neki.
autocmd  vimrc  ColorScheme  solarized  highlight! TagbarHighlight term=inverse ctermfg=White

"                                 DESERT                                  {{{2
" ____________________________________________________________________________

autocmd  vimrc  ColorScheme  desert  set background=dark

" Statusline szinei.
autocmd  vimrc  ColorScheme  desert
\ highlight! link StatFilename   Directory  |
\ highlight! link StatFileformat Identifier |
\ highlight! link StatInfo       ModeMsg    |
\ highlight! link StatWarning    WarningMsg

" Nem tetszenek a popupmenu szinei.
autocmd  vimrc  ColorScheme  desert
\ highlight! Pmenu      ctermbg=Black ctermfg=Gray  guibg=#FFFFCC guifg=DarkGray          |
\ highlight! PmenuSel   ctermbg=Black ctermfg=White guibg=#FFFFCC guifg=Black    gui=bold |
\ highlight! PmenuSbar  ctermbg=Black ctermfg=Black guibg=#FFFFCC guifg=#FFFFCC           |
\ highlight! PmenuThumb ctermbg=White ctermfg=White guibg=Black   guifg=Black
                                                                        " }}}2

" Ha nappal van es a solarized elerheto, hasznaljuk azt.
if has('gui_running')
  if len(globpath(&runtimepath, 'colors/solarized.vim'))
  \ && (strftime("%H") >= 7 && strftime("%H") <= 17)

    set background=light
    colorscheme solarized

  elseif len(globpath(&runtimepath, 'colors/solarized.vim'))

    set background=dark
    colorscheme solarized

  elseif len(globpath(&runtimepath, 'colors/desert.vim'))

    colorscheme desert

  endif
elseif len(globpath(&runtimepath, 'colors/desert.vim'))

  colorscheme desert

endif

"                               STATUSLINE                                {{{1
" ============================================================================

" Mindig mutassa a statusline-t.
set laststatus=2

let stat_filedir    = '%<%{exists("b:stat_curfiledir") ? b:stat_curfiledir : ""}'
let stat_bufnr      = '%{&buflisted ? bufnr("%") : ""}'
let stat_filename   = '%w%t%r%m'
let stat_fileformat = '%{&binary ? "binary" : ((strlen(&fenc) ? &fenc : &enc) . (&bomb ? "-bom" : "") . " ") . &ff}'
" if filereadable(bundle_dir . '/tagbar/autoload/tagbar.vim')
  " let stat_tagbar   = '%{(winwidth(0) > 120) ? strpart(tagbar#currenttag("%s",""), 0, 50) : ""}'
" else
  let stat_tagbar   = ''
" endif
let stat_lineinfo   = '%4l:%3p%%|%3v'

let &statusline  = stat_bufnr . ' '
let &statusline .= '%#StatFilename# ' . stat_filename . ' '
let &statusline .= '%#StatFileformat# ' . stat_fileformat . ' '
let &statusline .= '%#StatWarning#%{(winwidth(0) > 70) && exists("*StatWarn") ? StatWarn() : ""}'
let &statusline .= '%#StatInfo#%{len(StatFugitive()) ? "  " . StatFugitive() . " " : ""}'
let &statusline .= '%* ' . stat_filedir . ' '
let &statusline .= '%= '
let &statusline .= stat_tagbar . ' '
let &statusline .= '%#StatWarning#%{len(StatSyntastic()) ? " " . StatSyntastic() . " " : ""}'
let &statusline .= '%#StatInfo# ' . stat_lineinfo . ' '

" __ STATSYNTASTIC __________________________
"
" Syntastic figyelmeztetesek sorszamai.

function! StatSyntastic()
  return exists(':SyntasticCheck') ? SyntasticStatuslineFlag() : ''
endfunction

" __ STATFUGITIVE ___________________________
"
" Branch : commit

" Halozati meghajton nagyon belassit.
let g:statfugitive_disabled = 0
function! StatFugitive()
  return (exists('b:git_dir') && ! g:statfugitive_disabled) ? fugitive#head(7) . ':' . fugitive#buffer().commit()[0:6] : ''
endfunction

"                                  NETRW                                  {{{1
" ============================================================================

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
" if BigTerm()
"   set relativenumber
" endif

" Minden valtoztatasrol tajekoztasson.
set report=0

" Operatorra varo parancs mutatasa (pl. makro rogzitesehez hasznalt 'q'),
" kijelolesnel a kijeloles merete.
set showcmd

" Mod (insert, visual, stb.) mutatasa.
set showmode

" Kellokepp magas legyen a statusline alatti terulet.
set cmdheight=2

" A kurzor soranak kiemelese.
set cursorline

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

" A sor utolso karaktere utan egyel is allhat a kurzor.
" NAGYON HASZNOS TUD LENNI!
set virtualedit=onemore

" Mindig legyen eger.
set mouse=a

" Makrok futtatasanal ne frissitse a kepernyot, csak ha vegzett.
set lazyredraw

" Ne adjon ki hangot - a .gvimrc-nek is tartalmaznia kell.
set visualbell vb t_vb=

" Tordelje el a hosszu sorokat. (softbreak)
set wrap

" ... a szavak vegenel.
" set linebreak

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

"                             FAJLOK BEALLITASAI                          {{{1
" ============================================================================

" Fajlok elore megadott beallitasait hasznalhatja. (fajl elejen, vagy vegen
" talalhato vim-specifikus beallitasok)
set modeline

" Lehetseges sorvegzodesek/karakterkodolasok. Uj fajl letrehozasanal az elso
" parametert hasznalja.
set fileformats=unix,dos fileencodings=utf8,cp1250,default

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
let s:swapdir = $HOME.'/.vim_local/swap'
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir

" Persistent undo.
let s:undodir = $HOME.'/.vim_local/undo'
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
let &undodir = s:undodir
set undofile

"                                  KERESES                                {{{1
" ============================================================================

" Case insensitive keresesnel, de nagybetus szoveg eseten case sensitive-re
" valt.
set ignorecase smartcase

" Kereses talalatainak kiemelese mar begepeles kozben.
set hlsearch incsearch

" Mivel nem mindig veszem eszre, hogy a fajl vegerol mar atugrottam az
" elejere, ezert inkabb le is tiltom ezt a lehetoseget.
set nowrapscan

" Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --column
endif

" Platinum Searcher
if executable('pt')
  set grepprg=pt\ --nogroup\ --nocolor\ --column
endif

"                             SZINTAXIS KIEMELES                          {{{1
" ============================================================================

" Egy soron belul max. eddig a karakterig szinezze a szoveget. (hosszu
" soroknal nagyon belassul e nelkul)
set synmaxcol=500

" Shell-scrip-eknel ne jelezze hibanak: $()
let is_posix = 1

" Specialis karakterek (tabulator, sor vegi whitespace) mutatasa.
if has('gui_running')
  set list listchars=tab:▶‒,trail:∙,extends:▶,precedes:◀
else
  set list listchars=tab:>-,trail:.,extends:>,precedes:<
endif

" Sortores mutatasa.
if has('gui_running')
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
let &foldtext = "EightHeaderFolds(&tw, 'left', [ repeat('  ', v:foldlevel - 1), repeat(' ', v:foldlevel - 1) . '.', '' ], '', '')"

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

" Kiegeszites menujenek mukodese:
" menuone  Egyetlen lehetoseg eseten is popup menu.
" longest  Nem valasztja ki magatol az elso lehetoseget.
set completeopt=menuone,longest

" Fuggvenyek parametereit is mutatja kiegeszitesnel.
set showfulltag

"                                    MAP                                  {{{1
" ============================================================================
"
" A specialis gombok kombinacioi (pl.: <S-Up>) TTY-ben nem mukodnek.
"
" HA TERMINALBAN NEM MUKODNENEK A KURZORBILLENTYUK:
"   :verbose imap <Esc>
" Ezen map-ok valamelyike okozza a hibat.

" Jobban kézre esik, mint a \.
let mapleader='á'

"                                ALTALANOS                                {{{2
" ____________________________________________________________________________

" Mivel igazan semmi hasznat nem latom, igy letiltom az ex-modot elohozo
" gombot.
nnoremap  Q  <Nop>

" Konnyebben elerheto Esc.Korabban a <C-C> to <Esc> volt (az InsertLeave esemeny
" nem tortenik meg a <C-C> hatasara), de valamiert a 7.4.640 kornyeken mar nem
" mukodott.
noremap   <C-K>  <Esc>
inoremap  <C-K>  <Esc>
cnoremap  <C-K>  <C-C>

" Hogy tovabbra is be lehessen illeszteni a digraph-okat.
nnoremap  <Leader><C-K>  i<C-K>

" Sokkal jobban kezre esnek.
map       <C-J>  <CR>
imap      <C-J>  <CR>
" noremap   é      ;
" noremap   É      ,

" Hogy a kiegesziteseknel se kelljen a nyilakhoz nyulni. (probald ki, hogy egy
" elozoleg beirt parancs elso betuje utan a <C-P>-t nyomogatod, majd ugyanigy
" a felfele nyillal keresed az elozmenyeket)
cnoremap  <C-N>  <Up>
cnoremap  <C-P>  <Down>

" Bufferek kozti mozgas.
nnoremap  <C-E>  :bnext<CR>
nnoremap  <C-Y>  :bprevious<CR>

" Ugras a sor elejere/vegere.
noremap  H  g^
noremap  L  g$

" Ablakkezeles.
nnoremap  <C-H>  <C-W>q

" Kepernyo ujrarajzoltatasa/frissitese, valamint a fajlok ellenorzese, hogy
" nem valtoztak-e meg egy kulso program altal.
nnoremap  <C-G>  <C-L>:checktime<CR>

" Hasznosabb backspace/delete. Az <expr> azert kell, mert a sor veget/elejet
" nem torli a d:call search().
" Kell hozza: set virtualedit=onemore
" inoremap  <expr>  <C-W>  (col(".") == 1       ) ? "<BS>"  : "<C-O>d:call search('\\s\\+\\<Bar>[A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű\\n]\\+\\<Bar>[^A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű]', 'Wb')<CR>"
inoremap  <expr>  <C-L>  (col(".") == col("$")) ? "<Del>" : "<C-O>d:call search('\\s\\+\\<Bar>[A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű\\n]\\+\\<Bar>[^A-Za-z0-9ÁÉÍÓÖŐÚÜŰáéíóöőúüű]', 'W')<CR>"

" A torles ne masolja a vagolapra a szoveget.
" noremap   s      "_s
noremap   S      "_S
noremap   c      "_c
noremap   C      "_C
noremap   d      "_d
nnoremap  dd     "_dd
noremap   D      "_D
noremap   <Del>  "_<Del>
" Kivagas motion-nel.
noremap   x      d
" ... viszont a karakterek felcsereleset meghagyjuk.
nnoremap  xp     xp
nnoremap  xP     xP

" Korabban masolt szoveg beillesztese.
nnoremap  <Leader>p  :Unite history/yank<CR>

" Az ablakkezelo vagolapjanak hasznalata - command-modban hatastalan, a
" kijelolt szoveget illeszti be, nem pedig azt, amire <C-Insert>-et nyomtunk.
" Kell hozza: set virtualedit=onemore
noremap  <C-Insert>  "+y
noremap  <S-Insert>  "+P
imap     <S-Insert>  <C-O><S-Insert>

" Kurzor alatti parancs sugojanak megnyitasa.
autocmd  vimrc  FileType  man  call ManMap()
function! ManMap()
  map    <buffer>  K     <C-]>
  map    <buffer>  <CR>  <C-]>
endfunction

"                                PLUGINOK                                 {{{2
" ____________________________________________________________________________

"                                  NETRW                                  {{{3
" ............................................................................

" Lynx-szeru mozgas netrw-ben.
autocmd  vimrc  FileType  netrw  call NetrwLynxMap()
function! NetrwLynxMap()
  map  <buffer>  h  -
  map  <buffer>  l  <CR>
endfunction

"                               EASYMOTION                                {{{3
" ............................................................................

map  s          <Plug>(easymotion-s2)
map  t          <Plug>(easymotion-tl)
map  T          <Plug>(easymotion-Tl)
map  t          <Plug>(easymotion-tl)
map  T          <Plug>(easymotion-Tl)
map  f          <Plug>(easymotion-fl)
map  F          <Plug>(easymotion-Fl)
map  <Leader>n  <Plug>(easymotion-n)
map  <Leader>N  <Plug>(easymotion-N)
map  é          <Plug>(easymotion-next)
map  É          <Plug>(easymotion-prev)

autocmd  vimrc  VimEnter  *  if exists(':EMCommandLineNoreMap') | EMCommandLineNoreMap <C-J> <CR> | endif

"                                CHOOSEWIN                                {{{3
" ............................................................................

nmap  <expr>  <Plug>(mychoosewin)  (winnr('$') > 2) ? '<Plug>(choosewin)' : '<C-W>w'
nmap  <C-L>   <Plug>(mychoosewin)

"                             CAMELCASEMOTION                             {{{3
" ............................................................................

map  <Leader>b  <Plug>CamelCaseMotion_b
map  <Leader>e  <Plug>CamelCaseMotion_e

"                               OPENBROWSER                               {{{3
" ............................................................................

" Url megnyitasa a bongeszoben, vagy google a kurzor alatti szora.
let g:netrw_nogx = 1
nmap  gx  <Plug>(openbrowser-smart-search)
vmap  gx  <Plug>(openbrowser-smart-search)

"                             UNITE/VIMFILER                              {{{3
" ............................................................................

autocmd  vimrc  FileType  unite  call UniteMaps()
function! UniteMaps()
  imap  <buffer>        <C-K>   <Plug>(unite_insert_leave)
  map   <buffer>        <C-K>   <Plug>(unite_all_exit)
  map   <buffer>        <C-H>   <Plug>(unite_all_exit)
  map   <buffer>        <Esc>   <Plug>(unite_all_exit)
  nmap  <buffer>        <C-N>   <Plug>(unite_loop_cursor_down)
  nmap  <buffer>        <C-P>   <Plug>(unite_loop_cursor_up)
  nmap  <buffer>        h       <Plug>(unite_delete_backward_path)
  nmap  <buffer>        l       <CR>
  nmap  <buffer>        S       <Plug>(unite_append_end)<C-U>
  imap  <buffer>        /       /*
  map   <buffer>        <C-Z>   <Plug>(unite_smart_preview)
  imap  <buffer><expr>  <C-Z>   unite#do_action('preview')
  map   <buffer><expr>  <C-CR>  unite#do_action('start')
  imap  <buffer><expr>  <C-CR>  unite#do_action('start')
  nmap  <buffer>        <C-L>   <Plug>(mychoosewin)
endfunction

autocmd  vimrc  FileType  vimfiler  call VimfilerMaps()
function! VimfilerMaps()
  nmap  <buffer>        i       :Unite line -start-insert -winheight=10<CR>
  nmap  <buffer>        <C-J>   <CR>
  map   <buffer>        <C-Z>   <Plug>(vimfiler_preview_file)
  map   <buffer>        <F3>    <Plug>(vimfiler_preview_file)
  map   <buffer>        <F5>    <Plug>(vimfiler_copy_file)
  map   <buffer>        <F6>    <Plug>(vimfiler_move_file)
  map   <buffer>        <F7>    <Plug>(vimfiler_make_directory)
  map   <buffer><expr>  <F11>   vimfiler#do_action('start')
  map   <buffer><expr>  <C-CR>  vimfiler#do_action('start')
  imap  <buffer><expr>  <C-CR>  vimfiler#do_action('start')
  nmap  <buffer>        <C-L>   <Plug>(mychoosewin)
endfunction

"                         NEOCOMPLETE/NEOSNIPPET                          {{{3
" ............................................................................

" Neocomplete megnyitasa manualisan.
" Terminal-ban a <Nul> a <C-Space> megfeleloje.
inoremap  <expr>  <C-Space>  neocomplete#start_manual_complete()
imap      <expr>  <Nul>      <C-Space>

" Completion, vagy snippet beszurasa.
imap      <expr>  <Tab>      neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
imap      <expr>  <Nul>      <C-Space>

"                              TEXTOBJ-USER                               {{{3
" ............................................................................

" Roviditesek a thinca/vim-textobj-between pluginnak koszonhetoen.
omap  i*   <Plug>(textobj-between-i)*
xmap  i*   <Plug>(textobj-between-i)*
omap  a*   <Plug>(textobj-between-a)*
xmap  a*   <Plug>(textobj-between-a)*
omap  i:   <Plug>(textobj-between-i):
xmap  i:   <Plug>(textobj-between-i):
omap  a:   <Plug>(textobj-between-a):
xmap  a:   <Plug>(textobj-between-a):
omap  i#   <Plug>(textobj-between-i)#
xmap  i#   <Plug>(textobj-between-i)#
omap  a#   <Plug>(textobj-between-a)#
xmap  a#   <Plug>(textobj-between-a)#
omap  i/   <Plug>(textobj-between-i)/
xmap  i/   <Plug>(textobj-between-i)/
omap  a/   <Plug>(textobj-between-a)/
xmap  a/   <Plug>(textobj-between-a)/
omap  i\|  <Plug>(textobj-between-i)<Bar>
xmap  i\|  <Plug>(textobj-between-i)<Bar>
omap  a\|  <Plug>(textobj-between-a)<Bar>
xmap  a\|  <Plug>(textobj-between-a)<Bar>

autocmd  vimrc  FileType  ruby  call TextObjMapsRuby()
function! TextObjMapsRuby()
  omap  <buffer>  ab  <Plug>(textobj-ruby-block-a)
  omap  <buffer>  ib  <Plug>(textobj-ruby-block-i)
  omap  <buffer>  ac  <Plug>(textobj-ruby-class-a)
  omap  <buffer>  ic  <Plug>(textobj-ruby-class-i)
  omap  <buffer>  af  <Plug>(textobj-ruby-function-a)
  omap  <buffer>  if  <Plug>(textobj-ruby-function-i)

  xmap  <buffer>  ab  <Plug>(textobj-ruby-block-a)
  xmap  <buffer>  ib  <Plug>(textobj-ruby-block-i)
  xmap  <buffer>  ac  <Plug>(textobj-ruby-class-a)
  xmap  <buffer>  ic  <Plug>(textobj-ruby-class-i)
  xmap  <buffer>  af  <Plug>(textobj-ruby-function-a)
  xmap  <buffer>  if  <Plug>(textobj-ruby-function-i)
endfunction

autocmd  vimrc  FileType  python  call TextObjMapsPython()
function! TextObjMapsPython()
  omap  <buffer>  ac  <Plug>(textobj-python-class-a)
  omap  <buffer>  ic  <Plug>(textobj-python-class-i)
  omap  <buffer>  af  <Plug>(textobj-python-function-a)
  omap  <buffer>  if  <Plug>(textobj-python-function-i)

  xmap  <buffer>  ac  <Plug>(textobj-python-class-a)
  xmap  <buffer>  ic  <Plug>(textobj-python-class-i)
  xmap  <buffer>  af  <Plug>(textobj-python-function-a)
  xmap  <buffer>  if  <Plug>(textobj-python-function-i)
endfunction

" Blokkok, vagy tablazatok kijelolese - a kurzor elotti blokkhatarolot veszi
" alapul. Minden olyan sort, ahol csak ugyanaz a karakter szerepel
" blokkhatarnak veszi. A tablazatokat a ^.=\+$ formaban keresi meg, mert lehet
" pl. |===, vagy ;=== is.
autocmd  vimrc  FileType  asciidoc  if exists('*textobj#user#plugin') | call TextObjMapsAdoc() | endif

function! TextObjMapsAdoc()
  call textobj#user#plugin('adocblock', {
  \   '-': {
  \     'select-a-function': 'AdocBlockA',
  \     'select-a':          'ab',
  \     'select-i-function': 'AdocBlockI',
  \     'select-i':          'ib',
  \   }
  \ })
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

noremap   <Space>?        :Unite mapping<CR>

map       <Space>j        <Plug>(easymotion-sol-j)
map       <Space>k        <Plug>(easymotion-sol-k)
nnoremap  <Space>h        :nohlsearch<CR>
nnoremap  <Space>O        :pu! _<CR>
nnoremap  <Space>o        :pu  _<CR>
nnoremap  <Space><Tab>    :buffer #<CR>
noremap   <Space><Space>  <C-]>

nmap      <Space>;        <Plug>TComment_gc
nmap      <Space>;;       <Plug>TComment_gcc
vmap      <Space>;        <Plug>TComment_gc

"                         <Space>a - APPLICATIONS                         {{{3
" ............................................................................

" TODO: xterm cwd
nnoremap  <expr>  <Space>as   has('win32')
                              \ ? ':silent !start conemu64.exe /Dir "'.expand('%:p:h').'"<CR>'
                              \ : ':silent !cd '.expand('%:p:h').'; xterm; cd -<CR>'

" Profiling.
nnoremap  <Space>app  :profile start ./profile.log <Bar> profile func * <Bar> profile file * <Bar> echomsg "Profiling started, <lt>Space>apq to stop it (and quit from Vim!)."<CR>
nnoremap  <Space>apq  :profile pause <Bar> noautocmd qall<CR>
nnoremap  <Space>apb  :BenchVimrc<CR>

"                           <Space>b - BUFFERS                            {{{3
" ............................................................................

nnoremap  <Space>bb  :Unite buffer<CR>
nnoremap  <Space>bB  :Unite buffer:!<CR>
nnoremap  <Space>bc  :Unite change<CR>
nnoremap  <Space>bd  :Bdelete<CR>
nnoremap  <Space>bD  :Bdelete!<CR>

"                            <Space>f - FILES                             {{{3
" ............................................................................

" TODO: UniteWithBufferDir - ~ not goes to $HOME; Unite file:%:p:h not goes to ../
nnoremap  <Space>ff  :UniteWithBufferDir file directory/new file/new<CR>
nnoremap  <Space>ft  :UniteWithBufferDir file directory/new file/new -tab<CR>
nnoremap  <Space>fF  :Unite file directory/new file/new<CR>
nnoremap  <Space>fs  :write<CR>
nnoremap  <Space>fS  :wall<CR>
nnoremap  <Space>fvg :edit $MYGVIMRC<CR>
nnoremap  <Space>fvv :edit $MYVIMRC<CR>

"                             <Space>g - GIT                              {{{3
" ............................................................................

nnoremap  <Space>gd  :Gdiff<CR>
nnoremap  <Space>gs  :Gstatus<CR>
nnoremap  <Space>gl  :Gitv!<CR>
nnoremap  <Space>gL  :Gitv<CR>

"                    <Space>m - MODE (FILETYPE) AWARE                     {{{3
" ............................................................................

nmap              <Space>mK  <Plug>Zeavim
vmap              <Space>mK  <Plug>ZVVisSelection
nnoremap          <Space>mg  :Grep<Space>
nnoremap          <Space>mo  :Unite outline<CR>
nnoremap          <Space>mr  :QuickRun<CR>
noremap   <expr>  <Space>mR  ':QuickRun ' . &filetype . 'Custom<CR>'
nnoremap          <Space>mt  :TagbarToggle<CR>

" __ VIM ________________________________

autocmd  vimrc  FileType  vim  noremap <buffer>  <Space>m9
\ :call EightHeader(78, 'left', 1, ' ', '" {'.'{{2' , '')<CR><CR>

" __ VIMHELP ____________________________

autocmd  vimrc  FileType  help  nnoremap <buffer>  <Space>m1
\ :call EightHeader(78, 'left', 1, ' ', '\= "*".matchstr(s:str, ";\\@<=.*")."*"', '\= matchstr(s:str, ".*;\\@=")')<CR><CR>

autocmd  vimrc  FileType  help  noremap <buffer>  <Space>m2
\ :call EightHeader(78, 'left', 1, '.', '\= "\|".matchstr(s:str, ";\\@<=.*")."\|"', '\= matchstr(s:str, ".*;\\@=")')<CR><CR>

" __ ASCIIDOC ___________________________

autocmd  vimrc  FileType  asciidoc  vnoremap  <Space>mgq  :AdocFormat<CR>$hD

" __ RUBY _______________________________

autocmd  vimrc  FileType  ruby  nnoremap  <buffer><expr>  <Space>ms  has('win32')
                                \ ? ':silent !start conemu64.exe /cmd irb.bat<CR>'
                                \ : ':silent !xterm -c irb &<CR>'

" __ PYTHON _____________________________

autocmd  vimrc  FileType  python  nnoremap  <buffer><expr>  <Space>ms  has('win32')
                                  \ ? ':silent !start conemu64.exe /cmd python.exe<CR>'
                                  \ : ':silent !xterm -c python &<CR>'

"                           <Space>p - PROJECT                            {{{3
" ............................................................................

nnoremap  <Space>pf  :UniteWithProjectDir -buffer-name=project_files -resume file_rec/async directory/new file/new<CR>
nnoremap  <Space>pt  :VimFilerExplorer -project -toggle<CR>

"                      <Space>q - QUOTES, SURROUNDS                       {{{3
" ............................................................................

nmap  <Space>qa  <Plug>Ysurround
vmap  <Space>qa  <Plug>VSurround
nmap  <Space>qs  <Plug>Csurround
nmap  <Space>qd  <Plug>Dsurround

"                            <Space>s - SEARCH                            {{{3
" ............................................................................

nnoremap  <expr>  <Space>sg  ':Unite -start-insert ' . (&grepprg == 'grep' ? 'vimgrep' : 'grep') . '<CR>'
nnoremap          <Space>sl  :Unite -start-insert line<CR>

"                            <Space>t - TOGGLE                            {{{3
" ............................................................................

nnoremap          <Space>tc  :let &colorcolumn = ((&cc == '') ? virtcol('.') : '')<CR>
nnoremap          <Space>th  :ColorToggle<CR>
nnoremap  <expr>  <Space>tm  ':set guioptions' . (&guioptions =~ 'm' ? '-' : '+') . '=m<CR>'
nnoremap          <Space>tn  :set number!<CR>
nnoremap          <Space>tr  :set relativenumber!<CR>
nnoremap          <Space>ts  :call eight#syncwin#call()<CR>
nnoremap  <expr>  <Space>tv  ':set virtualedit=' . (&virtualedit == 'all' ? 'onemore' : 'all'). '<CR>'
nnoremap          <Space>tw  :set wrap!<CR>

"                    <Space>w - WINDOW/TAB MANAGEMENT                     {{{3
" ............................................................................

nnoremap  <Space>ws   :ChooseWinSwapStay<CR>
nnoremap  <Space>wtt  :tabnew<CR>
nnoremap  <Space>wtq  :tabclose<CR>

"                      <Space>x - TEXT MODIFICATION                       {{{3
" ............................................................................

nnoremap  <Space>x0   :silent call eight#contact#call()<CR><CR>
nnoremap  <Space>x1   :silent call EightHeader(&tw, 'center', 0, '=', ' {' . '{{1', '')<CR><CR>
nnoremap  <Space>x2   :silent call EightHeader(&tw, 'center', 0, '_', ' {' . '{{2', '')<CR><CR>
nnoremap  <Space>x3   :silent call EightHeader(&tw, 'center', 0, '.', ' {' . '{{3', '')<CR><CR>
nnoremap  <Space>x9   :silent call EightHeader(0 - (&tw / 2), 'left', 1, ['__', '_', ''], '', '\= " " . s:str . " "')<CR><CR>

nmap      <Space>xcc  <Plug>(EasyAlign)ip
nmap      <Space>xc   <Plug>(EasyAlign)
vmap      <Space>xc   <Plug>(EasyAlign)

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
autocmd  vimrc  BufNewFile  *.txt  set fileformat=dos
autocmd  vimrc  BufRead     *.txt  if ! getfsize(expand('%')) | set fileformat=dos | endif

" A fajlok ellenorzese, hogy nem valtoztak-e meg egy kulso program altal.
" autocmd  vimrc  BufEnter  *  checktime

" :help fo-table. Azert autocmd, mert minden fajltipus felulirja a
" formatoptions-t a sajat beallitasaival, igy ez elveszne, ha csak mezei set
" lenne.
autocmd  vimrc  FileType  *    setlocal formatoptions+=con formatoptions-=l
if v:version >= 704
  autocmd  vimrc  FileType  *  setlocal formatoptions+=j
endif

" __ COMPLETION _________________________

" Fajltipus alapjan allitsa be az omni-completion-t.
if filereadable($VIMRUNTIME . '/autoload/syntaxcomplete.vim')
  autocmd  vimrc  FileType  *  if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
endif

" __ MEGJELENES _________________________

" Csak az aktualis ablakban jelenjen meg a relativnumber, a tobbiben abszolut
" legyen.
" autocmd WinEnter,FocusGained * setlocal number relativenumber
" autocmd WinLeave,FocusLost   * setlocal number norelativenumber

" Ha atmeretezzuk a vim ablakat, akkor az ablakokat is meretezze ujra.
autocmd  vimrc  VimResized  *  wincmd =

" Sorok szamozasanak es a specialis karakterek mutatasanak kikapcsolasa a man,
" quickfix es pydoc buffereknel.
autocmd  vimrc  FileType  man,qf   setlocal nonumber nolist
autocmd  vimrc  BufNew    __doc__  setlocal nonumber nolist

" Make hiba eseten nyissa meg a hibaablakot.
autocmd  vimrc  QuickFixCmdPost  *  botright cwindow
