let g:submode_always_show_submode = 1
let g:submode_timeoutlen = 3000
let g:submode_keep_leaving_key = 1

" Tab mappings. Enter tab mode with gt (which I don't use).
call submode#enter_with('tabs', 'n', '', 'gt')
" Then use h/l to move tabs left and right and tab/shift-tab
" to switch between tabs
call submode#map('tabs', 'n', '', 'h', ':tabm -<CR>')
call submode#map('tabs', 'n', '', 'l', ':tabm +<CR>')
call submode#map('tabs', 'n', '', '<Tab>', 'gt')
call submode#map('tabs', 'n', '', '<S-Tab>', 'gT')

" Smart resizer (sort of)
function! HandleResizeContext(vertical, movingRightOrDown)
  " Basically, winnr() == winnr('$') when the active pane
  " is rightmost or bottommost
  if winnr() != winnr('$')
    if a:movingRightOrDown == 0
      execute a:vertical . "res -5"
    else
      execute a:vertical . "res +5"
    endif
  else
    if a:movingRightOrDown == 0
      execute a:vertical . "res +5"
    else
      execute a:vertical . "res -5"
    endif
  endif
endfunction

" Define vertical and horizontal resize modes
call submode#enter_with('vsize', 'n', '', '<C-w>>', ':call HandleResizeContext("vertical ", 1)<CR>')
call submode#enter_with('vsize', 'n', '', '<C-w><', ':call HandleResizeContext("vertical ", 0)<CR>')
call submode#enter_with('vsize', 'n', '', '<leader>+')
call submode#map('vsize', 'n', 's', 'h', ':call HandleResizeContext("vertical ", 0)<CR>')
call submode#map('vsize', 'n', 's', 'l', ':call HandleResizeContext("vertical ", 1)<CR>')
call submode#map('vsize', 'n', 's', '<', ':call HandleResizeContext("vertical ", 0)<CR>')
call submode#map('vsize', 'n', 's', '>', ':call HandleResizeContext("vertical ", 1)<CR>')
call submode#map('vsize', 'n', 's', '-', ':vertical res -5<CR>')
call submode#map('vsize', 'n', 's', '+', ':vertical res +5<CR>')
call submode#map('vsize', 'n', 's', '=', '<C-w>=')
call submode#map('vsize', 'n', 's', '<C-h>', '<C-w>h')
call submode#map('vsize', 'n', 's', '<C-l>', '<C-w>l')
call submode#map('vsize', 'n', 'sx', '<C-j>', '<C-w>j')
call submode#map('vsize', 'n', 'sx', '<C-k>', '<C-w>k')

call submode#enter_with('hsize', 'n', '' ,'<C-w>+', ':res +5<CR>')
call submode#enter_with('hsize', 'n', '' ,'<C-w>-', ':res -5<CR>')
call submode#map('hsize', 'n', 's', 'k', ':call HandleResizeContext("", 0)<CR>')
call submode#map('hsize', 'n', 's', 'j', ':call HandleResizeContext("", 1)<CR>')
call submode#map('hsize', 'n', 's', '-', ':res -5<CR>')
call submode#map('hsize', 'n', 's', '+', ':res +5<CR>')
call submode#map('hsize', 'n', 's', '=', '<C-w>=')
call submode#map('hsize', 'n', 's', '<C-j>', '<C-w>j')
call submode#map('hsize', 'n', 's', '<C-k>', '<C-w>k')
call submode#map('hsize', 'n', 'sx', '<C-h>', '<C-w>h')
call submode#map('hsize', 'n', 'sx', '<C-l>', '<C-w>l')

call submode#enter_with('pager', 'n', '', 'z+', 'z+')
call submode#enter_with('pager', 'n', '', 'z-', 'z-')
call submode#map('pager', 'n', '', '+', 'z+')
call submode#map('pager', 'n', '', '-', 'Hz-')

call submode#enter_with('buffer', 'n', 'r', ']b', ':bnext<CR>')
call submode#enter_with('buffer', 'n', 'r', '[b', ':bprev<CR>')
call submode#map('buffer', 'n', '', ']', ':bnext<CR>')
call submode#map('buffer', 'n', '', '[', ':bprev<CR>')

call submode#enter_with('gitgutterhunk', 'n', 'r', ']h', '<Plug>GitGutterNextHunk')
call submode#enter_with('gitgutterhunk', 'n', 'r', '[h', '<Plug>GitGutterPrevHunk')
call submode#map('gitgutterhunk', 'n', 'r', ']', '<Plug>GitGutterNextHunk')
call submode#map('gitgutterhunk', 'n', 'r', '[', '<Plug>GitGutterPrevHunk')

call submode#enter_with('movewin', 'n', '', '<C-e>', '<C-e>')
call submode#enter_with('movewin', 'n', '', '<C-y>', '<C-y>')
call submode#map('movewin', 'n', '', 'e', '<C-e>')
call submode#map('movewin', 'n', '', 'y', '<C-y>')

call submode#enter_with('scrollwin', 'n', '', '<C-d>', '<C-d>')
call submode#enter_with('scrollwin', 'n', '', '<C-u>', '<C-u>')
call submode#map('scrollwin', 'n', '', 'd', '<C-d>')
call submode#map('scrollwin', 'n', '', 'u', '<C-u>')

call submode#enter_with('pager', 'n', '', '<C-f>', '<C-f>')
call submode#enter_with('pager', 'n', '', '<C-b>', '<C-b>')
call submode#map('pager', 'n', '', 'f', '<C-f>')
call submode#map('pager', 'n', '', 'b', '<C-b>')

call submode#enter_with('jumplist', 'n', '', '[j', '<C-i>')
call submode#enter_with('jumplist', 'n', '', ']j', '<C-o>')
call submode#map('jumplist', 'n', '', '[', '<C-i>')
call submode#map('jumplist', 'n', '', ']', '<C-o>')
