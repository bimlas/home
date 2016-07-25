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

" Windows-on nincs a runtimepathban.
set runtimepath+=$HOME/.vim

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

"                          WIN / NIX BEALLITASOK                          {{{1
" ============================================================================

if has('win32')

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
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_logipat           = 1

" __ NETRW ______________________________                                 {{{2

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
                                                                        " }}}2

" On Windows there is no different filename for Py2 and Py3.
let g:has_python = has('python') || has('python3')
let g:has_ruby   = has('ruby')

let g:pm_dir   = $HOME . '/.vim/vim-plug'
let g:pm_install_dir = $HOME . '/.vim/bundle'

if ! (g:has_ruby || g:has_python)
  let g:plug_threads = 1
endif

" Create supply functions, variables.
function! PluginEnabled(bundle)
  return 0
endfunction

if isdirectory(g:pm_dir)
  exe 'source ' . g:pm_dir . '/plug.vim'

  " Create supply function to check if plugin is installed.
 function! PluginEnabled(plugin)
   return has_key(g:plugs, a:plugin)
 endfunction

  call plug#begin(g:pm_install_dir)

  " SHOUGO/VIMPROC.VIM                                                    {{{2
  " nehany plugin hasznalja - windows dll:
  " https://github.com/Shougo/vimproc.vim/downloads
  if executable(&makeprg)
    Plug 'shougo/vimproc.vim', {
    \ 'do' : &makeprg . (has('win32') ? ' -f make_mingw64.mak' : ''),
    \ }
  endif

  " JUNEGUNN/VIM-PSEUDOCL                                                 {{{2
  " used by some (Junegunn) plugins
  Plug 'junegunn/vim-pseudocl'
                                                                        " }}}2

  " .. SAJAT ..............................

  " BIMBALASZLO/DOTVIM                                                    {{{2
  " sajat ~/.vim
  Plug 'bimbalaszlo/dotvim'

  " BIMBALASZLO/VIM-EIGHTHEADER                                           {{{2
  " (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...
  Plug 'bimbalaszlo/vim-eightheader'

    let g:EightHeader_comment   = 'call tcomment#Comment(line("."), line("."), "CL")'
    let g:EightHeader_uncomment = 'call tcomment#Comment(line("."), line("."), "UL")'

  " BIMBALASZLO/VIM-EIGHTSTAT                                             {{{2
  " statusline helper functions
  " WIP
  " Plug 'bimbalaszlo/vim-eightstat'

  " BIMBALASZLO/VIM-NUMUTILS                                              {{{2
  " szamertekek modositasa regex alapjan
  if !exists('g:vimrc_minimal_plugins')
    Plug 'bimbalaszlo/vim-numutils'
  endif
                                                                        " }}}2

  " .. MEGJELENES .........................
  " http://bytefluent.com/vivify/
  " http://cocopon.me/app/vim-color-gallery/
  " http://vimcolors.com/

  " MORHETZ/GRUVBOX                                                       {{{2
  " retro colorscheme (light & dark)
  Plug 'morhetz/gruvbox'

    let g:gruvbox_invert_selection = 0

  " JONATHANFILIP/VIM-LUCIUS                                              {{{2
  " light and dark colorscheme
  Plug 'jonathanfilip/vim-lucius'

  " TWEEKMONSTER/LOCAL-INDENT.VIM                                         {{{2
  " display a guide for the current line's indent level
  " Plug 'tweekmonster/local-indent.vim'
  "
  "   let localindentguide_blacklist = ['help']
  "   autocmd vimrc BufWinEnter * if index(localindentguide_blacklist, &filetype) < 0 | LocalIndentGuide +hl | endif

  " LILYDJWG/COLORIZER                                                    {{{2
  " show RGB colors with :ColorHighlight or :ColorToggle
  if !exists('g:vimrc_minimal_plugins')
    Plug 'lilydjwg/colorizer'
  endif

    let g:colorizer_startup  = 0
    let g:colorizer_nomap    = 1
    let g:colorizer_maxlines = 3000
                                                                        " }}}2

  " .. KURZOR MOZGATASA ...................

  " MATCHIT.ZIP                                                           {{{2
  " paros jelek kozti ugralas
  if !exists('g:vimrc_minimal_plugins')
    Plug 'matchit.zip'
  endif

    " FIGYELEM: nagyon belassulhat tole az egesz vim. Ezek sem segitenek:
    " let g:matchparen_timeout = 5
    " let g:matchparen_insert_timeout = 5

  " JUSTINMK/VIM-SNEAK {{{2
  " easily jump to anywhere on the visible part of the buffer
  Plug 'justinmk/vim-sneak'

    " Use as an alternative to EasyMotion
    let g:sneak#streak        = 1
    " Press <Tab> to focus on the next set of matches.
    let g:sneak#target_labels = 'asdfghjkluiopqwertzASDFGHJKLUIOPQWERTZ'

  " T9MD/VIM-CHOOSEWIN                                                    {{{2
  " easymotion az ablakokon is
  if !exists('g:vimrc_minimal_plugins')
    Plug 't9md/vim-choosewin'
  endif

    let g:choosewin_label_align        = 'left'
    let g:choosewin_label_padding      = 1
    " let g:choosewin_overlay_enable     = 1
    " let g:choosewin_statusline_replace = 0
    " let g:choosewin_tabline_replace    = 0

    let g:choosewin_label              = 'ASDFHJKL'
    let g:choosewin_keymap             = {"\<C-W>": 'previous'}
                                                                        " }}}2

  " .. TEXTOBJ-USER .......................

  " KANA/VIM-TEXTOBJ-USER                                                 {{{2
  " sajat text-object
  Plug 'kana/vim-textobj-user'

  " KANA/VIM-TEXTOBJ-ENTIRE                                               {{{2
  " ae: az egesz buffer, ie: az elejen es vegen levo ures sorok nelkul
  Plug 'kana/vim-textobj-entire'

  " GLTS/VIM-TEXTOBJ-COMMENT                                              {{{2
  " ic/ac: block of comment, aC: include leading/trailing blank lines
  Plug 'glts/vim-textobj-comment'

  " SAAGUERO/VIM-TEXTOBJ-PASTEDTEXT                                       {{{2
  " gb for pasted text
  Plug 'saaguero/vim-textobj-pastedtext'

  " THINCA/VIM-TEXTOBJ-BETWEEN                                            {{{2
  " ifX/afX for text surrounded by X
  Plug 'thinca/vim-textobj-between'

  " SGUR/VIM-TEXTOBJ-PARAMETER                                            {{{2
  " if,/af, for function parameters
  Plug 'sgur/vim-textobj-parameter'

  " JULIAN/VIM-TEXTOBJ-VARIABLE-SEGMENT                                   {{{2
  " _privat*e_thing -> civone -> _one_thing
  " eggsAn*dCheese  -> dav    -> eggsCheese
  " foo_ba*r_baz    -> dav    -> foo_baz
  " _privat*e_thing -> dav    -> _thing
  " _g*etJiggyYo    -> dav    -> _jiggyYo
  Plug 'julian/vim-textobj-variable-segment'

  " TEK/VIM-TEXTOBJ-RUBY                                                  {{{2
  " ir/ar: block, if/af: method, ic/ac: class
  Plug 'tek/vim-textobj-ruby'

    let g:textobj_ruby_no_mappings = 1

    " A comment-eket ne vegye bele.
    let g:textobj_ruby_inclusive = 0

  " BPS/VIM-TEXTOBJ-PYTHON                                                {{{2
  " if/af: function, ic/ac: class
  Plug 'bps/vim-textobj-python'

    let g:textobj_python_no_default_key_mappings = 1
                                                                        " }}}2

  " .. OPERATOR-USER ......................

  " KANA/VIM-OPERATOR-USER                                                {{{2
  " user defined operators
  if !exists('g:vimrc_minimal_plugins')
    Plug 'kana/vim-operator-user'
  endif
                                                                        " }}}2

  " .. SZOVEG KERESESE/MODOSITASA .........

  " THINCA/VIM-VISUALSTAR                                                 {{{2
  " kijelolt szoveg keresese * gombbal
  if !exists('g:vimrc_minimal_plugins')
    Plug 'thinca/vim-visualstar'
  endif

  " MACHAKANN/VIM-SANDWICH                                                {{{2
  " paros jelek gyors cserelese/torlese
  if !exists('g:vimrc_minimal_plugins')
    Plug 'machakann/vim-sandwich'
  endif

    let g:sandwich_no_default_key_mappings          = 1
    let g:operator_sandwich_no_default_key_mappings = 1
    let g:textobj_sandwich_no_default_key_mappings  = 1

  " TOMMCDO/VIM-EXCHANGE                                                  {{{2
  " cx: exchange text-objects or selected text with each other
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tommcdo/vim-exchange'
  endif

  " TPOPE/VIM-ABOLISH                                                     {{{2
  " intelligens substitute
  "   :%Subvert/facilit{y,ies}/building{,s}/g
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tpope/vim-abolish'
  endif

  " BIMBALASZLO/VIM-TEXTCONV                                              {{{2
  " easily apply text conversions
  if !exists('g:vimrc_minimal_plugins')
    Plug 'bimbalaszlo/vim-textconv'
  endif

  " JUNEGUNN/VIM-EASY-ALIGN                                               {{{2
  " szoveg igazitasa nagyon intelligens modon, regex kifejezesekkel
  if !exists('g:vimrc_minimal_plugins')
    Plug 'junegunn/vim-easy-align'
  endif

    " A | az asciidoctor-nak megfelelo formazasokat is felismeri, az
    " 'ignore_unmatched' miatt a leghosszabb sor vege utan fog kerulni a pattern,
    " fuggetlenul attol, hogy abban szerepelt-e.
    let g:easy_align_delimiters = {
    \ '|': {'pattern': '\(\(^\|\s\)\@<=\(\d\+\*\)\?\(\(\d\+\|\.\d\+\|\d\+\.\d\+\)+\)\?\([\^<>]\|\.[\^<>]\|[\^<>]\.[\^<>]\)\?[a-z]\?\)\?|', 'filter': 'v/^|=\+$/'},
    \ 't': {'pattern': '\t'},
    \ '\': {'pattern': '\\$', 'stick_to_left': 0, 'ignore_unmatched': 0},
    \ '<': {'pattern': '<<$', 'stick_to_left': 0, 'ignore_unmatched': 0},
    \ '+': {'pattern': ' +$', 'stick_to_left': 0, 'filter': 'v/^+$/', 'ignore_unmatched': 0},
    \ }

  " STEFANDTW/QUICKFIX-REFLECTOR.VIM                                      {{{2
  " quickfix-en keresztul a fajlok sorainak szerkesztese (:copen, ha nem lehet
  " szerkeszteni a quickfix-et)
  if !exists('g:vimrc_minimal_plugins')
    Plug 'stefandtw/quickfix-reflector.vim'
  endif

    " Ne mentse automatikusan a megvaltoztatott fajlokat.
    let g:qf_write_changes = 0
                                                                        " }}}2

  " .. FAJLOK/BUFFEREK/STB. BONGESZESE ....

  " SHOUGO/UNITE.VIM                                                      {{{2
  " fajlok/tag-ok/stb. gyors keresese - a lehetosegekert lasd :Unite
  if !exists('g:vimrc_minimal_plugins')
    Plug 'shougo/unite.vim'
    autocmd vimrc VimEnter * call PostUnite()
  endif

    function! PostUnite()
      call unite#custom#profile('default', 'context', {
      \ 'prompt_direction': 'top',
      \ 'direction':        'botright',
      \ 'cursor_line_time': '0.0',
      \ 'sync':             1,
      \ })
    endfunction

    " Jo lenne, de pl. a ~/ nem visz el a $HOME konyvtarba.
    " autocmd vimrc VimEnter * call unite#filters#matcher_default#use(['matcher_regexp'])

    let g:unite_source_history_yank_enable  = 1
    " let g:unite_source_tag_show_location = 0
    let g:unite_source_tag_max_fname_length = 70
    let g:unite_enable_auto_select          = 0
    let g:unite_source_buffer_time_format   = ''

    " Platinum Searcher
    let g:unite_source_rec_async_command  = ['pt', '--hidden', '--follow', '--nocolor', '--nogroup', '--files-with-matches', '']
    let g:unite_source_grep_command       = 'pt'
    let g:unite_source_grep_default_opts  = '--hidden --nocolor --nogroup --smart-case -e --depth 0'
    let g:unite_source_grep_recursive_opt = '--depth 25'
    let g:unite_source_grep_encoding      = 'utf-8'

  " SHOUGO/UNITE-OUTLINE                                                  {{{2
  " tagbar-szeru, de neha jobb
  if !exists('g:vimrc_minimal_plugins')
    Plug 'shougo/unite-outline'
  endif

  " TSUKKEE/UNITE-TAG                                                     {{{2
  " unite interface to browse tags
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tsukkee/unite-tag'
  endif

  " SHOUGO/VIMFILER.VIM                                                   {{{2
  " directory browser
  if !exists('g:vimrc_minimal_plugins')
    Plug 'shougo/vimfiler.vim'
  endif
                                                                        " }}}2

  " .. EGYEB HASZNOSSAGOK .................

  " HECAL3/VIM-LEADER-GUIDE                                               {{{2
  " works like Emacs' Guide-Key if mistyping normal mode command
  if !exists('g:vimrc_minimal_plugins')
    Plug 'hecal3/vim-leader-guide'
  endif

  " ANDREWRADEV/LINEDIFF.VIM                                              {{{2
  " fajl reszeinek osszehasonlitasa
  " :Linediff kijeloles utan
  if !exists('g:vimrc_minimal_plugins')
    Plug 'andrewradev/linediff.vim'
  endif

  " TPOPE/VIM-REPEAT                                                      {{{2
  " repeat (.) plugin-okon is
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tpope/vim-repeat'
  endif

  " HENRIK/VIM-QARGS                                                      {{{2
  " execute commands on files in quickfix (`:Qdo`) and use them as args
  " (`:Qargs`), for example `:Qdo %Subvert/Foo/Bar`
  Plug 'henrik/vim-qargs'

  " TYRU/OPEN-BROWSER.VIM                                                 {{{2
  " netrw gx helyett
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tyru/open-browser.vim'
  endif

  " TPOPE/VIM-SCRIPTEASE                                                  {{{2
  " :PP
  "   Pretty print.  With no argument, acts as a REPL.
  " :Runtime
  "   Reload runtime files.  Like `:runtime!`, but it unlets any include
  "   guards first.
  " :Disarm
  "   Remove a runtime file's maps, commands, and autocommands, effectively
  "   disabling it.
  " :Scriptnames
  "   Load `:scriptnames` into the quickfix list.
  " :Verbose
  "   Capture the output of a `:verbose` invocation into the preview window.
  " :Time
  "   Measure how long a command takes.
  " :Breakadd
  "   Like its lowercase cousin, but makes it much easier to set breakpoints
  "   inside functions.  Also :Breakdel.
  " :Vedit
  "   Edit a file relative the runtime path. For example, `:Vedit
  "   plugin/scriptease.vim`. Also, `:Vsplit`, `:Vtabedit`, etc.
  "   Extracted from [pathogen.vim](https://github.com/tpope/vim-pathogen).
  " K
  "   Look up the `:help` for the VimL construct under the cursor.
  " zS
  "   Show the active syntax highlighting groups under the cursor.
  " g!
  "   Eval a motion or selection as VimL and replace it with the result.
  "   This is handy for doing math, even outside of VimL.  It's so handy, in fact,
  "   that it probably deserves its own plugin.
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tpope/vim-scriptease'
  endif
                                                                        " }}}2

  " .. DEBUG / BENCHMARK ..................

  "                               CHEATSHEET                               {{{
  "
  " Analyse startuptime:
  "   $ vim --startuptime times.txt
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
  " To output :verbose to a file:
  "   set verbosefile=filename.txt
  "                                                                        }}}

  " MATTN/BENCHVIMRC-VIM                                                  {{{2
  " :BenchVimrc
  if !exists('g:vimrc_minimal_plugins')
    Plug 'mattn/benchvimrc-vim'
  endif

  " THINCA/VIM-THEMIS                                                     {{{2
  " a testing framework for Vim script
  if !exists('g:vimrc_minimal_plugins')
    Plug 'thinca/vim-themis'
  endif

                                                                        " }}}2

  " .. PROGRAMOZAS ........................

  " TOMTOM/TCOMMENT_VIM                                                   {{{2
  " szovegreszek kommentelese
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tomtom/tcomment_vim'
  endif

    let g:tcommentMaps = 0

  " POWERMAN/VIM-PLUGIN-VIEWDOC                                           {{{2
  " bongeszheto help tobb nyelvhez (a <CR> megnyitja a kurzor alatti objektum
  " help-jet)
  if !exists('g:vimrc_minimal_plugins')
    Plug 'powerman/vim-plugin-viewdoc'
  endif

    " A `:help` parancsot ne cserelje le.
    let g:no_viewdoc_abbrev = 1

    " Open doc in split.
    let g:viewdoc_open = 'new'

    " Just press `N` after in the doc to search for the word.
    let g:viewdoc_copy_to_search_reg = 1

  " KABBAMINE/ZEAVIM.VIM                                                  {{{2
  " talan a legnormalisabb referencia-bongeszo
  " $ install zeal @ http://zealdocs.org/
  if !exists('g:vimrc_minimal_plugins')
    Plug 'kabbamine/zeavim.vim'
    autocmd vimrc FileType ruby Docset ruby 2
  endif

    let g:zv_disable_mapping = 1

    if isdirectory('c:/app/zeal/')
      let g:zv_zeal_executable = 'c:/app/zeal/zeal.exe'
    endif

  " SCROOLOOSE/SYNTASTIC                                                  {{{2
  " syntax checker
  if !exists('g:vimrc_minimal_plugins')
    Plug 'scrooloose/syntastic'
  endif

    " Statusline indikator formaja.
    let g:syntastic_stl_format = ' %W{!W%fw}%E{!E%fe} '

    " Irja ki, hogy melyik checker-tol szarmazik a figyelmeztetes.
    let g:syntastic_aggregate_errors = 1

    " C

    let g:syntastic_c_checkers = ['gcc', 'splint']

    " PYTHON

    let g:syntastic_python_checkers = ['pylint', 'flake8']

    " Hibak figyelmen kivul hagyasa.
    " -d line-too-long
    " -d bad-indentation
    " -d bad-whitespace
    let g:syntastic_python_pylint_args           = '-d line-too-long -d bad-whitespace'
    " let g:syntastic_python_flake8_quiet_messages = { 'type' : 'style' }
    " E221  multiple spaces before operator
    " E241  multiple spaces after ':'
    " E302  expected 2 blank lines, found 1
    " E501  line too long
    let g:syntastic_python_flake8_args           = '--ignore=E221,E241,E302,E501'

    " RUBY

    " let g:syntastic_ruby_checkers = ['mri', 'rubocop']

  " CLASSTREE                                                             {{{2
  " CTree Class: show class hierarchy for class
  " requires `ctags --fields=+i`
  " $ install ctags
  if !exists('g:vimrc_minimal_plugins')
    Plug 'classtree'
  endif

  " GTAGS.VIM                                                             {{{2
  " gnu global
  " $ pip install pygments
  " $ cd PROJECT_ROOT
  " $ gtags --gtagslabel=pygments
  " Innentol mukodik a dolog.
  "
  " Hogy ne kelljen mindig megadni a gtagslabel erteket, a GTAGSLABEL
  " kornyezeti valtozoban is beallithatod.
  "
  " Windows verzio: http://adoxa.altervista.org/global/
  " Masold be a share/gtags/gtags.conf fajlt a ~/ konyvtarba.
  if !exists('g:vimrc_minimal_plugins')
    Plug 'gtags.vim'
  endif

  " THINCA/VIM-QUICKRUN                                                   {{{2
  " buffer, vagy kijelolt kod futtatasa
  if !exists('g:vimrc_minimal_plugins')
    Plug 'thinca/vim-quickrun'
  endif

    let g:quickrun_no_default_key_mappings = 1
    " \     'hook/output_encode/encoding': 'default',
    let g:quickrun_config = {
    \  '_':
    \  {
    \    'outputter':                     'multi',
    \    'outputter/multi/targets':       ['buffer', 'quickfix'],
    \    'outputter/buffer/running_mark': '... RUNNING ...',
    \    'runner':                        'vimproc',
    \    'hook/cd/directory':             '%S:p:h',
    \    'hook/shebang/enable':           has('win32') ? 0 : 1,
    \  },
    \  'asciidoc':
    \  {
    \    'command':   'asciidoctor',
    \    'cmdopt':    '-o -',
    \    'outputter': 'browser'
    \  },
    \  'text':
    \  {
    \    'command':   'asciidoctor',
    \    'cmdopt':    '-o -',
    \    'outputter': 'browser'
    \  },
    \  'vimspec' :
    \  {
    \   'command' : g:pm_install_dir . '/vim-themis/bin/themis',
    \   'cmdopt'  : '--runtimepath ".."',
    \   'exec'    : '%c %o %s:p'
    \  },
    \  'rubyCustom':
    \  {
    \    'command': 'irb'
    \  },
    \  'ruby.rspec':
    \  {
    \    'command':              'rspec',
    \    'cmdopt':               '-f d',
    \    'hook/unittest/enable': 1
    \  },
    \  'ruby.minitest':
    \  {
    \    'command':              'ruby',
    \    'hook/unittest/enable': 1
    \  },
    \  'php.unit':
    \  {
    \    'command':              'testrunner',
    \    'cmdopt':               'phpunit',
    \    'hook/unittest/enable': 1
    \  },
    \  'python.unit':
    \  {
    \    'command':              'nosetests',
    \    'cmdopt':               '-v -s',
    \    'hook/unittest/enable': 1
    \  },
    \  'python.pytest':
    \  {
    \    'command':              'py.test',
    \    'cmdopt':               '-v',
    \    'hook/unittest/enable': 1
    \  }
    \}

    autocmd vimrc FileType quickrun if has('win32') | set fileformat=dos | endif

  " HEAVENSHELL/VIM-QUICKRUN-HOOK-UNITTEST                                {{{2
  " tesztek futtatasa kulon-kulon
  if !exists('g:vimrc_minimal_plugins')
    Plug 'heavenshell/vim-quickrun-hook-unittest'
  endif

    autocmd vimrc BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
    autocmd vimrc BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
    " autocmd vimrc BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
    autocmd vimrc BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
    autocmd vimrc BufWinEnter,BufNewFile *_test.rb setlocal filetype=ruby.minitest

    let g:quickrun_config['php.unit'] = { 'command': 'phpunit' }

  " JOONTY/VDEBUG                                                         {{{2
  " turns Vim into a real debugger
  "
  " PHP.INI
  " zend_extension=/path/to/xdebug.so
  " xdebug.idekey=xdebug
  " xdebug.remote_autostart=1
  " xdebug.remote_enable=on
  " xdebug.remote_handler=dbgp
  " xdebug.remote_host=localhost
  " xdebug.remote_port=9001
  Plug 'joonty/vdebug'

    " See the last message of https://github.com/joonty/vdebug/issues/78
    let g:vdebug_options= {
    \   "port" : 9001,
    \ }

  " DAVIDHALTER/JEDI-VIM                                                  {{{2
  " python irasat nagyban megkonnyito kiegeszitesek / sugok
  " $ pip install jedi
  if !exists('g:vimrc_minimal_plugins') && g:has_python
    Plug 'davidhalter/jedi-vim'
  endif

    " Ha ez nincs megadva, akkor utkozik a neocomplete-tal es automatikusan ki
    " akarja valasztani az elso elemet ha pontot irunk egy objektum utan.
    let g:jedi#auto_vim_configuration = 0

    " Bufferek hasznalata tab-ok helyett.
    let g:jedi#use_tabs_not_buffers = 0

    " Ne valassza ki az elso lehetoseget.
    let g:jedi#popup_select_first = 0

    " A pont beirasa utan ne jelenjen meg automatikusan.
    let g:jedi#popup_on_dot = 0

  " VIM-RUBY/VIM-RUBY                                                     {{{2
  " ruby motyok (pl. omni completion pontosabban mukodik)
  if !exists('g:vimrc_minimal_plugins') && g:has_ruby
    Plug 'vim-ruby/vim-ruby'
  endif

    " :help ft-ruby-omni
    let g:rubycomplete_buffer_loading    = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails             = 1
    let g:rubycomplete_load_gemfile      = 1
    let g:ruby_no_comment_fold           = 1
    let g:ruby_operators                 = 1

  " PPROVOST/VIM-PS1                                                      {{{2
  " PowerShell syntax
  Plug 'pprovost/vim-ps1'
                                                                        " }}}2

  " .. NEOCOMPLETE ........................

  " SHOUGO/NEOCOMPLETE.VIM                                                {{{2
  " automatic code completion
  " needs lua interface (:version +lua)
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    Plug 'shougo/neocomplete.vim'
  endif

    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_fuzzy_completion = 1

    " Disable automatic behaviour (it's slow on network drives).
    " map neocomplete#start_manual_complete()
    " let g:neocomplete#disable_auto_complete = 1

    " Wait before showing completions.
    let g:neocomplete#auto_complete_delay = 1000

    " Allways show completions independently from the time it takes.
    let g:neocomplete#skip_auto_completion_time = ''

    " Custom list of sources.
    if !exists('g:neocomplete#sources')
      let g:neocomplete#sources = {}
    endif
    let g:neocomplete#sources._ = ['omni', 'tag', 'file/include', 'syntax', 'vim', 'ultisnips']

    " Force omnicompletion on this filetype/pattern pairs.
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w\{2,}\|\h\w*::\w\{2,}'
    let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

  " SHOUGO/NEOINCLUDE.VIM                                                 {{{2
  " complete from included files too
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    Plug 'shougo/neoinclude.vim'
  endif

  " SHOUGO/NECO-SYNTAX                                                    {{{2
  " better syntax complete
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    Plug 'shougo/neco-syntax'
  endif

  " SHOUGO/NECO-VIM                                                       {{{2
  " better syntax complete
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    Plug 'shougo/neco-vim'
  endif

  " SIRVER/ULTISNIPS                                                      {{{2
  " template engine (see on GitHub: it's awesome!)
  " NOTE: it has a filetype autocommand which fails if the plugin is not
  " activated, so the trigger is `on_ft`.
  if !exists('g:vimrc_minimal_plugins') && g:has_python
    Plug 'sirver/ultisnips'
  endif

    let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

  " HONZA/VIM-SNIPPETS                                                    {{{2
  " templates
  if !exists('g:vimrc_minimal_plugins') && g:has_python
    Plug 'honza/vim-snippets'
  endif
                                                                        " }}}2

  " .. GIT ................................

  " TPOPE/VIM-GIT                                                         {{{2
  " supporting git stuff (ftplugin, syntax, etc.)
  " $ install git
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tpope/vim-git'
  endif

  " TPOPE/VIM-FUGITIVE                                                    {{{2
  " git integracio
  " $ install git
  if !exists('g:vimrc_minimal_plugins')
    Plug 'tpope/vim-fugitive'
  endif

  " GREGSEXTON/GITV                                                       {{{2
  " gitk a vim-en belul
  " $ install git
  if !exists('g:vimrc_minimal_plugins')
    Plug 'gregsexton/gitv'
  endif

    " A commit uzeneteket roviditse le annyira, hogy minden info latszodjon.
    let g:Gitv_TruncateCommitSubjects = 1

    " Control key-eket ne map-oljon.
    let g:Gitv_DoNotMapCtrlKey = 1

  " AIRBLADE/VIM-GITGUTTER                                              " {{{2
  " show git status of lines on the sign column
  " $ install git
  if !exists('g:vimrc_minimal_plugins')
    Plug 'airblade/vim-gitgutter'
  endif

    let g:gitgutter_map_keys = 0

    " Update only on file open/write
    let g:gitgutter_realtime = 0
    let g:gitgutter_eager = 0
    let g:gitgutter_async = 0

    " Needs if grep does not support color.
    if has('win32')
      let g:gitgutter_grep_command = 'grep -e'
    endif
                                                                        " }}}2
  call plug#end()
else
  autocmd vimrc VimEnter * echomsg 'Run :InstallPluginManager'
endif

"                         INSTALL PLUGIN MANAGER                          {{{1
" ============================================================================

command!  InstallPluginManager  call InstallPluginManager()
function! InstallPluginManager()
  let pm_repo = 'https://github.com/junegunn/vim-plug'
  let path = $HOME . '/.vim/vim-plug'

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

  echo 'Cloning plugin manager...'
  let msg = system('git clone --depth 1 "' . pm_repo . '" "' . path . '"')
  if msg =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . pm_repo . ' to ' . path . ':' | echomsg msg | echohl None
    return
  endif

  echo 'Plugin manager installed. Please restart Vim and install plugins.'
  return
endfunction

"                              ALAPVETO MUKODES                           {{{1
" ============================================================================

" Disable GUI menus - this flag (M) have to be in here (in the .vimrc, before
" `filetye syntax on`), not in .gvimrc.
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

"                                   SZINEK                                {{{1
" ============================================================================

"                               ALAPERTEKEK                               {{{2
" ____________________________________________________________________________

" Statusline szinei.
autocmd  vimrc  ColorScheme  *
\ highlight! link StatFilename   DiffText   |
\ highlight! link StatFileformat DiffAdd    |
\ highlight! link StatInfo       DiffChange |
\ highlight! link StatWarning    Error

" Allways display comments with italic fonts.
autocmd  vimrc  ColorScheme  *
\ highlight! Comment term=italic      cterm=italic      gui=italic      |
\ highlight! Folded  term=bold,italic cterm=bold,italic gui=bold,italic

" More visible linebreak, whitespace and other special characters.
autocmd vimrc ColorScheme * highlight! NonText term=bold ctermfg=9 gui=bold guifg=#dc322f
autocmd vimrc ColorScheme * highlight! link SpecialKey NonText

"                                 GRUVBOX                                 {{{2
" ____________________________________________________________________________

autocmd vimrc ColorScheme *
\ highlight! link StatFilename   Identifier |
\ highlight! link StatFileformat Title      |
\ highlight! link StatInfo       Question   |
\ highlight! link StatWarning    WarningMsg

"                                 DESERT                                  {{{2
" ____________________________________________________________________________

autocmd vimrc ColorScheme desert set background=dark

" Statusline szinei.
autocmd  vimrc  ColorScheme  desert
\ highlight! link StatFilename   Directory  |
\ highlight! link StatFileformat Identifier |
\ highlight! link StatInfo       ModeMsg    |
\ highlight! link StatWarning    Error

" Nem tetszenek a popupmenu szinei.
autocmd  vimrc  ColorScheme  desert
\ highlight! Pmenu      ctermbg=Black ctermfg=Gray  guibg=#FFFFCC guifg=DarkGray          |
\ highlight! PmenuSel   ctermbg=Black ctermfg=White guibg=#FFFFCC guifg=Black    gui=bold |
\ highlight! PmenuSbar  ctermbg=Black ctermfg=Black guibg=#FFFFCC guifg=#FFFFCC           |
\ highlight! PmenuThumb ctermbg=White ctermfg=White guibg=Black   guifg=Black

                                                                        " }}}2

" Ligh background at day, dark at night.
if has('gui_running')
  try
    set background=dark
    if strftime("%H") >= 7 && strftime("%H") <= 17
      set background=light
      colorscheme lucius
    else
      set background=dark
      colorscheme gruvbox
    endif
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
  endtry
else
  colorscheme desert
endif

"                               STATUSLINE                                {{{1
" ============================================================================

" Mindig mutassa a statusline-t.
set laststatus=2

let stat_argnr      = '%{argc() > 1 ? argidx()+1 . "/" . argc() : ""}'
let stat_filename   = '%w%t%r%m'
let stat_fileformat = '%{&binary ? "binary" : ((strlen(&fenc) ? &fenc : &enc) . (&bomb ? "-bom" : "") . " ") . &ff}'

let &statusline  = stat_argnr . ' '
let &statusline .= '%#StatFilename# ' . stat_filename . ' '
let &statusline .= '%#StatFileformat# ' . stat_fileformat . ' '
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

" A kurzor soranak kiemelese.
set cursorline

" Completion in the command line:
" - <Tab> expands string to the longest common part
" - Second <Tab> shows all match
" - Starting from the third will iterate on the list
set wildmode=longest,list,full

" Use only buffer's dir.
set path=.

" Mindig mutassa a tabokat (megnyitott fajlokat, nem a TAB karakteret).
if PluginEnabled('dotvim') | set showtabline=2 tabline=%!dotvim#shorttabline#call() | endif

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
set fileformats=unix,dos fileencodings=utf8,cp1250,default,utf-16le

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

" Platinum Searcher
let &grepprg = 'pt --nogroup --nocolor --column -e'

"                             SZINTAXIS KIEMELES                          {{{1
" ============================================================================

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

" Sajat foldheader.
if PluginEnabled('vim-eightheader')
\ | let &foldtext = "EightHeaderFolds(&tw, 'left', [ repeat('  ', v:foldlevel - 1), repeat(' ', v:foldlevel - 1) . '.', '' ], '', '')"
\ | endif

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

" Behaviour of insert-mode completion (omnicomplete):
" menuone  Show popup menu even if there is only one item
" longest  Do not select the first element automatically
" preview  Open a preview window and show the selected item in it (press
"          <C-W>z to close)
set completeopt=menuone,longest,preview

" Fuggvenyek parametereit is mutatja kiegeszitesnel.
set showfulltag

"                              ABBREVATIONS                               {{{1
" ============================================================================

cabbrev args args %:p:h/
cabbrev saveas saveas %:p:h/

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
map é ;
map É ,
map ő [
map ú ]
map Ő {
map Ú }

" I don't using the ex-mode directly.
nnoremap Q <Nop>

" Show the full path.
nnoremap <C-G> 1<C-G>

" Update everything, not just the screen.
nnoremap <C-L> :nohlsearch <Bar> checktime <Bar> diffupdate <Bar> syntax sync fromstart <Bar> GitGutterAll<CR><C-L>

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

" Move to next/previous argument (:args).
nnoremap <C-E> :next<CR>
nnoremap <C-Y> :previous<CR>

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

" Korabban masolt szoveg beillesztese.
nnoremap <Leader>p :Unite history/yank<CR>

" Az ablakkezelo vagolapjanak hasznalata.
" Hogy a <S-Insert> a sor vegen is normalisan mukodjon:
" set virtualedit=onemore
noremap  <C-Insert> "+y
cnoremap <C-Insert> <C-Y>
noremap  <S-Insert> "+P
imap     <S-Insert> <C-O><S-Insert>

" Kurzor alatti parancs sugojanak megnyitasa.
autocmd vimrc FileType man call ManMap()
function! ManMap()
  map   <buffer> K    <C-]>
  map   <buffer> <CR> <C-]>
endfunction

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

"                                  SNEAK                                  {{{3
" ............................................................................

if PluginEnabled('vim-sneak')
  nmap s <Plug>Sneak_s
  nmap S <Plug>Sneak_S
  xmap s <Plug>Sneak_s
  xmap S <Plug>Sneak_S
  omap s <Plug>Sneak_s
  omap S <Plug>Sneak_S
  nmap f <Plug>Sneak_f
  nmap F <Plug>Sneak_F
  xmap f <Plug>Sneak_f
  xmap F <Plug>Sneak_F
  omap f <Plug>Sneak_f
  omap F <Plug>Sneak_F
  nmap t <Plug>Sneak_t
  nmap T <Plug>Sneak_T
  xmap t <Plug>Sneak_t
  xmap T <Plug>Sneak_T
  omap t <Plug>Sneak_t
  omap T <Plug>Sneak_T
endif

"                                CHOOSEWIN                                {{{3
" ............................................................................

nmap <expr>     <Plug>(mychoosewin) (winnr('$') > 2) ? '<Plug>(choosewin)' : '<C-W>w'
nmap <C-W><C-W> <Plug>(mychoosewin)

"                               OPENBROWSER                               {{{3
" ............................................................................

" Url megnyitasa a bongeszoben, vagy google a kurzor alatti szora.
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"                                  UNITE                                  {{{3
" ............................................................................

autocmd vimrc FileType unite call UniteMaps()
function! UniteMaps()
  nmap <buffer>       <Esc>      <Plug>(unite_exit)
  imap <buffer>       <C-K>      <Plug>(unite_insert_leave)
  map  <buffer>       <C-K>      <Plug>(unite_all_exit)
  nmap <buffer>       <C-N>      <Plug>(unite_loop_cursor_down)
  nmap <buffer>       <C-P>      <Plug>(unite_loop_cursor_up)
  nmap <buffer>       h          <Plug>(unite_delete_backward_path)
  nmap <buffer>       l          <CR>
  nmap <buffer>       S          <Plug>(unite_append_end)<C-U>
  map  <buffer>       w          <Plug>(unite_smart_preview)
  map  <buffer>       <C-Z>      <Plug>(unite_smart_preview)
  imap <buffer><expr> <C-Z>      unite#do_action('preview')
  map  <buffer><expr> <C-CR>     unite#do_action('start')
  imap <buffer><expr> <C-CR>     unite#do_action('start')
  nmap <buffer>       ~          <Plug>(unite_input_directory)<C-U>~/<CR><Plug>(unite_insert_leave)
  nmap <buffer>       \          <Plug>(unite_input_directory)<C-U>/<CR><Plug>(unite_insert_leave)
  nmap <buffer>       <C-W><C-W> <Plug>(mychoosewin)
endfunction

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

" Blokkok, vagy tablazatok kijelolese - a kurzor elotti blokkhatarolot veszi
" alapul. Minden olyan sort, ahol csak ugyanaz a karakter szerepel
" blokkhatarnak veszi. A tablazatokat a ^.=\+$ formaban keresi meg, mert lehet
" pl. |===, vagy ;=== is.
autocmd vimrc FileType asciidoc if PluginEnabled('vim-textobj-user') |
\ call textobj#user#plugin('adocblock', {
\   '-': {
\     'select-a-function': 'AdocBlockA',
\     'select-a':          'ab',
\     'select-i-function': 'AdocBlockI',
\     'select-i':          'ib',
\   }
\ })
\ | endif

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

