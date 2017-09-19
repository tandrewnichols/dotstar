" Show git status
nnoremap <silent> <leader>gs :Gstatus<CR>

" Show git blame for current file in vsplit
nnoremap <silent> <leader>gb :Gblame<CR>

" Show git diff for current file in vsplit
nnoremap <silent> <leader>gd :Gdiff<CR>

" Git commit
nnoremap <silent> <leader>gc :Gcommit<CR>

" Git log
nnoremap <silent> <leader>gl :Glog<CR>

" Git push
nnoremap <silent> <leader>gp :Gpush<CR>

command! -nargs=0 Gstage :silent exec ":Git add " expand("%:.")
command! -nargs=0 Gunstage :silent exec ":Git reset " expand("%:.")

nnoremap <silent> <leader>ga :Gstage<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gu :Gunstage<CR>
