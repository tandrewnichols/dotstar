function! s:Highlight()
  let b:prevhl = &hlsearch
  set hlsearch
endfunction

function! s:NoHighlight()
  let &hlsearch = b:prevhl
endfunction

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :call s:Highlight()
  autocmd CmdlineLeave [/\?] :call s:NoHighlight()
augroup END
