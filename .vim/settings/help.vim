hi ColorColumn ctermbg=red

function! s:ToggleHelpGuide()
  if empty(&colorcolumn)
    set colorcolumn=80
  else
    set colorcolumn=
  endif
endfunction

command! -nargs=0 HelpGuide call s:ToggleHelpGuide()

augroup Help
  au!
  au Filetype help nnoremap q q
  au Filetype help nnoremap <buffer> <leader>h :setf text<CR>
  au Filetype text nnoremap <buffer> <leader>h :setf help<CR>
  au Filetype help nnoremap <buffer> <leader>g :HelpGuide<CR>
  au Filetype text nnoremap <buffer> <leader>g :HelpGuide<CR>
augroup END

function! s:FormatHelpParagraph()
  let pos = getpos('.')
  normal! gq$
  call setpos('.', pos)
  normal! j0
  let @a = repeat(' ', pos[2] - 1)
  normal! "aP
  
  let prev = ""

  " Loop until the line
  while getline('.') != prev
    let prev = getline('.')
    normal! Jgq$
  endwhile

  normal! o
endfunction

command! -nargs=0 FormatHelpParagraph call s:FormatHelpParagraph()
