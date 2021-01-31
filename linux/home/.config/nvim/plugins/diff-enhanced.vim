" CHRISBRA/VIM-DIFF-ENHANCED
" use git as diffexpr
if !exists('g:vimrc_minimal_plugins')
  Plug 'chrisbra/vim-diff-enhanced'
  let &diffexpr='EnhancedDiff#Diff("git diff", "")'
endif
