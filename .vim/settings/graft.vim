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
  return substitute(split(expand("<cWORD>"), '\.')[0], '[^a-zA-Z0-9_]*', '', 'g')
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

function! FindMatchingAngularController(cont, type)
  silent let controller = system("mgrep " . a:cont . " -l " . projectroot#guess() . "/client/app/js/controllers")
  execute a:type . " " . controller
endfunction

function! FindMatchingAngularService(serv, type, ...)
  " Get the service name dasherized
  let service = KebabCase(a:serv)
  " Fileroot will be the path to the services directory
  let fileroot = projectroot#guess() . "/client/app/js/services/"
  " Absolute filepath of the supposed service
  let filepath = fileroot . service . ".js"
  " If it doesn't exist, it's probably because
  "   a) It's a built-in service, like $scope or $document
  "   b) We named it something stupid, i.e. Ditto -> ditto-scan.js
  if !filereadable(filepath)
    " Get all service filenames in the service directory that match the original word under cursor.
    " e.g. Look for <root>/client/app/js/services/*<orig-service-name>*.js
    let suggestions = split(globpath(fileroot, "*" . fnamemodify(service, ":r") . "*.js"), "\n")
    for suggestion in suggestions
      " Get the file contents of each file in turn
      silent let contents = system("cat " . suggestion)
      " Check to see if the contents of the file contain "factory('<orig-service-name'"
      if match(contents, "factory('" . a:serv . "'") > -1
        " When we find the right file, stop looping
        let filepath = suggestion
        break
      endif
    endfor
  endif
  
  " If we found a file, open it
  if filereadable(filepath)
    execute a:type . " " . filepath
    if a:0
      set hlsearch
      call search('.\zs' . a:1 . '\ze\( =\|:\) ', 'e')
    endif
  endif
endfunction

function! OpenEmbeddedFile(subroot, ...)
  let type = a:0 ? a:1 : 'tabe'
  execute type . " ".projectroot#guess(). "/" . a:subroot . "/" . expand("<cfile>")
endfunction

function! s:GetContextOfWord(...)
  let curword = expand("<cword>")
  let curWORD = expand("<cWORD>")
  let variable = GetVariableUnderCursor()
  let curfile = expand("<cfile>")
  let file = expand("%:p:h")

  " If we're in the client directory
  if match(file, "manta-frontend/client") > -1
    let view = a:0 ? a:1 : "tabe"
    " If the cursor is on a service or controller
    if variable == curword
      " Controllers SHOULD all have "Controller" in them
      if match(variable, "Controller") > -1
        call FindMatchingAngularController(curword, view)
      else
        call FindMatchingAngularService(curword, view)
      endif
    " If the cursor is on a variable, <cfile> and <cword> are the same,
    " so if they're not the same, the cursor is on a filename
    elseif match(curWORD, "template") > -1
      call OpenEmbeddedFile("client/app/templates", view)
    " Otherwise, we're on a property of a service
    else
      call FindMatchingAngularService(variable, view, curword)
    endif
  elseif match(file, "manta-frontend/server") > -1
    if match(curWORD, 'require') > -1
      let view = a:0 ? a:1 : 'NodeTabGotoFile'
      call NodeGotoOrCreateNew(view)
    elseif variable == curword
      call OpenVariableFile()
    else
      call JumpToPropertyInExport()
    endif
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
