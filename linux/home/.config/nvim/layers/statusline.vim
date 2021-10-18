let stat_argnr      = '%a'
let stat_buftype    = '%w%h%q'
let stat_filename   = '%t'
let stat_flags      = '%r%m'
let stat_binary     = '%{&binary ? "BINARY" : ""}'
let stat_filetype   = '%{&filetype}'
let stat_fileformat = '%{&fenc ? &fenc : &enc}%{&bomb ? "-bom" : ""} %{&ff}'

let &statusline  = stat_argnr . ' '
let &statusline .= '%#StatInfo#' . stat_buftype . ' '
let &statusline .= '%#StatFilename#' . stat_filename . '%(' . stat_flags . ' %)'
let &statusline .= '%#StatWarning#%( ' . stat_binary . ' %)'
let &statusline .= '%#StatInfo# [%#StatFileformat#' .stat_filetype . '%#StatInfo#]'
let &statusline .= '[%#StatFileformat#' . stat_fileformat . '%#StatInfo#] '
let &statusline .= '%*'
