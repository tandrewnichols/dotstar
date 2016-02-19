function! OpenEmbeddedFile(subroot, ...)
  let type = a:0 ? a:0 : 'tabe'
  execute type . " ".projectroot#guess(). "/" . a:subroot . "/" . expand("<cfile>")
endfunction
" Open an angular template under cursor
nnoremap <leader>ng :call OpenEmbeddedFile("client/app/templates")<CR>
