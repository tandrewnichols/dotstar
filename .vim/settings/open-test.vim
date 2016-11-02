function! s:OpenTestForCurrentBuffer(where)
  let root = projectroot#guess(expand("%:p"))
  let full = expand("%:p")
  if RootDirName() ==? 'manta-frontend' && (full =~? 'client/app/js/' || full =~? 'server/routes' || full =~? 'server/lib' || full =~? 'server/common' || full =~? 'server/app.js')
    let subroot = ImmediateRootSubDir()
    let root = root . "/" . subroot
    let filename = expand("%:t:r")
    let filehead = fnamemodify(full, ":h")
    let extra = subroot ==? 'client' ? "/app/js" : "/"
    let dirpath = substitute(filehead . "/", root . extra, "", "")
    " In the case of server/app.js, we need an extra '/' or we end up with
    " specfilename-spec.coffee instead of spec/filename-spec.coffee
    if dirpath == ""
      let dirpath = "/"
    endif

    if dirpath !~ "^/"
      let dirpath = "/" . dirpath
    endif
    execute a:where . " " . root . "/spec" . dirpath . filename . "-spec.coffee"
  endif
endfunction

command! -nargs=0 T call <SID>OpenTestForCurrentBuffer("tabe")
command! -nargs=0 Tv call <SID>OpenTestForCurrentBuffer("vnew")
command! -nargs=0 Ts call <SID>OpenTestForCurrentBuffer("new")

nnoremap <leader>tt :T<CR>
nnoremap <leader>tv :Tv<CR>
nnoremap <leader>ts :Ts<CR>
