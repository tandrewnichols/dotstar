let g:gitgutter_map_keys = 0
let g:gitgutter_diff_args = '-w'

" git next/previous (jump to next/prev hunk)
nnoremap <leader>gn <Plug>GitGutterNextHunk
nnoremap <leader>gN <Plug>GitGutterPrevHunk

" git stage/revert
nnoremap <Leader>gS <Plug>GitGutterStageHunk
nnoremap <Leader>gr <Plug>GitGutterRevertHunk

" git preview change
nnoremap <leader>gP <Plug>GitGutterPreviewHunk

" toggle gitgutter/line highlights
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gL :GitGutterLineHighlightsToggle<CR>
