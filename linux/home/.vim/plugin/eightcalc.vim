" \NX az, ami modosulni fog!

command!  -range -nargs=*  Calc  call Calc( <line1>, <line2>, <q-args> )

function! Calc( start, stop, args )
  let input = Init( SplitArgs( a:args ) )
  let s:N = {}
  let s:old_N = {}
  " eval( input['before'] )
  for linenr in range( a:start, a:stop )
    let line = getline( linenr )
    let new_line = line
    let next_match = match( line, input['pattern'] )
    " doing the calculation on every match in the line (like :s///g)
    while next_match >= 0
      let new_line = strpart( new_line, 0, next_match )
      let found = matchlist( line, input['pattern'], next_match )
      for var in keys( s:vars )
        let s:old_N[var] = found[s:vars[var]]
        let s:N[var] = str2float( tr( s:old_N[var], ',', '.' ) )
      endfor
      for cmd in input['commands']
        call F( cmd )
      endfor
      for var in keys( s:vars )
        if s:old_N[var] != s:N[var]
          let line = substitute( line, s:old_N[var], printf( '%f', s:N[var] ), '' )
        endif
      endfor
      call setline( linenr, line )
      let next_match = index( line, input['pattern'], next_match )
    endwhile
  endfor
  " eval( input['after'] )
endfunction

function! SplitArgs( args )
  let input = { 'pattern': '', 'before': [], 'after': [], 'commands': [] }
  " args[0] is the pattern which we searching for
  let args = split( a:args, a:args[0] )
  let input['pattern'] = args[0]
  for i in range( 1, len( args ) - 1 )
    if args[i] =~ '^<'
      let input['before'] = [substitute(args[i], '^<', '', '' )]
    elseif args[i] =~ '^>'
      let input['after'] = [substitute(args[i], '^>', '', '' )]
    else
      let input['commands'] += [args[i]]
    endif
  endfor
  return input
endfunction

" Marad a korbebastyazas... A while ciklus utan a maradekot elmentjuk, mert
" ezt a new_line vegere kell biggyeszteni. Figyelj az index ertekere! (s:vars)
let s:num_regex = '[+-]\\?\\d\\+[.,]\\?\\d*'
function! Init( input )
  let input = a:input
  let s:vars = {}
  let find_n = "let found = match( input['pattern'], '\\\zsN[A-Z]' )"
  " searching for \NX
  exe find_n
  while found >= 0
    " If not the \NX found.
    let var_name = 'N' . input['pattern'][found+1]
    if var_name != 'NX'
      let s:vars = extend( s:vars, { var_name: ExprCount( found, '\\(', 0, found ) + 1 } )
    endif
                                                                 " EZ MÉG SZAR
    let input['pattern'] = substitute( input['pattern'], '\\' . var_name, found[2] != 'NN' ? '\\(' . s:num_regex . '\\)' : s:num_regex, '' )
    unlet found
    exe find_n
  endwhile
  return input
endfunction

" src: search in
" expr: search for
" start: from byte (-1 disables)
" len: length of src to search in (-1 disables)
function! ExprCount( src, expr, start, len )
  exe 'let src = strpart(a:src' . (a:start >= 0 ? ', ' . a:start : '') . (a:len > 0 ? ', ' . a:len : '') . ')'
  return len( split( src, a:expr, 1 ) ) - 1
endfunction

function! F( cmd )
  let N = s:N
  exe a:cmd
endfunction
