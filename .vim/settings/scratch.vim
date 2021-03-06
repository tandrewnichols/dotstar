"
" Open command output in scratch buffer
" Type is one of new, vnew, tabe
"
function! s:Scratch (type, command, ...)
  redir => lines
  let saveMore = &more
  set nomore
  silent execute a:command
  redir END
  let &more = saveMore
  call feedkeys("\<cr>")
  exe a:type . " | setlocal buftype=nofile bufhidden=hide noswapfile"
  put=lines
  if a:0 > 0
    execute 'vglobal/'.a:1.'/delete'
  endif
  if a:command == 'scriptnames'
    %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
  endif
  silent %substitute/\%^\_s*\n\|\_s*\%$
  0
endfunction
 
command! -nargs=? Scriptnames call <SID>Scratch('tabe', 'scriptnames', <f-args>)
command! -nargs=+ Scratch call <SID>Scratch('new', <f-args>)
command! -nargs=+ Tscratch call <SID>Scratch('tabe', <f-args>)
command! -nargs=+ Vscratch call <SID>Scratch('vnew', <f-args>)

function! s:GetSuggestion()
  let letter = GetUserInput()
  if letter != ""
    execute ':Vscratch :nmap <space>' . letter
  endif
endfunction

function! Mgrep(what, where)
  vnew | setlocal buftype=nofile bufhidden=hide noswapfile 
  execute ":read !mgrep " . a:what . " " . a:where
endfunction

command! -nargs=* -complete=shellcmd Cap vnew | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
