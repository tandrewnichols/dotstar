function! s:OpenCheat()
  vert pedit ~/.vim/cheatsheet.vim
  wincmd P
  wincmd =
  augroup SetPclose
    au BufLeave <buffer> pclose | au! SetPclose
  augroup END
endfunction
command! -bang Cheat call <SID>OpenCheat()
