function! graft#node#RequireContext()
  if graft#node#LineContainsRequire() || graft#node#LineContainsImport()
    let req = graft#node#ExtractRequiredFilename()
    return graft#node#ResolveRequiredFile(req)
  endif
endfunction

function! graft#node#VariableContext()
  let [ var, prop ] = graft#node#GetVariableUnderCursor()
  let line = graft#node#FindVariableDefinition(var)
  if line != 0
    let req = graft#node#ExtractRequiredFilenameFrom(getline(line))
    return [ graft#node#ResolveRequiredFile(req), prop ]
  endif
endfunction

function! graft#node#GetVariableUnderCursor()
  let cword = expand("<cword>")
  let curIsk = &iskeyword
  setlocal iskeyword+=\.
  let jsword = split(expand("<cword>"), '\.')
  let &iskeyword = curIsk

  if cword == jsword[0]
    return [ cword, '' ]
  else
    return [ jsword[0], cword ]
  endif
endfunction

function! graft#node#ExtractRequiredFilename()
  return graft#node#ExtractRequiredFilenameFrom(getline('.'))
endfunction

function! graft#node#ExtractRequiredFilenameFrom(line)
  let required = matchlist(a:line, "require[( ]['\"]\\([^'\"]\\+\\)['\"])\\?")
  let imported = matchlist(a:line, "import\\s\\([a-zA-Z0-9_$ s{}-]\\+\\sfrom\\s\\)\\?['\"]\\([^'\"]\\+\\)['\"]")
  let lessimport = matchlist(a:line, "@import \"\\([^\"]\\+\\)\";")

  if len(required) > 1
    return required[1]
  elseif len(imported) > 1
    return empty(imported[2]) ? imported[1] : imported[2]
  elseif len(lessimport)
    return lessimport[1]
  endif
endfunction

function! graft#node#LineContainsRequire()
  return graft#helpers#LineMatches("require")
endfunction

function! graft#node#LineContainsImport()
  return graft#helpers#LineMatches("import")
endfunction

function! graft#node#NodeRequireTree(path, ...)
  let path = a:path
  " If this is already a full path, use that
  if graft#helpers#HasExtension(path)
    return path
  endif

  if path =~ "/$"
    let path = substitute(path, "/$", "", "")
  endif

  " Get any files that match with any extension
  let matched = graft#node#TryNodeExtensions(path)

  " If we found one, end here
  if !empty(matched)
    return matched
  endif

  " If not, see if this path is a directory, and try
  " index files inside that
  if graft#helpers#PathExists(path)
    let matched = graft#node#TryNodeExtensions(path . "/index")
    if !empty(matched)
      return matched
    else
      return ""
    endif
  endif

  " If the original required file was passed:
  "   1) if it starts with "." it's a local file that just
  "     hasn't been created yet. In that case, just let
  "     MkNonExDir create the file (defaulting to .js extension)
  "   2) if it doesn't start with ".", it's a node module. Try
  "     first to look it up in node_modules, but if it's not there
  "     it's probably a built-in module. Do nothing in that case.
  if a:0 > 0
    let orig = a:1
    
    if graft#helpers#IsRelativeFilepath(orig)
      return graft#helpers#AddExtension(path, "js")
    else
      let newPath = graft#node#FindRoot() . "/node_modules/" . orig
      if !graft#helpers#HasPathSeparator(orig)
        let main = graft#node#GetPackageMain(orig)
        if empty(main)
          " If the package doesn't specify "main", just open the
          " directory. Not much more we can do.
          return newPath
        else
          let newPath .= "/" . main
        endif
      endif
    endif

    return graft#node#NodeRequireTree(newPath)
  endif
endfunction

function! graft#node#TryNodeExtensions(path)
  let priority = ["js", "json", "coffee", "es6", "es", "jsx", "yml", "css", "less", "md"]
  let matches = glob(a:path . "\.{" . join(priority, ",") . "}", 0, 1)
  if len(matches) > 0
    for ext in priority
      let maybeMatch = match(matches, "\." . ext . "$")
      if maybeMatch > -1
        return matches[maybeMatch]
      endif
    endfor
    
    return matches[0]
  endif
  return ""
endfunction

function! graft#node#GetPackageMain(module)
  silent return system("node -e \"var pkg = require('" . a:module . "/package.json'); process.stdout.write(pkg.main ? pkg.main : '')\"")
endfunction

function! graft#node#FindVariableDefinition(var)
  let line = search(a:var . " = require", "n")
  if (line == 0)
    let line = search("import " . a:var, "nb")
  endif
  return line
endfunction

function! graft#node#ResolveRequiredFile(req)
  if !empty(a:req)
    let filename = graft#helpers#ResolveRelativeToCurrentFile(a:req)
    return graft#node#NodeRequireTree(filename, a:req)
  endif
endfunction

function! graft#node#FindRoot()
  let pkg = graft#helpers#Findup("package.json")
  return substitute(pkg, "/package.json$", "", "")
endfunction
