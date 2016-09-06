"let s:CORE_URL_PREFIX = "http://rawgit.com/nodejs/node"
"let s:SUFFIX_PRIORITY = ["js", "json", "coffee", "es6", "es", "jsx", "yml", "css", "less", "md"]

"function! graft#node#strategies#RequireResolve(path, module)
  "" Don't try to require.resolve a built-in module, as that just
  "" returns the module name, which we'd then have to look for later
  "if !graft#node#IsCoreModule(a:module)
    "silent return system("node -e \"
      "\ try {
      "\   var Module = require('module');
      "\   var resolved = Module._resolveFilename('" . a:module . "', '" . expand("%:p") . "');
      "\   process.stdout.write(resolved);
      "\ } catch (e) {
      "\   process.stdout.write('')
      "\ }\"")
  "endif

  "return ""
"endfunction

"function! graft#node#strategies#AbsolutePath(path, module)
  "if graft#helpers#HasExtension(a:path)
    "return a:path
  "endif

  "return ""
"endfunction

"function! graft#node#strategies#ExistingLocalFile(path, module)
  "let matches = glob(a:path . "\.{" . join(s:SUFFIX_PRIORITY, ",") . "}", 0, 1)
  "if len(matches) > 0
    "for ext in s:SUFFIX_PRIORITY
      "let maybeMatch = match(matches, "\." . ext . "$")
      "if maybeMatch > -1
        "return matches[maybeMatch]
      "endif
    "endfor
    
    "return matches[0]
  "endif

  "return ""
"endfunction

"function! graft#node#strategies#ExistingLocalDirectory(path, module)
  "if isdirectory(a:path)
    "return graft#node#strategies#ExistingLocalFile(a:path . "/index")
  "endif

  "return ""
"endfunction

"function! graft#node#strategies#NewLocalFile(path, module)
  "if graft#helpers#IsRelativeFilepath(a:module)
    "" If the directory exists, add the js extension now
    "if isdirectory(fnamemodify(a:path, ":h"))
      "return graft#helpers#AddExtension(a:path, "js")

    "" If the directory doesn't exist but create missing dirs
    "" is turned on, create the missing directories, and then
    "" add the js extension
    "elseif exists("g:graft_create_missing_dirs")
      "call graft#helpers#CreateMissingDirs(a:path)
      "return graft#helpers#AddExtension(a:path, "js")
    "endif
  "endif

  "return ""
"endfunction
