function! depute#inject#angular()
  call search('angular.module', 'sw')
  normal! $F)
  echom 'Char is:' getline('.')[col('.') - 2]
  if getline('.')[col('.') - 2] !~ '[( ]' 
    normal! i, 
  else
    normal! h
  endif
endfunction

" function! depute#inject#node()
"   " Trailing space on this is on purpose
"   normal! gg}Oconst "dpa = require('
"   call inputsave()
"   let input = input("require('")
"   exec "normal! a" . input . "')";
"   call inputrestore()
" endfunction

