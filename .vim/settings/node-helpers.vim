function! ExtractRequiredFilename()
  let required = matchlist(getline('.'), "require(['\"]\\([^'\"]\\+\\)['\"])")
  let imported = matchlist(getline('.'), "import\\s\\([a-zA-Z0-9_$ s{}-]\\+\\sfrom\\s\\)\\?['\"]\\([^'\"]\\+\\)['\"]")
  let lessimport = matchlist(getline('.'), "@import \"\\([^\"]\\+\\)\";")

  if len(required) > 1
    return required[1]
  elseif len(imported) > 1
    return empty(imported[2]) ? imported[1] : imported[2]
  elseif len(lessimport)
    return lessimport[1]
  endif
endfunction

function! LineContainsRequire()
  return LineMatches("require([^)]\\+)")
endfunction

function! LineContainsImport()
  return LineMatches("import")
endfunction

function! NodeRequireTree(path, ...)
  " If this is already a full path, use that
  if fnamemodify(a:path, ":e")
    if PathExists(a:path)
      return a:path
    else
      return
    endif
  endif

  " Get any files that match with any extension
  let matched = TryNodeExtensions(a:path)
  " If we found one, end here
  if !empty(matched)
    return matched
  endif

  " If not, see if this path is a directory, and try
  " index files inside that
  if PathExists(a:path)
    let matched = TryNodeExtensions(a:path . "/index")
    if !empty(matched)
      return matched
    else
      return
    endif
  endif

  " If the original required file was passed, try looking it up in
  " node_modules
  if a:0
    let orig = a:1
    let newPath = substitute(Findup("package.json"), "/package.json$", "/node_modules/" . orig, "")
    if match(orig, "/") == -1
      let newPath .= "/" . GetPackageMain(newPath)
    endif

    return NodeRequireTree(newPath)
  endif
endfunction

function! TryNodeExtensions(path)
  let matches = glob(a:path . "*", 0, 1)
  if len(matches) > 0
    let priority = ["js", "json", "coffee", "yml", "css", "less", "md"]
    for ext in priority
      let maybeMatch = match(matches, "\." . ext . "$")
      if maybeMatch > -1
        return matches[maybeMatch]
      endif
    endfor
    
    return matches[0]
  endif
endfunction

function! GetPackageMain(module)
  silent return system("node -e \"process.stdout.write(require('" . a:module . "/package.json').main)\"")
endfunction
