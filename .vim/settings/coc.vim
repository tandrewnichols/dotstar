" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

call submode#enter_with('coc-diag', 'n', 'er', '[g', '<Plug>(coc-diagnostic-prev)')
call submode#enter_with('coc-diag', 'n', 'er', ']g', '<Plug>(coc-diagnostic-next)')
call submode#map('coc-diag', 'n', 'er', '[', '<Plug>(coc-diagnostic-prev)')
call submode#map('coc-diag', 'n', 'er', ']', '<Plug>(coc-diagnostic-next)')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

 " Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup CocSetup
  au!
  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Don't overwrite [c and ]c in diffs
nmap <expr> <silent> [c &diff ? ':normal! [c' : '<Plug>(coc-diagnostic-prev-error)'
nmap <expr> <silent> ]c &diff ? ':normal! ]c' : '<Plug>(coc-diagnostic-next-error)'

" Mnemonic: c = checker
call submode#enter_with('coc-marker', 'n', 'er', '[c', '&diff ? '':normal! [c<CR>'' : ''<Plug>(coc-diagnostic-prev-error)''')
call submode#enter_with('coc-marker', 'n', 'er', ']c', '&diff ? '':normal! ]c<CR>'' : ''<Plug>(coc-diagnostic-next-error)''')
call submode#map('coc-marker', 'n', 'er', '[', '&diff ? '':normal! [c<CR>'' : ''<Plug>(coc-diagnostic-prev-error)''')
call submode#map('coc-marker', 'n', 'er', ']', '&diff ? '':normal! ]c<CR>'' : ''<Plug>(coc-diagnostic-next-error)''')
