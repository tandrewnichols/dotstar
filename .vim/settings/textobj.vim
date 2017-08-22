call textobj#user#plugin('object', {
\   'path': {
\     'pattern': "[\$a-zA-Z0-9_.]\*",
\     'select': ['io'],
\   },
\   'full': {
\     'pattern': "[\$a-zA-Z0-9_.]\*[\$a-zA-Z0-9_.[\\]]\*",
\     'select': ['ao'],
\   }
\ })

call textobj#user#plugin('mustache', {
\   'variable': {
\     'pattern': ['{{[#^>!\/]\?\s*', '\s*}}'],
\     'select-a': 'am',
\     'select-i': 'im'
\   }
\ })

" TODO: implement key/value grabbing
" call textobj#user#plugin('keyvalue', {
" \   'kv-i': {
" \     'pattern': '[\'"]\<\?[^:]\{-}:\s?[\'"]
" \ })

let g:textobj#quote#educate = 0
xmap a%  <Plug>(textobj-matchit-a)
omap a%  <Plug>(textobj-matchit-a)
xmap i%  <Plug>(textobj-matchit-i)
omap i%  <Plug>(textobj-matchit-i)
nnoremap <silent> <leader>r" ggvG<Plug>ReplaceWithStraight
nnoremap <silent> <leader>r' ggvG<Plug>ReplaceWithStraight
vnoremap <silent> <leader>r" <Plug>ReplaceWithStraight
vnoremap <silent> <leader>r' <Plug>ReplaceWithStraight
