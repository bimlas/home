" eightcmd.vim: commands to invoke my functions
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.07.23 09:11 ==

augroup eightcmd
  autocmd!
augroup END

let g:writepre_disabled = 0
autocmd  eightcmd  BufWritePre  *  call eight#writepre#call()

if ! exists( '*Helptags' )
  command!  -nargs=?                  Helptags              call eight#helptags#call()
endif

command!  -nargs=0 -range=%           Uniq                  <line1>,<line2> sort u
command!  -nargs=0 -range=%           Tac                   <line1>,<line2> g/^/ m <line1>-1 | nohlsearch
command!  -nargs=*                    Szotar                call eight#szotar#call( <q-args> )
command!  -nargs=0 -range             Ekezet                call eight#ekezet#call( <line1>, <line2> )
command!  -nargs=* -range=%           Chindent              call eight#chindent#call( <line1>, <line2>, <f-args> )
command!  -nargs=0 -range             HtmlEscape            call eight#htmlescape#call( <line1>, <line2>, 1 )
command!  -nargs=0 -range             HtmlNoEscape          call eight#htmlescape#call( <line1>, <line2>, 0 )
command!  -nargs=*                    Run                   call eight#run#call( '<args>' )
command!  -nargs=* -complete=command  Gdo                   call eight#gdo#call( '<args>' )

" Sorok tordelese kulon-kulon. (bemasolt szoveg formazasahoz)
command!  -nargs=0 -range             AdocFormat            silent <line1>,<line2> g/.\+/ normal A +<C-C>gqq:nohlsearch<CR>

" A mintara illeszkedo szovegen kivul toroljon mindent.
" http://stackoverflow.com/a/6249291
command!  -nargs=+ -range=%           DeleteExpect          <line1>,<line2> s#\(^\|\(<args>\)\@<=\).\{-}\($\|<args>\)\@=##g
