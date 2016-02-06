"
" Google current word
"
function! GoogleSearch()
  silent! exec "silent! !google-chrome \"http://google.com/search?q=" . @g . "\" > /dev/null"
  redraw!
endfunction

vnoremap <leader>goo "gy<Esc>:call GoogleSearch()<CR>
nnoremap <leader>goo b"gye:call GoogleSearch()<CR>

"
" Open command output in scratch buffer
"
function! s:Scratch (command, ...)
  redir => lines
  let saveMore = &more
  set nomore
  silent execute a:command
  redir END
  let &more = saveMore
  call feedkeys("\<cr>")
  new | setlocal buftype=nofile bufhidden=hide noswapfile
  put=lines
  if a:0 > 0
    execute 'vglobal/'.a:1.'/delete'
  endif
  if a:command == 'scriptnames'
    %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
  endif
  silent %substitute/\%^\_s*\n\|\_s*\%$
  let height = line('$') + 3
  execute 'normal! z'.height."\<cr>"
  0
endfunction
 
command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)

"
" Auto-create missing parents directories when saving a file
"
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

"function s:RunGrunt()
  "let path=expand('%:p')
  "if  path=~'\/manta-frontend\/server.*\.js'
    "let file=split(path, 'manta-frontend/server/')[1]
  "endif
"endfunction

function! ResolveRelativePath(rel, from)
  let l:dir = isdirectory(a:from) ? a:from : fnamemodify(a:from, ":h")
  let l:parts = split(l:dir, '/')
  let l:newRel = []
  for part in split(a:rel, '/')
    if part == '..'
      let l:parts = parts[0:-2]
    else
      call add(newRel, part)
    endif
  endfor
  return join(parts, '/').'/'.join(newRel, '/')
endfunction

function! AddJSExtension(file)
  return empty(fnamemodify(a:file, ':e')) ? a:file.'.js' : a:file
endfunction

function! NodeGotoOrCreateNew(view)
  let l:view = empty(a:view) ? 'NodeTabGotoFile' : a:view
  silent execute "normal \<Plug>".view
  if v:errmsg =~ "E447"
    let l:fname = ResolveRelativePath(expand("<cword>"), expand("%:h"))
    let l:fname = AddJSExtension(l:fname)
    let l:viewport = GetCorrespondingViewportCommand(l:view)
    silent execute l:viewport." ".l:fname
  endif
endfunction

function! GetCorrespondingViewportCommand(plug)
  if a:plug == 'NodeTabGotoFile'
    return 'tabe'
  elseif a:plug == 'NodeVSplitGotoFile'
    return 'vsplit'
  elseif a:plug == 'NodeSplitGotoFile'
    return 'split'
  else
    return 'NodeGotoFile'
  endif
endfunction