" Show Emacs' Guide-Key like window when mistyping normal mode commands.
if PluginEnabled('vim-leader-guide')
  let g:guidekeys                    = {}
  let g:guidekeys['<Space>']         = {}
  let g:guidekeys['<Space>']['name'] = '<Space>'
  call leaderGuide#register_prefix_descriptions('', 'g:guidekeys')
  nnoremap <silent> <Space> :<c-u>LeaderGuide '<Space>'<CR>
  vnoremap <silent> <Space> :<c-u>LeaderGuideVisual '<Space>'<CR>
endif

noremap  <Space>?       :Unite mapping<CR>

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

noremap  <Space>y       "+y
noremap  <Space>p       "+p
noremap  <Space>P       "+P

nmap     <Space>c       <Plug>TComment_gc
vmap     <Space>c       <Plug>TComment_gc
nmap     <Space>cc      <Plug>TComment_gcc

"                         <Space>a - APPLICATIONS                         {{{3
" ............................................................................

" TODO: xterm cwd

" Simple calculator/evaulator.
nnoremap <Space>ac :PP<CR>
map      <Space>aC g!

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

nnoremap <Space>bb :Unite buffer<CR>
nnoremap <Space>bB :Unite buffer:!<CR>
nnoremap <Space>bc :Unite -no-quit -keep-focus change<CR>
nnoremap <Space>bd :bdelete<CR>
nnoremap <Space>bD :bdelete!<CR>

