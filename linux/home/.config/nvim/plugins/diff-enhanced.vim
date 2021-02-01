" CHRISBRA/VIM-DIFF-ENHANCED
" use git as diffexpr
Plug 'chrisbra/vim-diff-enhanced'
let &diffexpr='EnhancedDiff#Diff("git diff", "")'
