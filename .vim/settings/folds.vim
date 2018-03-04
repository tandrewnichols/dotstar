function! s:SyntaxFold(map)
  let prev_method = &fdm
  set fdm=syntax
  exec "normal!" a:map
  exec "set fdm=" . prev_method
endfunction

nnoremap <CR> :call <SID>SyntaxFold('za')<CR>
nnoremap <leader><CR> :call <SID>SyntaxFold('zA')<CR>

" Don't mess with enter for non-code things
augroup UnmapEnter
  au!
  au CmdwinEnter * nnoremap <CR> <CR>
  au BufReadPost quickfix nnoremap <CR> <CR>
augroup END
