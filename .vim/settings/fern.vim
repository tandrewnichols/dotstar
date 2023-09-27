let g:fern#renderer = "nerdfont"
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden = 1

nnoremap - :Fern %:h -reveal=%:t<CR>
nnoremap <leader>- :Fern %:h -reveal=%:t -drawer<CR>
nnoremap <leader>B :Fern bookmark:///<CR>

function! s:FernMappings() abort
  " Basic Fern actions
  nmap <silent><buffer> m <plug>(fern-action-mark:toggle)
  nmap <silent><buffer> r <plug>(fern-action-reload:cursor)
  nmap <silent><buffer><nowait> <leader>r <plug>(fern-action-reload:all)
  nmap <silent><buffer> <CR> <plug>(fern-action-open-or-enter)
  nmap <silent><buffer> = <plug>(fern-action-reveal)
  nmap <silent><buffer> - <plug>(fern-action-leave)
  nmap <silent><buffer> s <plug>(fern-action-open:split)
  nmap <silent><buffer> v <plug>(fern-action-open:vsplit)
  nmap <silent><buffer> t <plug>(fern-action-open:tabedit)
  nmap <silent><buffer><expr> <leader>-
    \ fern#smart#leaf(
    \   "<Plug>(fern-action-open:tabedit)",
    \   "<Plug>(fern-action-expand:stay)",
    \   "<Plug>(fern-action-collapse)"
    \ )
  nmap <silent><buffer> <leader>k <plug>(fern-action-open:above)
  nmap <silent><buffer> <leader>j <plug>(fern-action-open:below)
  nmap <silent><buffer> <leader>l <plug>(fern-action-open:left)
  nmap <silent><buffer> <leader>h <plug>(fern-action-open:right)
  nmap <silent><buffer> <leader>K <plug>(fern-action-open:top)
  nmap <silent><buffer> <leader>J <plug>(fern-action-open:bottom)
  nmap <silent><buffer> <leader>L <plug>(fern-action-open:leftest)
  nmap <silent><buffer> <leader>H <plug>(fern-action-open:rightest)
  nmap <silent><buffer> p <plug>(fern-action-new-path)
  nmap <silent><buffer> % <plug>(fern-action-new-file)
  nmap <silent><buffer> d <plug>(fern-action-new-dir)
  nmap <silent><buffer> yy <plug>(fern-action-yank:label)
  nmap <silent><buffer> Y <plug>(fern-action-yank:bufname)
  nmap <silent><buffer> cc <plug>(fern-action-copy)
  nmap <silent><buffer> yc <plug(fern-action-clipboard-copy)
  nmap <silent><buffer> cm <plug>(fern-action-move)
  nmap <silent><buffer> ym <plug>(fern-action-clipboard-move)
  nmap <silent><buffer> cp <plug>(fern-action-clipboard-paste)
  nmap <silent><buffer> cd <plug>(fern-action-clipboard-clear)
  nmap <silent><buffer> D <plug>(fern-action-remove)
  nmap <silent><buffer> R <plug>(fern-action-rename)
  nmap <silent><buffer> o <plug>(fern-action-open:system)

  " Project top plugin
  nmap <silent><buffer> T <plug>(fern-action-project-top)
  nmap <silent><buffer> <leader>T <plug>(fern-action-project-top:reveal)

  " Git plugin
  call fern#scheme#file#mapping#git#init(1)
  nmap <silent><buffer> < <plug>(fern-action-git-stage)
  nmap <silent><buffer> > <plug>(fern-action-git-unstage)

  " Preview plugin
  nmap <silent><buffer> <leader>p     <plug>(fern-action-preview:toggle)
  nmap <silent><buffer> <C-p> <plug>(fern-action-preview:auto:toggle)
  nmap <silent><buffer> <C-d> <plug>(fern-action-preview:scroll:down:half)
  nmap <silent><buffer> <C-u> <plug>(fern-action-preview:scroll:up:half)
  nmap <silent><buffer> <expr> <plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent><buffer> q <plug>(fern-quit-or-close-preview)

  " Quickfix plugin
  call fern#mapping#quickfix#init(1)
  nmap <silent><buffer> Qn <plug>(fern-action-quickfix)
  nmap <silent><buffer> Qa <plug>(fern-action-quickfix:add)
  nmap <silent><buffer> Qr <plug>(fern-action-quickfix:replace)
  nmap <silent><buffer> Ln <plug>(fern-action-loclist)
  nmap <silent><buffer> La <plug>(fern-action-loclist:add)
  nmap <silent><buffer> Lr <plug>(fern-action-loclist:replace)

  " Copynode plugin
  call fern#scheme#file#mapping#copynode#init(1)
  nmap <silent><buffer> cn <plug>(fern-action-copynode-label)
  nmap <silent><buffer> cp <plug>(fern-action-copynode-path)
endfunction

augroup fern-custom
  au!
  au FileType fern call <sid>FernMappings()
augroup END
