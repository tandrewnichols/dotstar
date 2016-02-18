"function! s:BootstrapAdjustColSize(dir)
  "exe "silent normal /col-\<CR>N"
  "let l:col = matchstr(expand('<cword>'), '\d\{1,2\}$')
  "echom l:col
  "exe "normal! " . l:col . "\<C-X>"
  "echom l:col
"endfunction

"nnoremap <leader>col :call <SID>BootstrapAdjustColSize('+')<CR>
