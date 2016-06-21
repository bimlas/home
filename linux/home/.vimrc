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

" NETRW                                                                   {{{2

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

let bundle_dir = $HOME . '/.vim/bundle'

" Create supply functions, variables.
function! BundleInstalled(bundle)
  return 0
endfunction
" On Windows there is no different filename for Py2 and Py3.
let g:has_python = (has('python') && executable('python')) || (has('python3') && executable('python3'))
let g:has_ruby   = has('ruby') && executable('ruby')
let g:has_git    = executable('git')

if isdirectory(bundle_dir . '/repos/github.com/shougo/dein.vim')
  exe 'set runtimepath+=' . bundle_dir . '/repos/github.com/shougo/dein.vim'

  " Create supply function to check if plugin is installed.
  function! BundleInstalled(bundle)
    silent return !dein#check_install([a:bundle])
  endfunction

  " Do shallow clones (faster and needs less disk space).
  let g:dein#types#git#clone_depth = 1

  call dein#begin(bundle_dir)

  " Forgot directly installed plugins before exiting.
  autocmd vimrc VimLeavePre * silent! call delete(bundle_dir . '/direct_install.vim')

  " Use `on_map` triggers only if You declared mappings for `<Plug>...`. For
  " example `'on_map': '<Plug>(visualstar'` will not load VisualStar, because
  " mapping `g*` to `<Plug>(visualstar-g*)` not exists yet, so trigger is not
  " activated.

  " SHOUGO/DEIN.VIM                                                       {{{2
  " plugin manager
  call dein#add('shougo/dein.vim')

  " SHOUGO/VIMPROC.VIM                                                    {{{2
  " nehany plugin hasznalja - windows dll:
  " https://github.com/Shougo/vimproc.vim/downloads
  if executable(&makeprg)
    call dein#add('shougo/vimproc.vim', {
    \ 'build' : &makeprg . (has('win32') ? ' -f make_mingw64.mak' : ''),
    \ })
  end
                                                                          " }}}2

  " .. SAJAT ..............................

  " BIMBALASZLO/DOTVIM                                                    {{{2
  " sajat ~/.vim
  call dein#add('bimbalaszlo/dotvim')

  " BIMBALASZLO/VIM-EIGHTHEADER                                           {{{2
  " (fold)header-ek letrehozasa, egyeni foldtext, tartalomjegyzek formazasa...
  call dein#add('bimbalaszlo/vim-eightheader')

    let g:EightHeader_comment   = 'call tcomment#Comment(line("."), line("."), "CL")'
    let g:EightHeader_uncomment = 'call tcomment#Comment(line("."), line("."), "UL")'

  " BIMBALASZLO/VIM-EIGHTSTAT                                             {{{2
  " statusline helper functions
  " WIP
  " call dein#add('bimbalaszlo/vim-eightstat')

  " BIMBALASZLO/VIM-NUMUTILS                                              {{{2
  " szamertekek modositasa regex alapjan
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('bimbalaszlo/vim-numutils')
  end
                                                                        " }}}2

  " .. MEGJELENES .........................
  " http://bytefluent.com/vivify/
  " http://cocopon.me/app/vim-color-gallery/
  " http://vimcolors.com/

  " ALTERCATION/VIM-COLORS-SOLARIZED                                      {{{2
  " szep, finom colorscheme (light es dark is)
  call dein#add('altercation/vim-colors-solarized')

  " TWEEKMONSTER/LOCAL-INDENT.VIM                                         {{{2
  " display a guide for the current line's indent level
  " call dein#add('tweekmonster/local-indent.vim')
  "
  "   let localindentguide_blacklist = ['help']
  "   autocmd vimrc BufWinEnter * if index(localindentguide_blacklist, &filetype) < 0 | LocalIndentGuide +hl | endif

  " LILYDJWG/COLORIZER                                                    {{{2
  " show RGB colors with :ColorHighlight or :ColorToggle
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('lilydjwg/colorizer')
  end

    let g:colorizer_startup  = 0
    let g:colorizer_nomap    = 1
    let g:colorizer_maxlines = 3000
                                                                        " }}}2

  " .. KURZOR MOZGATASA ...................

  " MATCHIT.ZIP                                                           {{{2
  " paros jelek kozti ugralas
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('matchit.zip')
  end

    " FIGYELEM: nagyon belassulhat tole az egesz vim. Ezek sem segitenek:
    " let g:matchparen_timeout = 5
    " let g:matchparen_insert_timeout = 5

  " JUSTINMK/VIM-SNEAK {{{2
  " easily jump to anywhere on the visible part of the buffer
  call dein#add('justinmk/vim-sneak')

    " Use as an alternative to EasyMotion
    let g:sneak#streak        = 1
    let g:sneak#streak_esc    = '\<C-K>'
    " Press <Tab> to focus on the next set of matches.
    let g:sneak#target_labels = 'asdfghjkluiopqwertzASDFGHJKLUIOPQWERTZ'

  " T9MD/VIM-CHOOSEWIN                                                    {{{2
  " easymotion az ablakokon is
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('t9md/vim-choosewin')
  end

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
  call dein#add('kana/vim-textobj-user')

  " KANA/VIM-TEXTOBJ-ENTIRE                                               {{{2
  " ae: az egesz buffer, ie: az elejen es vegen levo ures sorok nelkul
  call dein#add('kana/vim-textobj-entire')

  " GLTS/VIM-TEXTOBJ-COMMENT                                              {{{2
  " ic/ac: block of comment, aC: include leading/trailing blank lines
  call dein#add('glts/vim-textobj-comment')

  " SAAGUERO/VIM-TEXTOBJ-PASTEDTEXT                                       {{{2
  " gb for pasted text
  call dein#add('saaguero/vim-textobj-pastedtext')

  " THINCA/VIM-TEXTOBJ-BETWEEN                                            {{{2
  " ifX/afX for text surrounded by X
  call dein#add('thinca/vim-textobj-between')

  " SGUR/VIM-TEXTOBJ-PARAMETER                                            {{{2
  " if,/af, for function parameters
  call dein#add('sgur/vim-textobj-parameter')

  " JULIAN/VIM-TEXTOBJ-VARIABLE-SEGMENT                                   {{{2
  " _privat*e_thing -> civone -> _one_thing
  " eggsAn*dCheese  -> dav    -> eggsCheese
  " foo_ba*r_baz    -> dav    -> foo_baz
  " _privat*e_thing -> dav    -> _thing
  " _g*etJiggyYo    -> dav    -> _jiggyYo
  call dein#add('julian/vim-textobj-variable-segment')

  " TEK/VIM-TEXTOBJ-RUBY                                                  {{{2
  " ir/ar: block, if/af: method, ic/ac: class
  call dein#add('tek/vim-textobj-ruby')

    let g:textobj_ruby_no_mappings = 1

    " A comment-eket ne vegye bele.
    let g:textobj_ruby_inclusive = 0

  " BPS/VIM-TEXTOBJ-PYTHON                                                {{{2
  " if/af: function, ic/ac: class
  call dein#add('bps/vim-textobj-python')

    let g:textobj_python_no_default_key_mappings = 1
                                                                        " }}}2

  " .. OPERATOR-USER ......................

  " KANA/VIM-OPERATOR-USER                                                {{{2
  " user defined operators
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('kana/vim-operator-user')
  end
                                                                        " }}}2

  " .. SZOVEG KERESESE/MODOSITASA .........

  " THINCA/VIM-VISUALSTAR                                                 {{{2
  " kijelolt szoveg keresese * gombbal
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('thinca/vim-visualstar')
  end

  " MACHAKANN/VIM-SANDWICH                                                {{{2
  " paros jelek gyors cserelese/torlese
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('machakann/vim-sandwich')
  end

    let g:sandwich_no_default_key_mappings          = 1
    let g:operator_sandwich_no_default_key_mappings = 1
    let g:textobj_sandwich_no_default_key_mappings  = 1

  " TOMMCDO/VIM-EXCHANGE                                                  {{{2
  " cx: exchange text-objects or selected text with each other
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('tommcdo/vim-exchange')
  end

  " TPOPE/VIM-ABOLISH                                                     {{{2
  " intelligens substitute
  "   :%Subvert/facilit{y,ies}/building{,s}/g
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('tpope/vim-abolish')
  end

  " BIMBALASZLO/VIM-TEXTCONV                                              {{{2
  " easily apply text conversions
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('bimbalaszlo/vim-textconv')
  end

  " JUNEGUNN/VIM-EASY-ALIGN                                               {{{2
  " szoveg igazitasa nagyon intelligens modon, regex kifejezesekkel
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('junegunn/vim-easy-align')
  end

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
    call dein#add('stefandtw/quickfix-reflector.vim')
  end

    " Ne mentse automatikusan a megvaltoztatott fajlokat.
    let g:qf_write_changes = 0
                                                                        " }}}2

  " .. FAJLOK/BUFFEREK/STB. BONGESZESE ....

  " SHOUGO/UNITE.VIM                                                      {{{2
  " fajlok/tag-ok/stb. gyors keresese - a lehetosegekert lasd :Unite
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('shougo/unite.vim')
    autocmd vimrc VimEnter * call Dein_Unite()
  end

    function! Dein_Unite()
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
      let g:unite_source_rec_async_command  = ['pt', '--hidden', '--follow', '--nocolor', '--nogroup', '--files-with-matches', '']
      let g:unite_source_grep_command       = 'pt'
      let g:unite_source_grep_default_opts  = '--hidden --nocolor --nogroup --smart-case -e --depth 0'
      let g:unite_source_grep_recursive_opt = '--depth 25'
      let g:unite_source_grep_encoding      = 'utf-8'
    endif

  " SHOUGO/UNITE-OUTLINE                                                  {{{2
  " tagbar-szeru, de neha jobb
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('shougo/unite-outline')
  end

  " TSUKKEE/UNITE-TAG                                                     {{{2
  " unite interface to browse tags
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('tsukkee/unite-tag')
  end

  " SHOUGO/VIMFILER.VIM                                                   {{{2
  " directory browser
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('shougo/vimfiler.vim')
  end
                                                                        " }}}2

  " .. EGYEB HASZNOSSAGOK .................

  " LAMBDALISUE/VIM-DIFFA                                                 {{{2
  " auto diffupdate & diffoff + DiffOrig
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('lambdalisue/vim-diffa')
  end

  " ANDREWRADEV/LINEDIFF.VIM                                              {{{2
  " fajl reszeinek osszehasonlitasa
  " :Linediff kijeloles utan
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('andrewradev/linediff.vim')
  end

  " TPOPE/VIM-REPEAT                                                      {{{2
  " repeat (.) plugin-okon is
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('tpope/vim-repeat')
  end

  " HENRIK/VIM-QARGS                                                      {{{2
  " execute commands on files in quickfix (`:Qdo`) and use them as args
  " (`:Qargs`), for example `:Qdo %Subvert/Foo/Bar`
  call dein#add('henrik/vim-qargs')

  " TYRU/OPEN-BROWSER.VIM                                                 {{{2
  " netrw gx helyett
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('tyru/open-browser.vim')
  end

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
    call dein#add('tpope/vim-scriptease')
  end

  " MBBILL/UNDOTREE                                                       {{{2
  " graphical :undolist
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('mbbill/undotree')
  end

  " RHYSD/VIM-GRAMMAROUS                                                  {{{2
  " grammar check
  " see `:messages` if something went wrong
  " $ install java
  if !exists('g:vimrc_minimal_plugins') || !executable('java')
    call dein#add('rhysd/vim-grammarous')
  end
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
    call dein#add('mattn/benchvimrc-vim')
  end

  " THINCA/VIM-THEMIS                                                     {{{2
  " a testing framework for Vim script
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('thinca/vim-themis')
  end

                                                                        " }}}2

  " .. PROGRAMOZAS ........................

  " TOMTOM/TCOMMENT_VIM                                                   {{{2
  " szovegreszek kommentelese
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('tomtom/tcomment_vim')
  end

    let g:tcommentMaps = 0

  " POWERMAN/VIM-PLUGIN-VIEWDOC                                           {{{2
  " bongeszheto help tobb nyelvhez (a <CR> megnyitja a kurzor alatti objektum
  " help-jet)
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('powerman/vim-plugin-viewdoc')
  end

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
    call dein#add('kabbamine/zeavim.vim')
  end

    let g:zv_disable_mapping = 1

    if isdirectory('c:/app/zeal/')
      let g:zv_zeal_executable = 'c:/app/zeal/zeal.exe'
    endif

    autocmd vimrc FileType ruby Docset ruby 2

  " SCROOLOOSE/SYNTASTIC                                                  {{{2
  " syntax checker
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('scrooloose/syntastic')
  end

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
    call dein#add('classtree')
  end

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
    call dein#add('gtags.vim')
  end

  " THINCA/VIM-QUICKRUN                                                   {{{2
  " buffer, vagy kijelolt kod futtatasa
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('thinca/vim-quickrun')
  end

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
    \   'command' : g:bundle_dir . '/vim-themis/bin/themis',
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

    autocmd vimrc FileType quickrun if has('win32') | set fileformat=dos | end

  " HEAVENSHELL/VIM-QUICKRUN-HOOK-UNITTEST                                {{{2
  " tesztek futtatasa kulon-kulon
  if !exists('g:vimrc_minimal_plugins')
    call dein#add('heavenshell/vim-quickrun-hook-unittest')
  end

    autocmd vimrc BufWinEnter,BufNewFile *test.php setlocal filetype=php.unit
    autocmd vimrc BufWinEnter,BufNewFile test_*.py setlocal filetype=python.unit
    " autocmd vimrc BufWinEnter,BufNewFile test_*.py setlocal filetype=python.pytest
    autocmd vimrc BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec
    autocmd vimrc BufWinEnter,BufNewFile *_test.rb setlocal filetype=ruby.minitest

    let g:quickrun_config['php.unit'] = { 'command': 'phpunit' }

  " DAVIDHALTER/JEDI-VIM                                                  {{{2
  " python irasat nagyban megkonnyito kiegeszitesek / sugok
  " $ pip install jedi
  if !exists('g:vimrc_minimal_plugins') && g:has_python
    call dein#add('davidhalter/jedi-vim')
  end

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
    call dein#add('vim-ruby/vim-ruby')
  end

    " :help ft-ruby-omni
    let g:rubycomplete_buffer_loading    = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails             = 1
    let g:rubycomplete_load_gemfile      = 1
    let g:ruby_no_comment_fold           = 1
    let g:ruby_operators                 = 1

  " PPROVOST/VIM-PS1                                                      {{{2
  " PowerShell syntax
  call dein#add('pprovost/vim-ps1')
                                                                        " }}}2

  " .. NEOCOMPLETE ........................

  " SHOUGO/NEOCOMPLETE.VIM                                                {{{2
  " automatic code completion
  " needs lua interface (:version +lua)
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    call dein#add('shougo/neocomplete.vim')
  end

    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_fuzzy_completion = 1

    " Disable automatic behaviour (it's slow on network drives).
    " map neocomplete#start_manual_complete()
    " let g:neocomplete#disable_auto_complete = 1

    " Wait before showing completions.
    let g:neocomplete#enable_cursor_hold_i = 1
    let g:neocomplete#cursor_hold_i_time = 1000

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

  " SHOUGO/NEOINCLUDE.VIM                                                 {{{2
  " complete from included files too
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    call dein#add('shougo/neoinclude.vim')
  end

  " SHOUGO/NECO-SYNTAX                                                    {{{2
  " better syntax complete
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    call dein#add('shougo/neco-syntax')
  end

  " SHOUGO/NECO-VIM                                                       {{{2
  " better syntax complete
  if !exists('g:vimrc_minimal_plugins') && has('lua')
    call dein#add('shougo/neco-vim')
  end

  " SIRVER/ULTISNIPS                                                      {{{2
  " template engine (see on GitHub: it's awesome!)
  " NOTE: it has a filetype autocommand which fails if the plugin is not
  " activated, so the trigger is `on_ft`.
  if !exists('g:vimrc_minimal_plugins') && g:has_python
    call dein#add('sirver/ultisnips')
  end

    let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

  " HONZA/VIM-SNIPPETS                                                    {{{2
  " templates
  if !exists('g:vimrc_minimal_plugins') && g:has_python
    call dein#add('honza/vim-snippets')
  end
                                                                        " }}}2

  " .. GIT ................................

  " TPOPE/VIM-GIT                                                         {{{2
  " supporting git stuff (ftplugin, syntax, etc.)
  " $ install git
  if g:has_git
    call dein#add('tpope/vim-git')
  end

  " TPOPE/VIM-FUGITIVE                                                    {{{2
  " git integracio
  " $ install git
  if !exists('g:vimrc_minimal_plugins') && g:has_git
    call dein#add('tpope/vim-fugitive')
  end

  " GREGSEXTON/GITV                                                       {{{2
  " gitk a vim-en belul
  " $ install git
  if !exists('g:vimrc_minimal_plugins') && g:has_git
    call dein#add('gregsexton/gitv')
  end

    " A commit uzeneteket roviditse le annyira, hogy minden info latszodjon.
    let g:Gitv_TruncateCommitSubjects = 1

    " Control key-eket ne map-oljon.
    let g:Gitv_DoNotMapCtrlKey = 1

  " AIRBLADE/VIM-GITGUTTER                                              " {{{2
  " show git status of lines on the sign column
  " $ install git
  if !exists('g:vimrc_minimal_plugins') && g:has_git
    call dein#add('airblade/vim-gitgutter')
  end

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
  call dein#end()
else
  autocmd vimrc VimEnter * echomsg 'Run :InstallDein'
endif

"                               INSTALLDEIN                               {{{1
" ============================================================================
"
" Cloning Dein to ~/.vim/bundle/dein.vim

command!  InstallDein  call InstallDein()
function! InstallDein()
  let dein_repo = 'https://github.com/shougo/dein.vim'
  let path = substitute(g:bundle_dir . '/repos/github.com/shougo/dein.vim', '/', has('win32') ? '\\' : '/', 'g')

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

  echo 'Cloning Dein...'
  let msg = system('git clone --depth 1 "' . dein_repo . '" "' . path . '"')
  if msg =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . dein_repo . ' to ' . path . ':' | echomsg msg | echohl None
    return
  endif

  echo 'Dein installed. Please restart Vim and run :call dein#install()'
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
if has('syntax') && filereadable($VIMRUNTIME . '/syntax/syntax.vim')
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
\ highlight! link StatWarning    WarningMsg

" Allways display comments with italic fonts.
autocmd  vimrc  ColorScheme  *
\ highlight! Comment term=italic      cterm=italic      gui=italic      |
\ highlight! Folded  term=bold,italic cterm=bold,italic gui=bold,italic

"                                SOLARIZED                                {{{2
" ____________________________________________________________________________

let g:solarized_menu = 0

" A par nelkuli zarojelek kijelzese alig lathato.
autocmd vimrc ColorScheme solarized highlight! link Error ErrorMsg

" A soremeles karakterek is egybeolvadnak a szoveggel. Ez a highlight a high
" visibility beallitasokol van atmasolva.
autocmd vimrc ColorScheme solarized highlight! NonText term=bold ctermfg=9 gui=bold guifg=#dc322f

" A tab, whitespace, stb. szinei is ilyenek legyenek.
autocmd vimrc ColorScheme solarized highlight! link SpecialKey NonText

"                                 DESERT                                  {{{2
" ____________________________________________________________________________

autocmd vimrc ColorScheme desert set background=dark

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

" Nappal vilagos hatter, este sotet.
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

let stat_argnr      = '%{argc() > 1 ? argidx()+1 . "/" . argc() : ""}'
let stat_filename   = '%w%t%r%m'
let stat_fileformat = '%{&binary ? "binary" : ((strlen(&fenc) ? &fenc : &enc) . (&bomb ? "-bom" : "") . " ") . &ff}'

" BufNew not works on <C-W><C-N>, so it has to check the variable every time.
autocmd vimrc BufWinEnter * if ! exists('b:undotree_initial_seq') | let b:undotree_initial_seq = undotree()['seq_cur'] | endif
let stat_undofile = '%{undotree()["seq_cur"] < b:undotree_initial_seq ? " USING UNDOFILE " : ""}'

let &statusline  = stat_argnr . ' '
let &statusline .= '%#StatFilename# ' . stat_filename . ' '
let &statusline .= '%#StatFileformat# ' . stat_fileformat . ' '
let &statusline .= '%#StatWarning#' . stat_undofile . ''
let &statusline .= BundleInstalled('syntastic') ? '%#StatWarning#%{SyntasticStatuslineFlag()}' : ''
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
if BundleInstalled('dotvim') | set showtabline=2 tabline=%!dotvim#shorttabline#call() | endif

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

" Silver Searcher
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
endif

" Platinum Searcher
if executable('pt')
  let &grepprg = 'pt --nogroup --nocolor --column -e'
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
if BundleInstalled('eightheader')
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

cabbrev args args %:p:h/\<BS>

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

if BundleInstalled('vim-sneak')
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
autocmd vimrc FileType asciidoc if BundleInstalled('vim-textobj-user') |
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

" autocmd vimrc VimEnter * call SpaceMaps()
" function! SpaceMaps()
"   call shortcut#prefix('<Space>')
"   call shortcut#map('dd', 'delete paragraph', 'normal dap')
"   " Not works in operator pending mode
"   call shortcut#map('dj', 'jump down', 'call feedkeys("\<Plug>(easymotion-sol-j)")')
" endfunction

noremap  <Space>?       :Unite mapping<CR>

noremap  <Space><Space>      g<C-]>
noremap  <C-W><Space><Space> <C-W>g<C-]>
nnoremap <Space><Tab>        :buffer #<CR>

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
nnoremap <Space>do :diffoff!<CR>
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

nmap            <Space>mK <Plug>Zeavim
vmap            <Space>mK <Plug>ZVVisSelection
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

"                            <Space>n - DEIN                             {{{3
" ............................................................................

nnoremap <Space>nc :for i in dein#check_clean() <Bar> echo 'Deleting ' . i <Bar> call delete(i, 'rf') <Bar> endfor<CR>
nnoremap <Space>nd :call dein#direct_install('')<Left><Left>
nnoremap <Space>ni :call dein#install()<CR>
nnoremap <Space>nl :Verbose echo dein#get_log()<CR>:set buftype=nofile<CR>:keeppatterns v/^<Bar>/d<CR>:keeppatterns g/^/m0<CR>:nohlsearch<CR>:nnoremap <buffer> q :bdelete!<lt>CR><CR>gg
nnoremap <Space>nu :call dein#update()<CR>

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
nnoremap <Space>wn  :botright 78 vnew [NOTES]<Bar> set ft=asciidoc buftype=nofile<CR>
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
" FIGYELEM! Az azonos esemenyekre vonatkozo autocommand-ok az itt megadott
" sorrend szerint hajtodnak vegre - ez neha nem vart eredmenyt okozhat!

" __ FAJLOK BEALLITASAI _________________

" Az ujonnan letrehozott .txt fajloknal legyen <CR><NL> a sorvegzodes. Azert
" kell ilyen nyakatekerten megoldani, mert ha pl. krusader-bol, vagy tcmd-bol
" hozunk letre egy uj fajt, akkor a BufNewFile nem ervenyes ra, mivel a fajl
" mar letezik, mikor a Vim megnyitja azt.
autocmd vimrc BufNewFile *.txt set fileformat=dos
autocmd vimrc BufRead *.txt if ! getfsize(expand('%')) | set fileformat=dos | endif

" :help fo-table. Azert autocmd, mert minden fajltipus felulirja a
" formatoptions-t a sajat beallitasaival, igy ez elveszne, ha csak mezei set
" lenne.
autocmd vimrc FileType * setlocal formatoptions+=con formatoptions-=l
if v:version >= 704
  autocmd vimrc FileType * setlocal formatoptions+=j
endif

" __ COMPLETION _________________________

" Fajltipus alapjan allitsa be az omni-completion-t.
if filereadable($VIMRUNTIME . '/autoload/syntaxcomplete.vim')
  autocmd vimrc FileType * if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
endif

" __ MEGJELENES _________________________

" Show cursorline only in the active split in normal mode - hide for insert
" mode.
autocmd vimrc WinEnter    * set cursorline
autocmd vimrc WinLeave    * set nocursorline
autocmd vimrc InsertEnter * set nocursorline
autocmd vimrc InsertLeave * set cursorline

" Ha atmeretezzuk a vim ablakat, akkor az ablakokat is meretezze ujra.
autocmd vimrc VimResized * wincmd =

" Sorok szamozasanak es a specialis karakterek mutatasanak kikapcsolasa a man,
" quickfix es pydoc buffereknel.
autocmd vimrc FileType man,qf setlocal nonumber nolist
autocmd vimrc BufNew __doc__ setlocal nonumber nolist

" Make hiba eseten nyissa meg a hibaablakot. A quickfix-reflector miatt kell a
" nested.
autocmd vimrc QuickFixCmdPost * nested botright cwindow
