let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"
nnoremap <leader>ni :exec ":call VimuxRunCommand('npm i --save '.expand('<cfile>'))"<CR>
nnoremap <leader>nd :exec ":call VimuxRunCommand('npm i --save-dev '.expand('<cfile>'))"<CR>
nnoremap <leader>nr :exec ":call VimuxRunCommand('npm r --save '.expand('<cfile>'))"<CR>
nnoremap <leader>nt :exec ":call VimuxRunCommand('npm test')"<CR>
nnoremap <leader>ntw :exec ":call VimuxRunCommand('npm run test:watch')"<CR>

command! -nargs=* Grunt call VimuxRunCommand('grunt <args>')

nnoremap <leader>vc :call VimuxCloseRunner()<CR>
