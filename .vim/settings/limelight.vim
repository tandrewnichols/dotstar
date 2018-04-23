let g:limelight_conceal_ctermfg = 'DarkGray'

augroup ConfigureLimelight
  au!
  au ColorScheme jellybeans let g:limelight_conceal_ctermfg = 'DarkGray'
  au ColorScheme * if g:colors_name != 'jellybeans' && exists("g:limelight_conceal_ctermfg") | unlet g:limelight_conceal_ctermfg | endif
augroup END

" If limelight is off, map to the operator-pending limelight plug.
" If it's already on, just turn it off again.
nmap <expr> <leader>x exists('#limelight') ? ":Limelight!<Cr>" : "<Plug>(Limelight)"
omap <expr> <leader>x exists('#limelight') ? ":Limelight!<Cr>" : "<Plug>(Limelight)"
