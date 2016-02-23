let g:submode_always_show_submodea = 1
let g:submode_timeoutlen = 3000

" Tab mappings. Enter tab mode with gt (which I don't use).
call submode#enter_with('tabs', 'n', '', 'gt')
" Then use h/l to move left and right between tabs
call submode#map('tabs', 'n', '', 'h', 'gT')
call submode#map('tabs', 'n', '', 'l', 'gt')
" And j/k to move a tab up and down (index)
call submode#map('tabs', 'n', '', 'j', ':tabm -<CR>')
call submode#map('tabs', 'n', '', 'k', ':tabm +<CR>')

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

" Jump 5 lines at a time
call submode#enter_with('boost', 'n', '', '5j', '5j')
call submode#enter_with('boost', 'n', '', '5k', '5k')
call submode#enter_with('boost', 'n', '', '5h', '5h')
call submode#enter_with('boost', 'n', '', '5l', '5l')
call submode#map('boost', 'n', '', 'j', '5j')
call submode#map('boost', 'n', '', 'k', '5k')
call submode#map('boost', 'n', '', 'h', '5h')
call submode#map('boost', 'n', '', 'l', '5l')
