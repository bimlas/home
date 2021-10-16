" :PP
"   Pretty print.  With no argument, acts as a REPL.
" :Runtime
"   Reload runtime files.  Like `:runtime!`, but it unlets any include
"   guards first.
" :Disarm
"   Remove a runtime file's maps, commands, and autocommands, effectively
"   disabling it.
" :Scriptnames
"   Load `:scriptnames` into the quickfix list.
" :Verbose
"   Capture the output of a `:verbose` invocation into the preview window.
" :Time
"   Measure how long a command takes.
" :Breakadd
"   Like its lowercase cousin, but makes it much easier to set breakpoints
"   inside functions.  Also :Breakdel.
" :Vedit
"   Edit a file relative the runtime path. For example, `:Vedit
"   plugin/scriptease.vim`. Also, `:Vsplit`, `:Vtabedit`, etc.
"   Extracted from [pathogen.vim](https://github.com/tpope/vim-pathogen).
" K
"   Look up the `:help` for the VimL construct under the cursor.
" zS
"   Show the active syntax highlighting groups under the cursor.
" g!
"   Eval a motion or selection as VimL and replace it with the result.
"   This is handy for doing math, even outside of VimL.  It's so handy, in fact,
"   that it probably deserves its own plugin.
Plug 'tpope/vim-scriptease'

" Simple calculator/evaulator.
map      <Space>ac g!
nnoremap <Space>aC :PP<CR>
