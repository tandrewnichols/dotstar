" Delete previous char and enter insert mode
nnoremap <BS> i<BS>

" Delete current char and enter insert mode
nnoremap <Del> a<BS>


" ---------------------
" REAMP ANNOYING THINGS
" ---------------------

" Remap F1
map <F1> <Esc>
imap <F1> <Esc>
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Reverse go to mark bindings
nnoremap ' `
nnoremap ` '

" Always navigate line-wise
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" The default shiftwidth for linebreaks in vimscript is (absurdly)
" 3 TIMES shiftwidth by default. Let's be more reasonable, Bram.
let g:vim_indent_cont = &sw
