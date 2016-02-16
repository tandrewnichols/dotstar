" -------------
" JASMINE/MOCHA
" -------------

" Top-only: Add .only to top-most describe
nnoremap <silent> <leader>to moG/describe<CR>ea.only<Esc>`o:delmarks o<CR>

" Describe-only: Add .only to nearest describe
nnoremap <silent> <leader>do mo/describe<CR><S-N>ea.only<Esc>`o:delmarks o<CR>

" Context-only: Add .only to nearest context
nnoremap <silent> <leader>co mo/context<CR><S-N>ea.only<Esc>`o:delmarks o<CR>
 
" Remove-only: Remove all occurrences of .only
nnoremap <silent> <leader>ro mo:%s/\.only//g<CR>`o:delmarks o<CR>

" xdescribe: xdescribe nearest describe
nnoremap <silent> <leader>dx ms/describe<CR><S-N>ix<Esc>'s:delmarks s<CR>

" Context-skip: xcontext nearest context
nnoremap <silent> <leader>cx ms/context<CR><S-N>ix<Esc>'s:delmarks s<CR>

" Remove x: Replace xdescribe with describe and xcontext with context
nnoremap <silent> <leader>rx ms:%s/x\(describe\\|context\)/\1/g<CR>`s:delmarks s<CR>
