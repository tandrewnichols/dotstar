nnoremap <leader>mv :exec ":Move ".input("New file name (relative to cwd)? ")<CR>
nnoremap <leader>rn :exec ":Rename ".input("New file name (relative to __dirname)? ")<CR>

" Remove current file and close buffer
nnoremap <leader>rm :Delete<Cr>
