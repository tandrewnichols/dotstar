function! s:StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

nnoremap <leader>st :call <SID>StripTrailingWhitespaces()<CR>
