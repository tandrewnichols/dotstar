" Open an angular template under cursor
nnoremap <leader>ng :let myfile=expand("<cfile>")<CR>:execute("tabe ".projectroot#guess()."/client/app/templates/".myfile)<CR>
