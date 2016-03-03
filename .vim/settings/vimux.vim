function! Mgrep(...)
  let text = a:0 == 1 ? a:1 : expand("<cword>")
  let where = a:0 == 2 ? a:2 : projectroot#guess()
  call VimuxRunCommand('mgrep ' . text . ' ' . where)
endfunction

let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"
nnoremap <leader>ni :exec ":call VimuxRunCommand('npm i --save '.expand('<cfile>'))"<CR>
nnoremap <leader>nd :exec ":call VimuxRunCommand('npm i --save-dev '.expand('<cfile>'))"<CR>
nnoremap <leader>nr :exec ":call VimuxRunCommand('npm r --save '.expand('<cfile>'))"<CR>
nnoremap <leader>mg :call Mgrep()<CR>
