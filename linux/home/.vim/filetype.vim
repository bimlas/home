augroup filetypedotvim
  autocmd!
  autocmd  BufNewFile,BufRead  *.adoc             set filetype=asciidoc
  autocmd  BufNewFile,BufRead  *.docbk,*.docbook  set filetype=docbk
  autocmd  BufNewFile,BufRead  *.md               set filetype=markdown
  autocmd  BufNewFile,BufRead  *.nc               set filetype=ngc
  autocmd  BufNewFile,BufRead  *.plt              set filetype=gnuplot
  autocmd  BufNewFile,BufRead  *.log              set filetype=messages
augroup END
