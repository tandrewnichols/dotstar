" Rearrange splits
nnoremap <leader><right> <C-w>J
nnoremap <leader><down> <C-w>L
nnoremap <leader><up> <C-w>K
nnoremap <leader><left> <C-w>H
nnoremap <leader>T <C-w>T

" Put current buffer in memory to open differenly
nnoremap <leader>= :let g:curbuf = bufnr('%')<CR>:bun<CR>

function! s:OpenCurBuf(cmd)
  if exists("g:curbuf")
    exec a:cmd g:curbuf
    unlet g:curbuf
  endif
endfunction

" Open memory buffer in vertical or horizontal split
nnoremap <leader>V :call <sid>OpenCurBuf('vert sb')<CR>
nnoremap <leader>H :call <sid>OpenCurBuf('sb')<CR>

" Shorter and more useful explore commands
command! -bang Ex :exec "Explore" . <bang> . "<CR>"
command! -bang Vex :exec "Vexplore" . !<bang> . "<CR>"
command! -bang Hex :exec "Hexplore" . <bang> . "<CR>"
command! -bang Sex :exec "Sexplore" . <bang> . "<CR>"
command! -bang Tex :call <sid>HandleTexplore(<bang>)<CR>

" Open texplore in the backgroun
function! s:HandleTexplore(background) abort
  if !a:background
    Texplore
  else
    let winid = win_getid()
    let pos = getpos('.')
    Texplore
    call win_gotoid(winid)
    call setpos('.', pos)
  endif
endfunction

" Go to next tab
nnoremap <Tab> gt

" Go to previous tab
nnoremap <S-Tab> gT

" Open multiple files at once in new tabs.
" This eschews the use of `args <globs>` followed
" by `tab all` as that doesn't preserve existing
" splits, moving them to new tabs as well
function! s:OpenAll(type, ...)
  " Save the current window so we can return to it
  let winid = win_getid()
  " For each glob passed in
  for glob in a:000
    " Expand the glob and iterate over each file returned
    for filename in glob(glob, v:false, v:true)
      " Open each file in tab
      silent! exec a:type filename
    endfor
  endfor
  " Return to initial window
  call win_gotoid(winid)
endfunction

command! -nargs=+ -complete=file O call s:OpenAll('tabe', <f-args>)
command! -nargs=+ -complete=file Ot call s:OpenAll('tabe', <f-args>)
command! -nargs=+ -complete=file Ov call s:OpenAll('vsp', <f-args>)
command! -nargs=+ -complete=file Os call s:OpenAll('sp', <f-args>)
command! -nargs=+ -complete=file Oe call s:OpenAll('e', <f-args>)
command! -nargs=+ -complete=file Op call s:OpenAll('ped', <f-args>)
