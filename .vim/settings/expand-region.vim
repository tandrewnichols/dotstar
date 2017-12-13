let g:expand_region_text_objects = {
  \ 'iw'  :0,
  \ 'iW'  :0,
  \ 'i"'  :0,
  \ 'i''' :0,
  \ 'ix'  :0,
  \ 'ax'  :0,
  \ 'i]'  :1,
  \ 'a]'  :1,
  \ 'ib'  :1,
  \ 'ab'  :1,
  \ 'iB'  :1,
  \ 'aB'  :1,
  \ 'il'  :0,
  \ 'ii'  :0,
  \ 'ai'  :0,
  \ 'ip'  :0,
  \ 'it'  :1,
  \ 'at'  :1,
  \ 'if'  :1,
  \ 'af'  :1,
  \ 'ie'  :0
\ }

nmap <leader>< <Plug>(expand_region_shrink)
nmap <leader>> <Plug>(expand_region_expand)
