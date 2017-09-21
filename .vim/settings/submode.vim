let g:submode_always_show_submode = 1
let g:submode_timeoutlen = 3000

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

" Jump n lines at a time
for i in [2,3,4,5,6,7,8,9,10]
  call submode#enter_with('boostv' . i, 'n', '', i . 'j', i . 'j')
  call submode#enter_with('boostv' . i, 'n', '', i . 'k', i . 'k')
  call submode#enter_with('boosth' . i, 'n', '', i . 'h', i . 'h')
  call submode#enter_with('boosth' . i, 'n', '', i . 'l', i . 'l')
  call submode#map('boostv' . i, 'n', '', 'j', i . 'j')
  call submode#map('boostv'. i, 'n', '', 'k', i . 'k')
  call submode#map('boostv' . i, 'n', 'x', 'h', 'h')
  call submode#map('boostv' . i, 'n', 'x', 'l', 'l')
  call submode#map('boosth' . i, 'n', '', 'h', i . 'h')
  call submode#map('boosth' . i, 'n', '', 'l', i . 'l')
  call submode#map('boosth' . i, 'n', 'x', 'j', 'j')
  call submode#map('boosth' . i, 'n', 'x', 'k', 'k')
endfor

call submode#enter_with('pagedown', 'n', '', 'z+', 'z+')
call submode#map('pagedown', 'n', '', '+', 'z+')
call submode#map('pagedown', 'n', 'x', 'h', 'h')
call submode#map('pagedown', 'n', 'x', 'j', 'j')
call submode#map('pagedown', 'n', 'x', 'k', 'k')
call submode#map('pagedown', 'n', 'x', 'l', 'l')

call submode#enter_with('pageup', 'n', '', 'z-', 'z-')
call submode#map('pageup', 'n', '', '-', 'Hz-')
call submode#map('pageup', 'n', 'x', 'h', 'h')
call submode#map('pageup', 'n', 'x', 'j', 'j')
call submode#map('pageup', 'n', 'x', 'k', 'k')
call submode#map('pageup', 'n', 'x', 'l', 'l')

call submode#enter_with('buffer', 'n', 'r', ']b', ':bnext<CR>')
call submode#enter_with('buffer', 'n', 'r', '[b', ':bprev<CR>')
call submode#map('buffer', 'n', '', ']', ':bnext<CR>')
call submode#map('buffer', 'n', '', '[', ':bprev<CR>')
call submode#map('buffer', 'n', '', '.', '@:')
call submode#map('buffer', 'n', '', 'n', ':bnext<CR>')
call submode#map('buffer', 'n', '', 'p', ':bprev<CR>')

call submode#enter_with('gitgutterhunk', 'n', 'r', ']h', '<Plug>GitGutterNextHunk')
call submode#enter_with('gitgutterhunk', 'n', 'r', '[h', '<Plug>GitGutterPrevHunk')
call submode#map('gitgutterhunk', 'n', 'r', ']', '<Plug>GitGutterNextHunk')
call submode#map('gitgutterhunk', 'n', 'r', '[', '<Plug>GitGutterPrevHunk')
call submode#map('gitgutterhunk', 'n', 'r', 'n', '<Plug>GitGutterNextHunk')
call submode#map('gitgutterhunk', 'n', 'r', 'p', '<Plug>GitGutterPrevHunk')
call submode#map('gitgutterhunk', 'n', 'r', 'N', '<Plug>GitGutterPrevHunk')

call submode#enter_with('switch', 'n', '', '>s', ':Switch<CR>')
call submode#enter_with('switch', 'n', '', '<s', ':SwitchReverse<CR>')
call submode#map('switch', 'n', 'r', '>', ':Switch<CR>')
call submode#map('switch', 'n', 'r', '<', ':SwitchReverse<CR>')
