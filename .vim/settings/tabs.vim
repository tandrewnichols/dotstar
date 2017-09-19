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
