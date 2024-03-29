" -------------
" JASMINE/MOCHA/JEST
" -------------

function! s:Annotate(action, pattern, flags, ...)
  let pos = getcurpos()
  if a:0 > 0
    exec a:1
  endif
  call search(a:pattern, 'cw' . a:flags)
  exec "normal" a:action
  call cursor(pos[1], pos[2])
endfunction

function! s:ClearAnnotation(pattern) abort
  let pos = getcurpos()
  try
    exec "%s/" . a:pattern . "/\\1/g"
    call cursor(pos[1], pos[2])
  catch /E486/
    echo "No isolated tests"
    " Ignore pattern not found
  endtry
endfunction
  
function! s:CreateMappings()
  " Top-only
  nnoremap <silent> <Plug>only-top :call <sid>Annotate('ea.only', '^describe', '', 'keepj normal G')<CR>
  nmap <silent> <buffer> <leader>to <Plug>only-top

  " Describe-only
  nnoremap <silent> <Plug>only-describe :call <sid>Annotate('ea.only', '\(^describe\\|  describe\)', 'b')<CR>
  nmap <silent> <buffer> <leader>do <Plug>only-describe

  " Context-only
  nnoremap <silent> <Plug>only-context :call <sid>Annotate('ea.only', '  context', 'b')<CR>
  nmap <silent> <buffer> <leader>co <Plug>only-context

  " it-only
  nnoremap <silent> <Plug>it-context :call <sid>Annotate('ea.only', '  it\>', 'b')<CR>
  nmap <silent> <buffer> <leader>io <Plug>it-context

  " Nearest-only
  nnoremap <silent> <Plug>only-nearest :call <sid>Annotate('ea.only', '\(^describe\\|  describe\\|  context\\|  it\)', 'b')<CR>
  nmap <silent> <buffer> <leader>no <Plug>only-nearest
  
  " Remove-only: Remove all occurrences of .only
  nnoremap <silent> <Plug>only-remove :call <sid>ClearAnnotation('\(describe\\|context\\|it\)\.only')<CR>
  nmap <silent> <buffer> <leader>ro <Plug>only-remove

  " xdescribe: xdescribe nearest describe
  nnoremap <silent> <Plug>skip-describe :call <sid>Annotate('ea.skip', '\(^describe\\|  \zsdescribe\)', 'b')<CR>
  nmap <silent> <buffer> <leader>dx <Plug>skip-describe

  " xcontext: xcontext nearest context
  nnoremap <silent> <Plug>skip-context :call <sid>Annotate('ea.skip', '  \zscontext', 'b')<CR>
  nmap <silent> <buffer> <leader>cx <Plug>skip-context

  " it.skip: skip nearest it
  nnoremap <silent> <Plug>skip-it :call <sid>Annotate('ea.skip', '  it\>', 'b')<CR>
  nmap <silent> <buffer> <leader>ix <Plug>skip-it

  " Remove x: Remove all occurrences of .skip and change xdescribe/xcontext to describe/context
  nnoremap <silent> <Plug>skip-remove :call <sid>ClearAnnotation('\(describe\|context\|it\)\.skip')<CR>
  nmap <silent> <buffer> <leader>xx <Plug>skip-remove
endfunction

augroup TestOnly
  au!
  au BufRead,BufNew */spec*/*,*/test/*,*/tests/*,*/*-spec*,*/*.spec.* call s:CreateMappings()
augroup END
