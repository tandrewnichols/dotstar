" Google current word
function! GoogleSearch()
  silent! exec "silent! !google-chrome \"http://google.com/search?q=" . @g . "\" > /dev/null"
  redraw!
endfunction
vnoremap <leader>goo "gy<Esc>:call GoogleSearch()<CR>
nnoremap <leader>goo b"gye:call GoogleSearch()<CR>
