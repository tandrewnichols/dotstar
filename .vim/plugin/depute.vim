if exists("g:angular_loaded") || &cp | finish | endif

let g:angular_loaded = 1

augroup DirectInjection
  au!
  au BufEnter */manta-frontend/client/* inoremap <buffer> <expr> <C-x>d depute#autoInject('angular', '"dp')
  au BufEnter */manta-frontend/client/* nnoremap <buffer> <leader>di :call depute#inject('angular')<CR>
  " au BufEnter */manta-frontend/server/* inoremap <buffer> <expr> <C-x>d depute#autoInject('node', '')
  " au BufEnter */manta-frontend/server/* nnoremap <buffer> <leader>di :call depute#inject('node')<CR>
augroup END
