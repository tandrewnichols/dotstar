" Find a file up the directory hierarchy from the cwd
function! graft#helpers#Findup(file)
  return graft#helpers#FindupFrom(getcwd(), a:file)
endfunction

" Find a file up the directory hierarchy from a given directory
function! graft#helpers#FindupFrom(dir, file)
  let dir = fnamemodify(a:dir, ":p")
  let trypath = dir . a:file
  return graft#helpers#PathExists(trypath) ? trypath : graft#helpers#FindupFrom(fnamemodify(dir, ":p:h:h"), a:file)
endfunction

function! graft#helpers#LineMatches(test)
  return match(getline('.'), a:test) > -1
endfunction

function! graft#helpers#PathExists(path)
  return !empty(glob(a:path))
endfunction

function! graft#helpers#EndsInSlash(thing)
  return matchstr(a:thing, "/$") == "/"
endfunction

function! graft#helpers#TrimTrailingSlash(thing)
  return substitute(a:thing, "/$", "", "")
endfunction

function! graft#helpers#ResolveRelativeToCurrentFile(file)
  return fnamemodify(expand("%:p:h") . "/" . a:file, ":p")
endfunction

function! graft#helpers#HasExtension(path)
  return !empty(fnamemodify(a:path, ":e"))
endfunction

function! graft#helpers#HasPathSeparator(path)
  return a:path =~ "/"
endfunction

function! graft#helpers#IsRelativeFilepath(path)
  return a:path =~ "^\\."
endfunction

function! graft#helpers#AddExtension(path, ext)
  return fnamemodify(a:path, ":p") . "." . a:ext
endfunction
