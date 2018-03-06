augroup AssignProjectRoot
  au!
  au BufRead,BufNew * let b:projectroot = projectroot#guess() | let b:projectroot_name = matchstr(b:projectroot, '/\zs[^\/]\+\ze$')
augroup END
