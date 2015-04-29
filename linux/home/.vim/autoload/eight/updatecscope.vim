" OUT OF BUSINESS
"
" Cscope adatbazis frissitese: argumentum nelkul a makefile konyvtarban, vagy
" a jelenlegi konyvtarban, ha az argumentum == 'init', akkor csak kapcsolodik
" hozza.
" UZEMEN KIVUL: majd egyszer ujrairom, addig meghagyom a regi verzio
" toredeket, hogy tudjam, mit, hogy csinaltam anno.
"
" ========== BimbaLaszlo (.github.io|gmail.com) ========== 2014.12.11 08:17 ==

function! eight#updatecscope#call( mode )
  if ! has( 'cscope' )
    return
  endif

  let cscope = FindExe( [ 'cscope' ] )
  if cscope == ''
    return
  endif

  let project    = Project()
  let path       = project.path
  let cscopefile = project.file . '.cscope'

  if (a:mode == 'init') && (filereadable( cscopefile ))
    return
  endif

  exe 'cscope kill ' . cscopefile

  exe 'cd ' . path
  silent exe '!' . cscope . ' -Rbf ' . cscopefile
  silent! cd -

  exe 'cscope add ' . cscopefile . ' ' . path
endfunction
