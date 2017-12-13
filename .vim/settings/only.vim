" -------------
" JASMINE/MOCHA
" -------------

function! s:RecordCurrentPosition()
  let b:current_position = getcurpos()
endfunction

function! s:JumpToLast()
  echom "Setting cursor position to" . b:current_position[1] . ":" . b:current_position[2]
  call cursor(b:current_position[1], b:current_position[2])
endfunction

function! s:Annotate(action, pattern, flags, ...)
  let pos = getcurpos()
  if a:0 > 0
    exec a:1
  endif
  call search(a:pattern, 'cw' . a:flags)
  exec "normal" a:action
  call cursor(pos[1], pos[2])
endfunction

function! s:ClearAnnotation(pattern)
  let pos = getcurpos()
  echo "%s/" . a:pattern . "/\1/g"
  exec "%s/" . a:pattern . "/\\1/g"
  call cursor(pos[1], pos[2])
endfunction
  
" Top-only
nnoremap <silent> <Plug>only-top :call <sid>Annotate('ea.only', 'describe', '', 'keepj normal G')<CR>
nmap <silent> <leader>to <Plug>only-top

" Describe-only
nnoremap <silent> <Plug>only-describe :call <sid>Annotate('ea.only', 'describe', 'b')<CR>
nmap <silent> <leader>do <Plug>only-describe

" Context-only
nnoremap <silent> <Plug>only-context :call <sid>Annotate('ea.only', 'context', 'b')<CR>
nmap <silent> <leader>co <Plug>only-context

" Nearest-only
nnoremap <silent> <Plug>only-nearest :call <sid>Annotate('ea.only', '\(describe\\|context\)', 'b')<CR>
nmap <silent> <leader>no <Plug>only-nearest
 
" Remove-only: Remove all occurrences of .only
nnoremap <silent> <Plug>only-remove :call <sid>ClearAnnotation('\(describe\\|context\)\.only')<CR>
nmap <silent> <leader>ro <Plug>only-remove

" xdescribe: xdescribe nearest describe
nnoremap <silent> <Plug>skip-describe :call <sid>Annotate('ix', 'describe', 'b')<CR>
nmap <silent> <leader>dx <Plug>skip-describe

" Context-skip: xcontext nearest context
nnoremap <silent> <Plug>skip-context :call <sid>Annotate('ix', 'context', 'b')<CR>
nmap <silent> <leader>cx <Plug>skip-context

" Remove x: Replace xdescribe with describe and xcontext with context
nnoremap <silent> <Plug>skip-remove :call <sid>ClearAnnotation('x\(describe\\|context\)')<CR>
nnoremap <silent> <leader>rx <Plug>skip-remove
