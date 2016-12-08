" Change .json to two space indents
nnoremap <leader>json ggdG:r ! node -e "console.log(JSON.stringify(require('%'), null, 2))"<CR>
nnoremap <leader>dj :%s/\v"([^"]+)":/\1:/g<CR>
