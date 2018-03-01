nnoremap <CR> za
nnoremap <leader><CR> zA

" Don't mess with enter for non-code things
augroup UnmapEnter
  au!
  au CmdwinEnter * nnoremap <CR> <CR>
  au BufReadPost quickfix nnoremap <CR> <CR>
augroup END
