func! s:SetDiffMappings() abort
  nnoremap <buffer> J 5j
  nnoremap <buffer> K 5k
endfunc

augroup diff_files
  au!
  au Filetype diff call <SID>SetDiffMappings()
augroup END

