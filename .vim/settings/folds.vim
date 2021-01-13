function! s:SyntaxFold(map)
  let prev_method = &fdm
  set fdm=syntax
  exec "normal!" a:map
  exec "set fdm=" . prev_method
endfunction

augroup MapEnter
  au!
  au FileType javascript,json nnoremap <CR> :call <SID>SyntaxFold('za')<CR>
  au FileType javascript,json nnoremap <leader><CR> :call <SID>SyntaxFold('zA')<CR>
  au FileType html nnoremap <expr> <CR> foldclosed('.') == -1 ? 'zfat' : 'zA'
augroup END

" Don't mess with enter for non-code things
" augroup UnmapEnter
"   au!
"   au CmdwinEnter * nnoremap <CR> <CR>
"   au BufReadPost quickfix nnoremap <CR> <CR>
" augroup END
