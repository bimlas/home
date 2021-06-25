let s:layers_config_dir = $HOME . '/.config/nvim/layers'

function! bimlas#layers#configure(name)
  exe 'source ' . s:layers_config_dir . '/' . a:name . '.vim'
endfunction
