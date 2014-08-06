" GCodeLimits.vim - Hatarertekek kiirasa.
"
" ===================== BimbaLaszlo(.co.nr|gmail.com) ========== 2013.10.14 ==

"                                 VARIABLES                               {{{1
" ============================================================================

"                                   GLOBAL
" ____________________________________________________________________________

if exists( 'g:loaded_GCode' )
    finish
endif

let g:loaded_GCode = 1

if ! exists( 'g:GCode_labels' )
    let g:GCode_labels = [ 'X', 'Y', 'Z', 'A', 'B', 'C', 'S', 'F' ]
endif

if ! exists( 'g:GCode_point' )
    let g:GCode_point = '.'
endif

"                                   SCRIPT
" ____________________________________________________________________________

" Allowed characters for values.
let s:valregex = '[0-9,+\.\-]\+'

"                              SCRIPT FUNCTIONS                           {{{1
" ============================================================================

"                                   ERROR                                 {{{2
" ____________________________________________________________________________
"
" Print an errormessage.

function s:Error( msg )

    echohl ErrorMsg | echomsg 'GCode:' a:msg | echohl None

endfunction

"                                CHECKARGS                              {{{2
" ____________________________________________________________________________
"
" Return 1 if the label is not a character or value is not a float.

function s:CheckArgs( labels, values, msg )

    let msg = (a:msg != '') ? a:msg . ': ' : ''

    for label in a:labels
        if len( label ) != 1
            call s:Error( msg . 'one character needed for label: "' . label .'"' )
            return 1
        endif
    endfor

    for value in a:values
        if value !~ '^' . s:valregex . '$'
            call s:Error( msg . 'only [0-9.,+-] characters allowed for value: "' . value . '"' )
            return 1
        endif
    endfor

    return 0

endfunction

"                                 INITLABELS                              {{{2
" ____________________________________________________________________________

function s:InitLabels( labels )

    let labels = {}
    let val    = 99999.0

    for label in a:labels
        call extend( labels, { label : { 'now' : val, 'min' : val, 'max' : 0 - val, 'min_abs' : val } } )
    endfor

    return labels

endfunction

"                                 GETLIMITS                               {{{2
" ____________________________________________________________________________
"
" Get the maximum, minimum and absolute minimum values of the g:GCode_labels.

function s:GetLimits( first, last, mode )

    if s:CheckArgs( g:GCode_labels, [ 0 ], 'g:GCode_labels' )
        return
    endif

    let labels   = join( g:GCode_labels, '' )   " Character collection.
    let lnum     = a:first                      " Actual linenumber.
    let limits   = {}                           " Table of results.
    let now      = {}                           " Values of actual line.
    let msg      = []                           " The echoed table of results.
    let save_pos = getpos( '.' )                " The cursor's position.
    let save_mod = &modified                    " The state of modified.

    for name in g:GCode_labels
        call extend( now,    { name : 99999.0 } )
    endfor

    let limits = s:InitLabels( g:GCode_labels )

    let cmd = 'len( add( line, [ submatch( 1 ), str2float( submatch( 2 ) ) ] )) ? submatch( 0 ) : submatch( 0 )'

    while lnum <= a:last

        let line = []

        " Get the label values from the non-commented lines.

        silent exe lnum . ',' . lnum . ' s#\([' . labels . ']\)\(' . s:valregex . '\)#\= ' . cmd . ' #ge'

        " The min() and max() does not handle the floating numbers, so we will
        " compare the values exactly.

        for label in line

            let now[ label[ 0 ] ] = label[ 1 ]

            if limits[ label[ 0 ] ][ 'min' ] > label[ 1 ]
                let limits[ label[ 0 ] ][ 'min' ] = label[ 1 ]
            endif

            if limits[ label[ 0 ] ][ 'max' ] < label[ 1 ]
                let limits[ label[ 0 ] ][ 'max' ] = label[ 1 ]
            endif

            if limits[ label[ 0 ] ][ 'min_abs' ] > abs( label[ 1 ])
                let limits[ label[ 0 ] ][ 'min_abs' ] = abs( label[ 1 ] )
            endif

        endfor

        let lnum = lnum + 1

    endwhile

    " Print the table of results.

    if a:mode == 'write'
        let msg = [ '========== HATARERTEKEK =========' ]
    endif

    let header = ''
    let did_header = 0

    for name in g:GCode_labels

        let values = ''

        for key in [ 'min', 'max', 'min_abs' ]

            if did_header == 0
                let header .= printf( '  %8s', key )
            endif

            let values .= tr( printf( '  %8g', limits[ name ][ key ] ), '.', g:GCode_point )

        endfor

        if did_header == 0
            let msg += [ '   ' . header ]
            let msg += [ '  +' . repeat( '-', 30 ) . '' ]
            let did_header = 1
        endif

        let msg += [ name . ' |' . values ]

    endfor

    if a:mode == 'write'

        let msg += [ '======= HATARERTEKEK VEGE =======' ]

        call append( a:first - 1, map( msg, '"( " . v:val . " )"' ) )

    else

        echo join( msg, "\n" )
        call setpos( '.', save_pos )
        let &modified = save_mod

    endif

endfunction

"                                 SETLIMITS                               {{{2
" ____________________________________________________________________________
"
" Set the limits of label.

function s:SetLimits( first, last, label, min, max )

    if s:CheckArgs( [ a:label ], [ a:min, a:max ], '' )
        return
    endif

    let cmd = 'submatch( 1 ) < ' . a:min . ' ? "' . a:label . tr( a:min, '.', g:GCode_point ) . '" : "' . a:label . '" . submatch( 1 )'
    silent exe a:first . ',' . a:last . ' s#' . a:label . '\(' . s:valregex . '\)#\= ' . cmd . ' #ge'

    let cmd = 'submatch( 1 ) > ' . a:max . ' ? "' . a:label . tr( a:max, '.', g:GCode_point ) . '" : "' . a:label . '" . submatch( 1 )'
    silent exe a:first . ',' . a:last . ' s#' . a:label . '\(' . s:valregex . '\)#\= ' . cmd . ' #ge'

endfunction

"                                 LABELMATH                               {{{2
" ____________________________________________________________________________
"
" Do math on the values of the label.

function s:LabelMath( first, last, op, label, value )

    if s:CheckArgs( [ a:label ], [ a:value ], '' )
        return
    endif

    let label = InitLabels( a:label )

    " let cmd = 'tr(printf("%g", str2float(submatch(1)) ' . a:op . ' ' . a:value . '), ".", "' . g:GCode_point . '")'
    " silent exe a:first . ',' . a:last . ' s#' . a:label . '\(' . s:valregex . '\)#\= "' . a:label . '" . ' . cmd . ' #ge'

endfunction

"                                  COMMANDS                               {{{1
" ============================================================================

command  -nargs=0 -range  GCodeGetLimits    call <SID>GetLimits( <line1>, <line2>, 'get' )
command  -nargs=0 -range  GCodeWriteLimits  call <SID>GetLimits( <line1>, <line2>, 'write' )
command  -nargs=* -range  GCodeSetLimits    call <SID>SetLimits( <line1>, <line2>, <f-args> )
