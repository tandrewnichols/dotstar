" Change .json to two space indents
nnoremap <leader>json ggdG:r ! node -e "console.log(JSON.stringify(require('%'), null, 2))"<CR>
