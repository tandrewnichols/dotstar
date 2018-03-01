augroup ConfigureLimelight
  au!
  au ColorScheme * if g:colors_name != 'jellybeans' | unlet g:limelight_conceal_ctermfg | endif
  au ColorScheme jellybeans let g:limelight_conceal_ctermfg = 'DarkGray'
augroup END
