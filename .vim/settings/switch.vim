let g:switch_mapping = ""
nnoremap ga :Switch<CR>
nnoremap gh :SwitchReverse<CR>

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
    \   },
    \   {
    \     '<h1\([^>]\{-}\)>\([^<]\{-}\)</h1>': '<h2\1>\2</h2>',
    \     '<h2\([^>]\{-}\)>\([^<]\{-}\)</h2>': '<h3\1>\2</h3>',
    \     '<h3\([^>]\{-}\)>\([^<]\{-}\)</h3>': '<h4\1>\2</h4>',
    \     '<h4\([^>]\{-}\)>\([^<]\{-}\)</h4>': '<h5\1>\2</h5>',
    \     '<h5\([^>]\{-}\)>\([^<]\{-}\)</h5>': '<h6\1>\2</h6>',
    \     '<h6\([^>]\{-}\)>\([^<]\{-}\)</h6>': '<h1\1>\2</h1>'
    \   },
    \   {
    \     '<div\([^>]\{-}\)>\([^<]\{-}\)</div>': '<span\1>\2</span>',
    \     '<span\([^>]\{-}\)>\([^<]\{-}\)</span>': '<div\1>\2</div>'
    \   },
    \   {
    \     '<a\([^>]\{-}\)>\([^<]\{-}\)</a>': '<button\1>\2</button>',
    \     '<button\([^>]\{-}\)>\([^<]\{-}\)</button>': '<a\1>\2</a>'
    \   },
    \   ['xs', 'sm', 'md', 'lg'],
    \   ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
    \ ]
  autocmd FileType javascript let g:switch_custom_definitions =
    \ [
    \   {
    \     'function(\([^)]\{-}\))': '(\1) =>',
    \     '(\([^)]\{-}\)) =>': 'function(\1)'
    \   },
    \   ['var', 'let', 'const']
    \ ]
augroup END
