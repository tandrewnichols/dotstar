for mapping in ['b', 'q', 'l', 'a', 't', 'f', 'n']
  let plug = '<Plug>unimpaired' . toupper(mapping)
  let mode = 'unimpaired-' . mapping
  call submode#enter_with(mode, 'n', 'r', ']' . mapping, plug . 'Next')
  call submode#enter_with(mode, 'n', 'r', '[' . mapping, plug . 'Previous')
  call submode#map(mode, 'n', 'r', ']', plug . 'Next')
  call submode#map(mode, 'n', 'r', '[', plug . 'Previous')
  call submode#map(mode, 'n', 'r', 'n', plug . 'Next')
  call submode#map(mode, 'n', 'r', 'p', plug . 'Previous')
  call submode#map(mode, 'n', 'r', 'N', plug . 'Previous')
endfor
