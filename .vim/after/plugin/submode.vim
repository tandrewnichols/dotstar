if !exists('g:noplugins') && !exists('g:bones')
  for mapping in ['b', 'q', 'l', 'a', 't', 'f']
    let plug = '<Plug>unimpaired' . toupper(mapping)
    let mode = 'unimpaired-' . mapping
    call submode#enter_with(mode, 'n', 'r', ']' . mapping, plug . 'Next')
    call submode#enter_with(mode, 'n', 'r', '[' . mapping, plug . 'Previous')
    call submode#map(mode, 'n', 'r', ']', plug . 'Next')
    call submode#map(mode, 'n', 'r', '[', plug . 'Previous')
  endfor

  call submode#enter_with('unimpaired-n', 'n', 'r', ']n', '<Plug>unimpairedContextNext')
  call submode#enter_with('unimpaired-n', 'n', 'r', '[n', '<Plug>unimpairedContextPrevious')
  call submode#map('unimpaired-n', 'n', 'r', ']', '<Plug>unimpairedContextNext')
  call submode#map('unimpaired-n', 'n', 'r', '[', '<Plug>unimpairedContextPrevious')

  call submode#enter_with('unimpaired-e', 'n', 'r', '[e', '<Plug>unimpairedMoveUp')
  call submode#enter_with('unimpaired-e', 'n', 'r', ']e', '<Plug>unimpairedMoveDown')
  call submode#map('unimpaired-e', 'n', 'r', '[', '<Plug>unimpairedMoveUp')
  call submode#map('unimpaired-e', 'n', 'r', ']', '<Plug>unimpairedMoveDown')

  call submode#enter_with('unimpaired-e', 'x', 'r', '[e', '<Plug>unimpairedSelectionUp')
  call submode#enter_with('unimpaired-e', 'x', 'r', ']e', '<Plug>unimpairedSelectionDown')
  call submode#map('unimpaired-e', 'x', 'r', '[', '<Plug>unimpairedMoveSelectionUp')
  call submode#map('unimpaired-e', 'x', 'r', ']', '<Plug>unimpairedMoveSelectionDown')

  call submode#enter_with('rum-nav', 'n', 'r', '[r', '<Plug>RumPrev')
  call submode#enter_with('rum-nav', 'n', 'r', ']r', '<Plug>RumNext')
  call submode#map('rum-nav', 'n', 'r', '[', '<Plug>RumPrev')
  call submode#map('rum-nav', 'n', 'r', ']', '<Plug>RumNext')
  call submode#map('rum-nav', 'n', 'r', 'R', '<Plug>RumSuspend')
endif