"                             <Space>d - DIFF                             {{{3
" ............................................................................

nnoremap <Space>dn ]c
nnoremap <Space>dp [c
nnoremap <Space>dt :diffthis<CR>
vnoremap <Space>dt :Linediff<CR>
nnoremap <Space>do :bufdo diffoff!<CR>
nnoremap <Space>du :diffupdate<CR>

"                            <Space>f - FILES                             {{{3
" ............................................................................

" TODO: UniteWithBufferDir - ~ not goes to $HOME; Unite file:%:p:h not goes to ../
nnoremap <Space>F   :find<Space>
nnoremap <Space>fe  :VimFilerExplorer<CR>
nnoremap <Space>ff  :UniteWithBufferDir file file/new directory/new <CR>
nnoremap <Space>fF  :Unite file file/new directory/new<CR>
nnoremap <Space>fp  :UniteWithProjectDir -buffer-name=project_files -resume -start-insert file_rec/async file/new directory/new<CR>
nnoremap <Space>ft  :UniteWithBufferDir file file/new directory/new  -tab<CR>
nnoremap <Space>fvg :edit $MYGVIMRC<CR>
nnoremap <Space>fvv :edit $MYVIMRC<CR>

"                             <Space>g - GIT                              {{{3
" ............................................................................

nnoremap <Space>ga :Gcommit --amend<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gc :Gcommit<CR>
nnoremap <Space>gd :Gdiff<CR>
nmap     <Space>gD <Plug>GitGutterPreviewHunk
nnoremap <Space>gg :Ggrep! --ignore-case "" -- ":/"<Home><C-Right><C-Right><Right><Right>
nnoremap <Space>gl :Gitv!<CR>
nnoremap <Space>gL :Gitv<CR>
nnoremap <Space>gm :Gmerge<CR>
nnoremap <Space>gn :GitGutterNextHunk<CR>
nnoremap <Space>gp :GitGutterPrevHunk<CR>
nnoremap <Space>gr :Gread<CR>
nmap     <Space>gR <Plug>GitGutterUndoHunk
nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>gw :Gwrite<CR>
nmap     <Space>gW <Plug>GitGutterStageHunk

"                    <Space>m - MODE (FILETYPE) AWARE                     {{{3
" ............................................................................

map             <Space>mK <Plug>Zeavim
nnoremap        <Space>mg :noautocmd vimgrep //j %:p:h/**/*.%:e <Bar> copen<Home><C-Right><C-Right><Right><Right>
nnoremap        <Space>mo :Unite -start-insert outline<CR>
noremap         <Space>mr :QuickRun<CR>
noremap  <expr> <Space>mR ':QuickRun ' . &filetype . 'Custom<CR>'
nnoremap        <Space>mt :Unite -start-insert tag<CR>

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

autocmd vimrc FileType asciidoc vnoremap <Space>mq :AdocFormat<CR>$hD

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

nnoremap <Space>sg :noautocmd vimgrep //j %:p:h/** <Bar> copen<Home><C-Right><C-Right><Right><Right>
nnoremap <Space>sl :Unite -no-quit -keep-focus line<CR>

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
nnoremap <Space>ws  :ChooseWinSwapStay<CR>
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

" Set up omni-completion if not already set.
autocmd vimrc FileType * if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif

" Hybrid linenumbering.
if !exists('g:vimrc_minimal_plugins')
  autocmd vimrc BufWinEnter * set number relativenumber
endif

" Highlighting of cursorline helps to detect the cursor itself and the
" insert/normal mode.
autocmd vimrc WinEnter    * set cursorline
autocmd vimrc WinLeave    * set nocursorline
autocmd vimrc InsertEnter * set nocursorline
autocmd vimrc InsertLeave * set cursorline

" Splits has to be equal even if Vim itself resized.
autocmd vimrc VimResized * wincmd =

" Disable the fancy things for view-only buffers.
autocmd vimrc FileType man,qf  setlocal nonumber nolist
autocmd vimrc BufNew   __doc__ setlocal nonumber nolist   " pydoc buffer

" Disable folding in diffs.
autocmd vimrc FileType diff setlocal nofoldenable

" Auto-open quickfix window - quickfix-reflector needs nested autocommand.
autocmd vimrc QuickFixCmdPost * nested botright cwindow
