setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^==\\+\\s.\\+'?'>'.(len(matchstr(getline(v:lnum),'^=\\+'))-1):'='
setlocal nofoldenable
if has('gui_running')
  setlocal spell
endif
