let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"
nnoremap <leader>ni :exec ":call VimuxRunCommand('npm i --save '.expand('<cfile>'))"<CR>
nnoremap <leader>nd :exec ":call VimuxRunCommand('npm i --save-dev '.expand('<cfile>'))"<CR>
nnoremap <leader>nr :exec ":call VimuxRunCommand('npm r --save '.expand('<cfile>'))"<CR>
