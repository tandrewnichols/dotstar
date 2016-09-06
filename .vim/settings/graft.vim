let g:graft_call_through = 0
nmap gf <Plug>GraftTabe
nmap <C-w>gf <Plug>GraftEdit

"---------------------------------------------------------"

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
  " If we're in the client directory
  "if match(file, "manta-frontend/client") > -1
    "let view = a:0 ? a:1 : "tabe"
    "" If the cursor is on a service or controller
    "if variable == curword
      "" Controllers SHOULD all have "Controller" in them
      "if match(variable, "Controller") > -1
        "call FindMatchingAngularController(curword, view)
      "else
        "call FindMatchingAngularService(curword, view)
      "endif
    "" If the cursor is on a variable, <cfile> and <cword> are the same,
    "" so if they're not the same, the cursor is on a filename
    "elseif match(curWORD, "include") > -1
      "call OpenEmbeddedFile("client/app/templates", view)
    "" Otherwise, we're on a property of a service
    "else
      "call FindMatchingAngularService(variable, view, curword)
    "endif
  "elseif match(file, "manta-frontend/server") > -1
    "if match(curWORD, 'require') > -1
      "let view = a:0 ? a:1 : 'NodeTabGotoFile'
      "call NodeGotoOrCreateNew(view)
    "elseif variable == curword
      "call OpenVariableFile()
    "else
      "call JumpToPropertyInExport()
    "endif
  "endif
endfunction
