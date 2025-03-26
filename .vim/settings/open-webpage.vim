function! s:OpenUrl(url)
  silent! exec "silent! !open ". shellescape(a:url, 1) . " > /dev/null"
  redraw!
endfunction

command! -nargs=1 -complete=file OpenUrl :call s:OpenUrl(<q-args>)

"
" Lookup Module Readme on Npm
"
function! OpenNpmReadme()
  call <SID>OpenUrl("https://www.npmjs.com/package/".expand("<cfile>"))
endfunction

command! -nargs=1 Readme :call OpenNpmReadme(<q-args>)
