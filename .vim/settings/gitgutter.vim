let g:gitgutter_map_keys = 0
let g:gitgutter_diff_args = '-w'

" git next/previous (jump to next/prev hunk)
nnoremap <leader>Gn <Plug>GitGutterNextHunk
nnoremap <leader>Gn <Plug>GitGutterPrevHunk

" git stage/revert
nnoremap <Leader>Gs <Plug>GitGutterStageHunk
nnoremap <Leader>Gr <Plug>GitGutterRevertHunk

" git preview change
nnoremap <leader>Gp <Plug>GitGutterPreviewHunk

" toggle gitgutter/line highlights
nnoremap <leader>Gg :GitGutterToggle<CR>
nnoremap <leader>Gl :GitGutterLineHighlightsToggle<CR>
