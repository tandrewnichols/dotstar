" Format entire file (no longer JSON specific, but does work for json)
nnoremap <leader>= ggvG=
nnoremap <leader>dj :%s/\v"([^"]+)"\s*:/\1:/g<CR>

function! s:FormatAsJson()
  :%!python -m json.tool
  setf json
  normal! ggvG=
endfunction

command! -nargs=0 Json :call s:FormatAsJson()
