function! s:StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/[^\S\r\n]\+$//e
  call cursor(l, c)
endfunction

nnoremap <leader>st :call <SID>StripTrailingWhitespaces()<CR>
