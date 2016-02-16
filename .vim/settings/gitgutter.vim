let g:gitgutter_map_keys = 0
let g:gitgutter_diff_args = '-w'

" git next/previous (jump to next/prev hunk)
nnoremap <leader>gn <Plug>GitGutterNextHunk
nnoremap <leader>gn <Plug>GitGutterPrevHunk

" git stage/revert
nnoremap <Leader>gs <Plug>GitGutterStageHunk
nnoremap <Leader>gr <Plug>GitGutterRevertHunk

" git preview change
nnoremap <leader>gp <Plug>GitGutterPreviewHunk 

" toggle gitgutter/line highlights
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gl :GitGutterLineHighlightsToggle<CR>
