" Go to next mark
nnoremap <leader>j :call signature#GotoMark("pos", "next", "spot")<CR>

" Go to previous mark
nnoremap <leader>k :call signature#GotoMark("pos", "prev", "spot")<CR>

" Go to next marked line
nnoremap <leader>J :call signature#GotoMark("pos", "next", "line")<CR>

" Go to prevoius marked line
nnoremap <leader>K :call signature#GotoMark("pos", "prev", "line")<CR>

" Go to next alphabetical mark
nnoremap <leader>aj :call signature#GotoMark("alpha", "next", "spot")<CR>

" Go to previous alphabetical mark
nnoremap <leader>ak :call signature#GotoMark("alpha", "prev", "spot")<CR>

" Go to next alphabetical marked line
nnoremap <leader>Aj :call signature#GotoMark("alpha", "next", "line")<CR>

" Go to previous alphabetical marked line
nnoremap <leader>Ak :call signature#GotoMark("alpha", "prev", "line")<CR>

" Go to next marker of this type
nnoremap <leader>tj :call signature#GotoMarker("next")<CR>

" Go to previous marker of this type
nnoremap <leader>tk :call signature#GotoMarker("prev")<CR>
