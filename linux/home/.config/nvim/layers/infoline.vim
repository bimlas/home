" Kellokepp magas legyen a statusline alatti terulet.
set cmdheight=2

" Minden valtoztatasrol tajekoztasson.
set report=0

" Operatorra varo parancs mutatasa (pl. makro rogzitesehez hasznalt 'q'),
" kijelolesnel a kijeloles merete.
set showcmd

" Mod (insert, visual, stb.) mutatasa.
set showmode

" Completion in the command line:
" - <Tab> expands string to the longest common part
" - Second <Tab> shows all match
" - Starting from the third will iterate on the list
set wildmode=longest,list,full
