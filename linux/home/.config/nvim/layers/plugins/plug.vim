let s:plugin_manager_dir = $HOME . '/.vim/vim-plug'
let s:plugins_install_dir = $HOME . '/.vim/plugins'
let s:plugins_config_dir = $HOME . '/.config/nvim/plugins'

if ! (has('ruby') || has('python3'))
  let g:plug_threads = 1
endif

function! s:InstallPluginManager()
  let repository = 'https://github.com/junegunn/vim-plug'

  if ! executable('git')
    echohl ErrorMsg | echomsg 'Git is not available.' | echohl None
    return
  endif

  if ! isdirectory(s:plugin_manager_dir)
    silent! if ! mkdir(s:plugin_manager_dir, 'p')
      echohl ErrorMsg | echomsg 'Cannot create directory (may be a regular file):' | echomsg s:plugin_manager_dir | echohl None
      return
    endif
  endif

  echo 'Cloning plugin manager...'
  let msg = system('git clone --depth 1 "' . repository . '" "' . s:plugin_manager_dir . '"')
  if msg =~ 'fatal'
    echohl ErrorMsg | echomsg 'Cannot clone ' . repository . ' to ' . s:plugin_manager_dir . ':' | echomsg msg | echohl None
    return
  endif

  echomsg 'Plugin manager installed. Please restart Vim and install plugins (:PlugInstall).'
  call getchar()
  quit
  return
endfunction

if !isdirectory(s:plugin_manager_dir)
  call s:InstallPluginManager()
else
  exe 'source ' . s:plugin_manager_dir . '/plug.vim'
  call plug#begin(s:plugins_install_dir)
endif
