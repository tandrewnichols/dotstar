augroup VimlintQf
  autocmd!
  autocmd FileType vim command! -nargs=0 -buffer Lint call vimlint#vimlint(expand("%"), { 'output': 'quickfix' }) 
augroup END
