function! ProjectRoot() abort
  let projroot = projectroot#guess()

  if !exists('b:projectroot_name')
    let b:projectroot = projroot
    let b:projectroot_name = matchstr(b:projectroot, '/\zs[^\/]\+\ze$')
  endif

  if getcwd() == projroot
    return '.'
  endif

  let relative = split(getcwd(), b:projectroot_name . '/')

  if len(relative) < 1
    return b:projectroot_name
  else
    let relative = relative[1]
  endif

  let path = ''
  for part in split(relative, '/')
    let path .= '../'
  endfor

  return path
endfunction

augroup AssignProjectRoot
  au!
  au BufRead,BufNew * let b:projectroot = projectroot#guess() | let b:projectroot_name = matchstr(b:projectroot, '/\zs[^\/]\+\ze$')
augroup END
