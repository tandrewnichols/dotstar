function! OpenEmbeddedFile(subroot, ...)
  let type = a:0 ? a:1 : 'tabe'
  execute type . " ".projectroot#guess(). "/" . a:subroot . "/" . expand("<cfile>")
endfunction

function! s:FindMatchingAngularService(serv, type)
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
  endif
endfunction

function! s:FindMatchingAngularController(cont, type)
  silent let controller = system("mgrep " . a:cont . " -l " . projectroot#guess() . "/client/app/js/controllers")
  execute a:type . " " . controller
endfunction

" TODO: coalesce these into a single <leader>ng command that picks the right thing based on context
" -------------------------------------------------------------------------------------------------

" Open an angular template under cursor
nnoremap <leader>ng :call OpenEmbeddedFile("client/app/templates", "tabe")<CR>

" Open an angular service
nnoremap <leader>srv :call <SID>FindMatchingAngularService(expand("<cword>"), "tabe")<CR>

" Open an angular controller in an html file
nnoremap <leader>cont :call <SID>FindMatchingAngularController(expand("<cword>"), "tabe")<CR> 
