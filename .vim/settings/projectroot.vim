function! RootDirName()
  return split(projectroot#guess(expand("%:p")), '/')[-1]
endfunction

function! ImmediateRootSubDir()
  let rel = substitute(expand("%:p"), projectroot#guess(expand("%"))."/", "", "")
  return split(rel, '/')[0]
endfunctio
