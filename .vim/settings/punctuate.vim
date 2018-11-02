function! s:AddToLine(char, mode, start) abort
  let pos = getpos('.')
  let where = a:start ? "I" : "A"

  " Make undo keep the cursor position
  normal! ix
  normal! x
  exec "keepjumps normal!" where . a:char

  if a:mode == 'i'
    let pos[2] = pos[2] + 1
  endif
  call setpos('.', pos)
endfunction

function! s:CreateMaps(char, endOnly, startOnly) abort
  let char = a:char
  if !a:startOnly
    exec "nnoremap >" . a:char ":call <SID>AddToLine(" . string(char) . ", 'n', 0)\<CR>"
    exec "inoremap <C-x>" . a:char "<C-o>:call <SID>AddToLine(" . string(char) . ", 'i', 0)<CR>"
  endif
  if !a:endOnly
    exec "nnoremap <" . a:char ":call <SID>AddToLine(" . string(char) . ", 'n', 1)\<CR>"
    exec "inoremap <C-y>" . a:char "<C-o>:call <SID>AddToLine(" . string(char) . ", 'i', 1)<CR>"
  endif
endfunction

call s:CreateMaps(';', 0, 0)
call s:CreateMaps('.', 0, 0)
call s:CreateMaps('''', 0, 0)
call s:CreateMaps('"', 0, 0)
call s:CreateMaps(',', 0, 0)
call s:CreateMaps(')', 1, 0)
call s:CreateMaps('(', 0, 1)
call s:CreateMaps(']', 1, 0)
call s:CreateMaps('[', 0, 1)
