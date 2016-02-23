function! s:OpenUrl(url)
  silent! exec "silent! !open ". shellescape(a:url, 1) . " > /dev/null"
  redraw!
endfunction
"
" Google current word
"
function! GoogleSearch(word)
  call <SID>OpenUrl("http://google.com/search?q=".a:word)
endfunction

vnoremap <leader>goo "gy<Esc>:call GoogleSearch(@g)<CR>
nnoremap <leader>goo :exec ":call GoogleSearch('" . expand("<cword>") . "')"<CR>

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
