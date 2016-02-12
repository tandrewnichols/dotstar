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
 
command! -nargs=? Scriptnames call <sid>Scratch('tabe', 'scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch('new', <f-args>)
command! -nargs=+ Tscratch call <sid>Scratch('tabe', <f-args>)
command! -nargs=+ Vscratch call <sid>Scratch('vnew', <f-args>)

function! s:GetSuggestion()
  let letter = GetUserInput()
  if letter != ""
    execute ':Vscratch :nmap <space>' . letter
  endif
endfunction

" Open :nmap in scratch buffer
nnoremap <leader>nmap :Vscratch :nmap<CR>
nnoremap <silent> <leader>sug :call <SID>GetSuggestion()<CR>
