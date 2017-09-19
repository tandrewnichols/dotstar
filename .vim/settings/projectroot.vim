function! RootDirName()
  return split(projectroot#guess(expand("%:p")), '/')[-1]
endfunction

function! ImmediateRootSubDir()
  let rel = RelativeToRoot(expand("%:p"))
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

function! RelativeToRoot(where)
  return substitute(a:where, projectroot#guess(expand("%"))."/", "", "")
endfunction
