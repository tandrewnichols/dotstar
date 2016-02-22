" Resolve a path like ../../foo.js relative to "from"
function! ResolveRelativePath(rel, from)
  let dir = isdirectory(a:from) ? a:from : fnamemodify(a:from, ":h")
  let parts = split(dir, '/')
  let newRel = []
  for part in split(a:rel, '/')
    if part == '.'
      continue
    endif
    if part == '..'
      let parts = parts[0:-2]
    else
      call add(newRel, part)
    endif
  endfor
  let prefix = len(parts) > 0 ? join(parts, '/').'/' : ''
  return prefix . join(newRel, '/')
endfunction

" If the file has an extension, return as is; otherwise add .js
function! AddJSExtension(file)
  return empty(fnamemodify(a:file, ':e')) ? a:file.'.js' : a:file
endfunction

" Instead of throwing when the file under cursor doesn't exist, just open
" it anyway, relying on MkNonExDir to create any directories
function! NodeGotoOrCreateNew(...)
  let l:view = a:0 ? a:1 : 'NodeTabGotoFile'
  silent execute "normal \<Plug>".view
  if v:errmsg =~ "E447"
    let l:fname = ResolveRelativePath(expand("<cfile>"), expand("%:h"))
    let l:fname = AddJSExtension(l:fname)
    let l:viewport = GetCorrespondingViewportCommand(l:view)
    silent execute l:viewport." ".l:fname
  endif
endfunction

" Get vim command based on node.vim plugin command
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

function! GetAllBufferText()
  return join(getline(1,'$'), "\n")
endfunction

function! GetVariableUnderCursor()
  return split(expand("<cWORD>"), '\.')[0]
endfunction

function! OpenVariableFile()
  let var = GetVariableUnderCursor()
  let text = GetAllBufferText()
  let file = matchstr(text, var . ' = require(''\zs[^)]\+\ze'')')
  let filepath = ResolveRelativePath(file, expand("%:h"))
  let fullpath = AddJSExtension(filepath)
  execute "tabe " . fullpath
endfunction

function! JumpToPropertyInExport()
  let prop = expand("<cword>")
  call OpenVariableFile()
  set hlsearch
  call search('.\zs' . prop . '\ze = ', 'e')
endfunction

function! s:GetContextOfWord(...)
  if match(expand("<cWORD>"), 'require') > -1
    let view = a:0 ? a:1 : 'NodeTabGotoFile'
    call NodeGotoOrCreateNew(view)
  elseif GetVariableUnderCursor() == expand("<cword>")
    call OpenVariableFile()
  else
    call JumpToPropertyInExport()
  endif
endfunction

" Make node.vim not map gf by setting plug. It runs
" is !hasmapto("<Plug>NodeGotoFile") before setting gf mappings
nmap <leader>req <Plug>NodeGotoFile

" Now define my own mappings that set up gf/K better (i.e. to work with
" non-existant files too)
nmap <silent> gf :call <SID>GetContextOfWord()<CR>
nmap <silent> K :call <SID>GetContextOfWord('NodeVSplitGotoFile')<CR>
nmap <silent> <C-W>f :call <SID>GetContextOfWord('NodeSplitGotoFile')<CR>
nmap <silent> <C-W>gf :call <SID>GetContextOfWord('NodeGotoFile')<CR>
"nmap <buffer> gf <Plug>NodeGotoFile
"nmap <buffer> <C-w>f <Plug>NodeSplitGotoFile
"nmap <buffer> <C-w><C-f> <Plug>NodeSplitGotoFile
"nmap <buffer> <C-w>gf <Plug>NodeTabGotoFile
