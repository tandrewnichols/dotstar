autocmd QuickFixCmdPost *grep* cwindow

function! s:GitWrapper(action)
  silent exec ":silent Git" a:action
  redraw!
endfunction

function! s:OpenDirty()
  let files = split(system('git ls-files -m'), '\n')
  for file in files
    silent exec "e" file
  endfor
  redraw!
endfunction

function! s:GetGitBranches(lead, ...) abort
  let root = projectroot#get()
  let paths = globpath(root, a:lead . "*", 0, 1)
  let paths = map(paths, {i,p -> isdirectory(p) ? p . '/' : p})
  let paths = map(paths, {i,p -> substitute(p, root . '/', '', '')})

  if stridx(a:lead, '/') == -1
    let branches = systemlist('git branch')
    let branches = map(branches, {i,b -> trim(b)})
    let branches = filter(branches, {i,b -> b =~ '^' . a:lead})
    return branches + paths
  endif

  return paths
endfunction

command! -nargs=0 Gstage call <SID>GitWrapper('add ' . expand("%:p"))
command! -nargs=0 Gadd call <SID>GitWrapper('a')
command! -nargs=0 Gunstage call <SID>GitWrapper('reset ' . expand("%:p"))
command! -nargs=0 Gwip call <SID>GitWrapper('wip')
command! -nargs=0 Gnana call <SID>GitWrapper('nana')
command! -nargs=? Gstash call <SID>GitWrapper("stash save -u <f-args>")
command! -nargs=0 Gpop call <SID>GitWrapper('stash pop')
command! -nargs=0 Gdrop call <SID>GitWrapper('stash drop')
command! -nargs=1 Gapply call <SID>GitWrapper("stash apply <f-args>")
command! -nargs=0 Gdirty call <SID>OpenDirty()
command! -nargs=0 Gnuke call <SID>GitWrapper('nuke')
command! -nargs=0 Gconf e ~/.gitconfig
command! -nargs=0 Gours call <SID>GitWrapper('checkout --ours ' . expand("%:p"))
command! -nargs=0 Gtheirs call <SID>GitWrapper('checkout --theirs ' . expand("%:p"))
command! -nargs=* -complete=customlist,<SID>GetGitBranches Gcheckout call <SID>GitWrapper('checkout <args>')

" Related, but not strictly git
command! -nargs=0 Push silent call system('push') | redraw! | echo "Changes pushed"
command! -nargs=1 Br silent call system('br <args>') | redraw! | echo "Switched to new branch <args>"
command! -nargs=0 Pr silent call system('pr') | redraw!
command! -nargs=0 Ci silent call system('ci') | redraw!
command! -nargs=0 Master silent call system('master') | redraw!

nnoremap <silent> <expr> <leader>gs bufwinnr('.git/index') > -1 ? ':close <C-r>=(bufwinnr(".git/index"))<CR><CR>' : ':Gstatus<CR>'
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Push<CR>
nnoremap <silent> <leader>ga :Gstage<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gu :Gunstage<CR>

function! s:ReopenStatus() abort
  if system('git status') !~ 'nothing to commit'
    Gstatus
  endif
endfunction

function! s:HandleGitCommit() abort
  cnoreabbrev <buffer> wq :silent! wq<CR>:call <SID>ReopenStatus()<CR>
endfunction

function! ReturnToStatus(cmd) abort
  exec a:cmd
  let num = bufwinnr('.git/index')
  exec num . "wincmd w"
endfunction

function! s:CreateReturnToStatusMapping() abort
  exec "cnoreabbrev <expr> <buffer> wq (getcmdtype()==':' && getcmdpos() < 4 ? 'call ReturnToStatus(''' . getcmdline() . ''')' : getcmdline())"
  exec "cnoreabbrev <expr> <buffer> q (getcmdtype()==':' && getcmdpos() < 3 ? 'call ReturnToStatus(''' . getcmdline() . ''')' : getcmdline())"
endfunction

augroup GitCommit
  au!
  au Filetype gitcommit call s:HandleGitCommit()
  au BufEnter fugitive://* call s:CreateReturnToStatusMapping()
augroup END
