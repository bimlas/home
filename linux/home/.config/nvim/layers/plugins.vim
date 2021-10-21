source $HOME/.config/nvim/layers/plugins/plug.vim

source $HOME/.config/nvim/layers/plugins/disable-default-plugins.vim
source $HOME/.config/nvim/layers/plugins/netrw.vim

" .. SAJAT ..............................

source $HOME/.config/nvim/layers/plugins/dotvim.vim
source $HOME/.config/nvim/layers/plugins/eightheader.vim
source $HOME/.config/nvim/layers/plugins/high.vim
source $HOME/.config/nvim/layers/plugins/numutils.vim

" .. MEGJELENES .........................
" http://bytefluent.com/vivify/
" http://cocopon.me/app/vim-color-gallery/
" http://vimcolors.com/

source $HOME/.config/nvim/layers/plugins/colorscheme.vim

" .. TEXTOBJ-USER .......................

source $HOME/.config/nvim/layers/plugins/textobj-user.vim
source $HOME/.config/nvim/layers/plugins/textobj-entire.vim
source $HOME/.config/nvim/layers/plugins/textobj-comment.vim
source $HOME/.config/nvim/layers/plugins/textobj-pastedtext.vim
source $HOME/.config/nvim/layers/plugins/textobj-between.vim
source $HOME/.config/nvim/layers/plugins/textobj-parameter.vim
source $HOME/.config/nvim/layers/plugins/textobj-variable-segment.vim

" .. SZOVEG KERESESE/MODOSITASA .........

source $HOME/.config/nvim/layers/plugins/visualstar.vim

" .. EGYEB HASZNOSSAGOK .................

source $HOME/.config/nvim/layers/plugins/open-browser.vim

" .. FAJLTIPUSOK ........................

source $HOME/.config/nvim/layers/plugins/asciidoctor.vim

if(!exists('g:vimrc_minimal_plugins'))

  " .. KURZOR MOZGATASA ...................

  " source $HOME/.config/nvim/layers/plugins/easymotion.vim

  " .. SZOVEG KERESESE/MODOSITASA .........

  source $HOME/.config/nvim/layers/plugins/qf.vim
  source $HOME/.config/nvim/layers/plugins/sandwich.vim
  source $HOME/.config/nvim/layers/plugins/abolish.vim
  source $HOME/.config/nvim/layers/plugins/exchange.vim
  source $HOME/.config/nvim/layers/plugins/easy-align.vim
  source $HOME/.config/nvim/layers/plugins/textconv.vim

  " .. FAJLOK/BUFFEREK/STB. BONGESZESE ....

  source $HOME/.config/nvim/layers/plugins/dirvish.vim
  source $HOME/.config/nvim/layers/plugins/fzf.vim
  source $HOME/.config/nvim/layers/plugins/telescope.vim

  " .. EGYEB HASZNOSSAGOK .................

  source $HOME/.config/nvim/layers/plugins/linediff.vim
  source $HOME/.config/nvim/layers/plugins/highlightedyank.vim
  source $HOME/.config/nvim/layers/plugins/bookmarks.vim
  source $HOME/.config/nvim/layers/plugins/diff-enhanced.vim
  source $HOME/.config/nvim/layers/plugins/repeat.vim
  source $HOME/.config/nvim/layers/plugins/scriptease.vim
  source $HOME/.config/nvim/layers/plugins/rooter.vim

  " .. PROGRAMOZAS ........................

  source $HOME/.config/nvim/layers/plugins/treesitter.vim
  source $HOME/.config/nvim/layers/plugins/ts-rainbow.vim
  source $HOME/.config/nvim/layers/plugins/tcomment.vim
  source $HOME/.config/nvim/layers/plugins/lexima.vim
  source $HOME/.config/nvim/layers/plugins/quickrun.vim
  source $HOME/.config/nvim/layers/plugins/coc.vim
  source $HOME/.config/nvim/layers/plugins/ultisnips.vim
  source $HOME/.config/nvim/layers/plugins/snippets.vim

  " .. GIT ................................

  source $HOME/.config/nvim/layers/plugins/fugitive.vim
  source $HOME/.config/nvim/layers/plugins/gv.vim
  source $HOME/.config/nvim/layers/plugins/gitgutter.vim

endif

call plug#end()
