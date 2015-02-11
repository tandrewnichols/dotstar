"
" Google current word
"
function! GoogleSearch()
  silent! exec "silent! !google-chrome \"http://google.com/search?q=" . @g . "\" > /dev/null"
  redraw!
endfunction

vnoremap <leader>goo "gy<Esc>:call GoogleSearch()<CR>
nnoremap <leader>goo b"gye:call GoogleSearch()<CR>

"
" Open command output in scratch buffer
"
function! s:Scratch (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   execute a:command
   redir END
   let &more = saveMore
   call feedkeys("\<cr>")
   new | setlocal buftype=nofile bufhidden=hide noswapfile
   put=lines
   if a:0 > 0
      execute 'vglobal/'.a:1.'/delete'
   endif
   if a:command == 'scriptnames'
      %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
   endif
   silent %substitute/\%^\_s*\n\|\_s*\%$
   let height = line('$') + 3
   execute 'normal! z'.height."\<cr>"
   0
endfunction
 
command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)

"
" Auto-create missing parents directories when saving a file
"
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
