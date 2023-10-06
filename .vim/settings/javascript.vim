function! s:DoAction(name) abort
  let name = a:name
  let constant = toupper(substitute(name, '\(\l\)\(\u\)', '\1\_\l\2', "g"))
  let lines = [
    \   "export const " . name . " = createAction('" . constant . "');",
    \   "export const " . name . "Success = createAction('" . constant . "_SUCCESS');",
    \   "export const " . name . "Error = createAction('" . constant . "_ERROR');"
    \ ]

  let block = join(lines, "\n")

  put =block
endfunction

function! s:SearchForActionName(name) abort
  if exists("a:name") && len(a:name)
    silent! exec "normal /" . a:name . "<CR>"
  endif
endfunction

function! s:AddCloseAbbrev() abort
  command! -buffer -nargs=0 Q tabclose
  cabbrev <buffer> q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Q' : 'q')<CR>
endfunction

function! s:ViewAction(name) abort
  let file = a:name
  " let [file, action] = split(a:name, '\.')
  let cwd = getcwd()
  let root = stridx(cwd, "/src") > -1 ? cwd : cwd . "/src"

  exec "tabe " . root . "/hooks/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)
  let left = winnr()

  exec "vsp " . root . "/store/effects/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)
  exec "sp " . root . "/store/actions/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)
  exec "sp " . root . "/store/selectors/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)

  exec left . "wincmd w"

  exec "sp " . root . "/store/reducers/" . file . ".js"
  call s:AddCloseAbbrev()
  " call s:SearchForActionName(action)

  " set hls
endfunction

function! s:MakeSpec(...) abort
  let fname = expand("%:.:r") . ".spec." . expand("%:e")
  exec "vsp" fname
  if !filereadable(fname) && a:0 > 0
    exec "Contemplate" a:1
  endif
endfunction

function! s:SetAlt() abort
  if has_key(b:, 'alt_testfile')
    return
  endif

  let testfile = expand("%:.:r") . ".spec." . expand("%:e")
  if filereadable(testfile)
    let b:alt_testfile = testfile
    exec "nnoremap <buffer> <leader>sp :vsp" testfile . "<CR>"
  else
    nnoremap <buffer> <leader>sp :Spec<space>
  endif
endfunction

function! s:SetupJS() abort
  command! -buffer -nargs=1 Action call s:DoAction(<f-args>)
  command! -buffer -nargs=1 ViewAction call s:ViewAction(<f-args>)
  command! -buffer -nargs=? -complete=customlist,contemplate#complete Spec call s:MakeSpec(<f-args>)
  command! -buffer -nargs=0 SetAlt call s:SetAlt()

  nnoremap <buffer> <leader>j :Jest<CR>
  nnoremap <buffer> <leader>sa :SetAlt<CR>
endfunction

augroup javascript_environment
  au!
  au FileType javascript,javascript.jsx,typescript,typescript.tsx call s:SetupJS()
  au BufEnter *.js,*.jsx,*.ts,*.tsx call s:SetAlt()
augroup END

function! s:Lint(...) abort
  let scriptTarget = a:0 > 0 ? a:1 : 'lint'
  exec "set makeprg=npm\\\ run\\\ " . scriptTarget . "\\\ --silent\\\ --\\\ --quiet\\\ --format\\\ compact"
  set errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ Error\ -\ %m
  make
  copen
endfunction

function! s:LintProject(...) abort
  if a:0 > 0
    let pathname = "apps/" . a:1
    if !isdirectory(pathname)
      let pathname = "libs/" . a:1
    endif
  else
    let pathname = join(split(expand("%"), '/')[0:1], '/')
  endif

  let cwd = getcwd()

  exec "set makeprg=eslint\\\ " . pathname . "/src/**/*.ts\\\ --quiet\\\ --format\\\ compact"
  set errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ Error\ -\ %m
  make
endfunction

function! s:NxComplete(lead, ...)
  let lead = a:lead
  let paths = split(globpath("libs", lead . "*"), "\n")
  let paths += split(globpath("apps", lead . "*"), "\n")
  return map(paths, 'split(v:val, "/")[1]')
endfunction

command! -nargs=? Lint call s:Lint(<f-args>)
command! -nargs=? -complete=customlist,s:NxComplete LintProject call s:LintProject(<f-args>)
