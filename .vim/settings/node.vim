" Resolve a path like ../../foo.js relative to "from"
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

" If the file has an extension, return as is; otherwise add .js
function! AddJSExtension(file)
  return empty(fnamemodify(a:file, ':e')) ? a:file.'.js' : a:file
endfunction

" Instead of throwing when the file under cursor doesn't exist, just open
" it anyway, relying on MkNonExDir to create any directories
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
