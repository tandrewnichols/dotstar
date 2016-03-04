function! RootDirName()
  return split(projectroot#guess(expand("%:p")), '/')[-1]
endfunction

function! ImmediateRootSubDir()
  let rel = substitute(expand("%:p"), projectroot#guess(expand("%"))."/", "", "")
  return split(rel, '/')[0]
endfunction

function! GetRootRelative()
  let cwd = getcwd()
  let root = projectroot#guess(cwd)
  if cwd == root
    return ''
  endif
  let str = substitute(cwd."/", root, "", "")
  let rel = ''
  for part in split(str, '/')
    let rel .= '../'
  endfor
  return rel
endfunction

augroup SetProjRoot
  autocmd!
  autocmd BufEnter * let b:projroot = projectroot#guess()
  autocmd BufEnter * let b:projrel = GetRootRelative()
augroup END
