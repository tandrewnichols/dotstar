"let s:CORE_MODULES = ["_debugger", "_http_agent", "_http_client",
	"\ "_http_common", "_http_incoming", "_http_outgoing", "_http_server",
	"\ "_linklist", "_stream_duplex", "_stream_passthrough", "_stream_readable",
	"\ "_stream_transform", "_stream_writable", "_tls_legacy", "_tls_wrap",
	"\ "assert", "buffer", "child_process", "cluster", "console", "constants",
	"\ "crypto", "dgram", "dns", "domain", "events", "freelist", "fs", "http",
	"\ "https", "module", "net", "node", "os", "path", "punycode", "querystring",
	"\ "readline", "repl", "smalloc", "stream", "string_decoder", "sys",
	"\ "timers", "tls", "tty", "url", "util", "vm", "zlib"]

"function! graft#node#RequireContext()
  "if graft#node#LineContainsRequire() || graft#node#LineContainsImport()
    "let req = graft#node#ExtractRequiredFilename()
    "return graft#node#ResolveRequiredFile(req)
  "endif
"endfunction

"function! graft#node#VariableContext()
  "let [ var, prop ] = graft#node#GetVariableUnderCursor()
  "let line = graft#node#FindVariableDefinition(var)
  "if line != 0
    "let req = graft#node#ExtractRequiredFilenameFrom(getline(line))
    "return [ graft#node#ResolveRequiredFile(req), prop ]
  "endif
"endfunction

"function! graft#node#GetVariableUnderCursor()
  "let cword = expand("<cword>")
  "let curIsk = &iskeyword
  "setlocal iskeyword+=\.
  "let jsword = split(expand("<cword>"), '\.')
  "let &iskeyword = curIsk

  "if cword == jsword[0]
    "return [ cword, '' ]
  "else
    "return [ jsword[0], cword ]
  "endif
"endfunction

"function! graft#node#ExtractRequiredFilename()
  "return graft#node#ExtractRequiredFilenameFrom(getline('.'))
"endfunction

"function! graft#node#ExtractRequiredFilenameFrom(line)
  "let required = matchlist(a:line, "require[( ]['\"]\\([^'\"]\\+\\)['\"])\\?")
  "let imported = matchlist(a:line, "import\\s\\([a-zA-Z0-9_$ s{}-]\\+\\sfrom\\s\\)\\?['\"]\\([^'\"]\\+\\)['\"]")
  "let lessimport = matchlist(a:line, "@import \"\\([^\"]\\+\\)\";")

  "if len(required) > 1
    "return required[1]
  "elseif len(imported) > 1
    "return empty(imported[2]) ? imported[1] : imported[2]
  "elseif len(lessimport)
    "return lessimport[1]
  "endif
"endfunction

"function! graft#node#LineContainsRequire()
  "return graft#helpers#LineMatches("require")
"endfunction

"function! graft#node#LineContainsImport()
  "return graft#helpers#LineMatches("import")
"endfunction

"function! graft#node#NodeRequireTree(path, ...)
  "let path = a:path
  "" If this is already a full path, use that
  "if graft#helpers#HasExtension(path)
    "return path
  "endif

  "" Trim an end slash so we don't have to worry about
  "" ending up with double slashes in paths
  "let path = graft#helpers#TrimTrailingSlash(path)

  "" Get any files that match with any extension
  "let matched = graft#node#TryNodeExtensions(path)

  "" If we found one, end here
  "if !empty(matched)
    "return matched
  "endif

  "" If not, see if this path is a directory, and try
  "" index files inside that
  "if isdirectory(path)
    "let matched = graft#node#TryNodeExtensions(path . "/index")
    "if !empty(matched)
      "return matched
    "else
      "return ""
    "endif
  "endif

  "if a:0 > 0
    "let orig = a:1
    "" If the original file has a dot at the beginning and we haven't
    "" foudn it yet, it's a local file that hasn't been created
    "if graft#helpers#IsRelativeFilepath(orig)
      "" If the directory exists, add the js extension now
      "if isdirectory(fnamemodify(path, ":h"))
        "return graft#helpers#AddExtension(path, "js")

      "" If the directory doesn't exist but create missing dirs
      "" is turned on, create the missing directories, and then
      "" add the js extension
      "elseif exists("g:graft_create_missing_dirs")
        "call graft#helpers#CreateMissingDirs(path)
        "return graft#helpers#AddExtension(path, "js")

      "" If the directories don't exist and we're not autocreating
      "" them, do nothing here and don't keep processing.
      "else
        "return ""
      "endif

    "" If we're here, it should be that we're on a built-in module
    "else
      "return "http://rawgit.com/nodejs/node/" . graft#node#GetVersion() . "/lib/" . orig . ".js"
    "endif
  "endif
"endfunction

"function! graft#node#TryNodeExtensions(path)
  "let priority = ["js", "json", "coffee", "es6", "es", "jsx", "yml", "css", "less", "md"]
  "let matches = glob(a:path . "\.{" . join(priority, ",") . "}", 0, 1)
  "if len(matches) > 0
    "for ext in priority
      "let maybeMatch = match(matches, "\." . ext . "$")
      "if maybeMatch > -1
        "return matches[maybeMatch]
      "endif
    "endfor
    
    "return matches[0]
  "endif
  "return ""
"endfunction

"function! graft#node#GetPackageMain(module)
  "silent return system("node -e \"var pkg = require('" . a:module . "/package.json'); process.stdout.write(pkg.main ? pkg.main : '')\"")
"endfunction

"function! graft#node#FindVariableDefinition(var)
  "let line = search(a:var . " = require", "n")
  "if (line == 0)
    "let line = search("import " . a:var, "nb")
  "endif
  "return line
"endfunction

"function! graft#node#ResolveRequiredFile(req)
  "if !empty(a:req)
    "let filename = graft#node#ResolveViaRequire(a:req)
    "if empty(filename) || !graft#helpers#HasPathSeparator(filename)
      "let filename = graft#helpers#ResolveRelativeToCurrentFile(a:req)
      "return graft#node#NodeRequireTree(filename, a:req)
    "else
      "return filename
    "endif
  "endif
"endfunction

"function! graft#node#FindRoot()
  "let pkg = graft#helpers#Findup("package.json")
  "return substitute(pkg, "/package.json$", "", "")
"endfunction

"function! graft#node#IsScopedPackage(module)
  "return a:module =~ "^@"
"endfunction

"function! graft#node#ResolveViaRequire(module)
  "silent return system("node -e \"try { var resolved = require.resolve('" . a:module . "'); process.stdout.write(resolved); } catch (e) { process.stdout.write('') }\"")
"endfunction

"function! graft#node#GetVersion()
  "silent return split(system("node --version"), "\n")[0]
"endfunction

"function! graft#node#IsCoreModule(module)
  "return index(s:CORE_MODULES, split(a:module, "/")[0]) == -1
"endfunction
