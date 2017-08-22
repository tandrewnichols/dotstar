let g:switch_mapping = ""
nnoremap <C-S> :Switch<CR>

augroup SwitchDefinitions
  autocmd!
  autocmd FileType coffee let g:switch_custom_definitions =
    \ [
    \   ['Given', 'When', 'Then', 'And']
    \ ]
  autocmd FileType html let g:switch_custom_definitions =
    \ [
    \   {
    \     '{{#\([^}]\{-}\)}}': '{{^\1}}',
    \     '{{^\([^}]\{-}\)}}': '{{/\1}}',
    \     '{{/\([^}]\{-}\)}}': '{{#\1}}'
    \   }
    \ ]
  autocmd FileType javascript let g:switch_custom_definitions =
    \ [
    \   {
    \     'function(\([^)]\{-}\))': '(\1) =>',
    \     '(\([^)]\{-}\)) =>': 'function(\1)'
    \   }
    \ ]
augroup END
