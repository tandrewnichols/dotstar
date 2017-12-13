" function! s:ReplaceHoganIncludes()
  " if !exists("g:hogan_map")
    " let file = readfile('/Users/AndrewNichols/code/anichols/manta/hogan.json')
    " let decoded = json_decode(file[0])
    " let g:hogan_map = decoded
  " endif
  " let buffer = join(getline(1,'$'), "\n")
  " let matches = []
  " call substitute(buffer, '{{>\([^}]\+\)}}', '\=add(matches, submatch(1))', 'g')
  " for mtch in matches
    " let key = substitute(mtch, '^\s*\(.\{-}\)\s*$', '\1', '')
    " if has_key(g:hogan_map, key)
      " let replace = g:hogan_map[ key ]
      " silent exec "silent %s/{{>\\s\\?" . key . "\\s\\?}}/{{> " . escape(replace, '/') . " }}/g"
    " endif
  " endfor
" endfunction

" augroup HoganPartials
  " au!
  " au BufEnter */manta-frontend/server/views/* call <sid>ReplaceHoganIncludes()
" augroup END

" augroup HoganFiles
  " au!
  " au BufEnter */manta-frontend/server/views/* exec "setlocal suffixesadd=.html | setlocal path+=," . split(system("git rev-parse --show-toplevel"), '\n')[0] . "/server/views/partials"
" augroup END
