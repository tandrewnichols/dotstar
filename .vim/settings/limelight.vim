let g:limelight_conceal_ctermfg = 'DarkGray'

augroup ConfigureLimelight
  au!
  au ColorScheme jellybeans let g:limelight_conceal_ctermfg = 'DarkGray'
  au ColorScheme * if g:colors_name != 'jellybeans' && exists("g:limelight_conceal_ctermfg") | unlet g:limelight_conceal_ctermfg | endif
augroup END
