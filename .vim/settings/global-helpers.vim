" getchar returns a number code, so convert that to a letter
function! GetRealChar()
  let c = getchar()
  if c =~ '^\d\+$'
    let c = nr2char(c)
  endif
  return c
endfunction

" Get a char from the user, but return nothing for Esc and Ctrl-C
function! GetUserInput()
  let c = GetRealChar()
  if c == " "
    let c .= GetRealChar()
  endif
  if c =~ "\<Esc>" || c =~ "\<C-C>"
    return ""
  else
    return c
  endif
endfunction

" Helper
" jacked from burnettk/vim-angular where it was originally
" jacked from abolish.vim (was s:snakecase there).
function! KebabCase(word) abort
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'_','-','g')
  let word = tolower(word)
  return word
endfunction

" Find a file up the directory hierarchy from the cwd
function! Findup(file)
  return FindupFrom(getcwd(), a:file)
endfunction

" Find a file up the directory hierarchy from a given directory
function! FindupFrom(dir, file)
  let dir = fnamemodify(a:dir, ":p")
  let trypath = dir . a:file
  return PathExists(trypath) ? trypath : FindupFrom(fnamemodify(dir, ":p:h:h"), a:file)
endfunction

function! LineMatches(test)
  return match(getline('.'), a:test) > -1
endfunction

function! PathExists(path)
  return !empty(glob(a:path))
endfunction

function! EndsInSlash(thing)
  return matchstr(thing, "/$") == "/"
endfunction

function! TrimTrailingSlash(thing)
  return substitute(thing, "/$", "", "")
endfunction

function! ResolveRelativeToCurrentFile(file)
  return fnamemodify(expand("%:p:h") . "/" . a:file, ":p")
endfunction
