" function! s:PreviewCurrentLine()
  " let previewBuffer = <sid>GetBufferFromLine()
  " if !empty(previewBuffer)
    " call <sid>OpenBuffer(previewBuffer)
  " endif
" endfunction

" function! s:OpenBuffer(num)
  " exec "normal! \<C-w>\<C-o>"
  " exec "vert leftabove sb" a:num
  " wincmd p
" endfunction

" function! s:GetBufferFromLine()
  " let line = getline('.')
  " if line !~ '^"'
    " return split(line, '\s\+')[0]
  " endif
" endfunction

" function! s:SetOriginBuffer()
  " if empty("b:originBuffer")
    " let b:originBuffer = <sid>GetBufferFromLine()
  " endif
" endfunction

" function! s:OpenOriginBuffer()
  " if !empty("b:originBuffer")
    " call <sid>OpenBuffer(b:originBuffer)
  " endif

  " call <sid>ToggleBufExplorer()
" endfunction

" function! s:DefineAdditionalBufExplorerMappings()
  " let b:originBuffer = ""
  " nnoremap <buffer> j :call <sid>SetOriginBuffer()<CR>j:call <sid>PreviewCurrentLine()<CR>
  " nnoremap <buffer> k :call <sid>SetOriginBuffer()<CR>k:call <sid>PreviewCurrentLine()<CR>
  " nnoremap <buffer> <CR> :ToggleBufExplorer<CR>
  " cnoremap <buffer> q<CR> :call <sid>OpenOriginBuffer()<CR>
" endfunction

" augroup bufexplorer_mappings
  " au!
  " au Filetype bufexplorer :call <sid>DefineAdditionalBufExplorerMappings()
" augroup END
