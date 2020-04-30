function! s:OpenUrl(url)
  silent! exec "silent! !open ". shellescape(a:url, 1) . " > /dev/null"
  redraw!
endfunction

"
" Lookup Module Readme on Npm
"
function! OpenNpmReadme()
  call <SID>OpenUrl("https://www.npmjs.com/package/".expand("<cfile>"))
endfunction

nnoremap <leader>npm :call OpenNpmReadme()<CR>

"
" Lookup lodash function
"
function! OpenLodashDocs()
  call <SID>OpenUrl("https://lodash.com/docs#".expand("<cword>"))
endfunction

nnoremap <leader>_ :call OpenLodashDocs()<CR>

command! -nargs=1 -complete=file Open :call s:OpenUrl(<q-args>)
