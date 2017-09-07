" Format entire file (no longer JSON specific, but does work for json)
nnoremap <leader>= ggvG=
nnoremap <leader>dj :%s/\v"([^"]+)"\s*:/\1:/g<CR>
