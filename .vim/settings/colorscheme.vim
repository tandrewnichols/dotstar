function! s:SetColorMode(color)
  execute "colorscheme" a:color
endfunction

command! -nargs=0 Darkmode call <SID>SetColorMode('Jellybeans')
command! -nargs=0 Lightmode call <SID>SetColorMode('PaperColor')
