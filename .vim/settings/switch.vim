let g:switch_mapping = ""
nnoremap <C-S> :Switch<CR>

augroup SwitchDefinitions
  autocmd!
  autocmd FileType coffee let g:switch_custom_definitions =
    \ [
    \   ['Given', 'When', 'Then', 'And']
    \ ]
augroup END
