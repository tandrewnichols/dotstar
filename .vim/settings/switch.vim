let g:switch_mapping = ""
nnoremap <C-S> :Switch<CR>

augroup SwitchDefinitions
  autocmd!
  autocmd FileType coffee let g:switch_custom_definitions =
    \ [
    \   ['Given', 'When', 'Then', 'And'],
    \   ['@service', '@scope'],
    \   ['toBe', 'toEqual'],
    \   ['toHaveBeenCalled', 'toHaveBeenCalledWith'],
    \   ['thenResolveWith', 'thenRejectWith']
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
