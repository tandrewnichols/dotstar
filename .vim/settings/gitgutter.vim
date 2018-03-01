let g:gitgutter_map_keys = 0
let g:gitgutter_diff_args = '-w'

" git next/previous (jump to next/prev hunk)
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" git stage/revert
nmap <Leader>gh <Plug>GitGutterStageHunk
vmap <leader>gh <Plug>GitGutterStageHunk
nmap <Leader>gr <Plug>GitGutterUndoHunk
vmap <leader>gr <Plug>GitGutterUndoHunk

omap ig <Plug>GitGutterTextObjectInnerPending
omap ag <Plug>GitGutterTextObjectOuterPending
xmap ig <Plug>GitGutterTextObjectInnerVisual
xmap ag <Plug>GitGutterTextObjectOuterVisual

" git preview change
nmap <leader>gP <Plug>GitGutterPreviewHunk

" toggle gitgutter/line highlights
nnoremap <leader>gg :GitGutterToggle<CR>
nnoremap <leader>gL :GitGutterLineHighlightsToggle<CR>
