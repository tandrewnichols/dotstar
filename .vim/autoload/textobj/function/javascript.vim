function! textobj#function#javascript#select(object_type)
  return s:select_{a:object_type}()
endfunction

function! IsWithinRange(cur, start, end)
  if a:cur[1] > a:start[1] && a:cur[1] < a:end[1]
    " If the current line is in between the start and end lines
    return 1
  elseif a:cur[1] == a:start[1] && a:cur[1] < a:end[1] && a:cur[2] >= a:start[2]
    " If the current line is also the start line and the end line is different
    " and current column is greater than the start column
    return 1
  elseif a:cur[1] > a:start[1] && a:cur[1] == a:end[1] && a:cur[2] <= a:end[2]
    " If the current line is also the end line and the start line is different
    " and the current column is less than the end column
    return 1
  elseif a:start[1] == a:end[1] && a:cur[2] >= a:start[2] && a:cur[2] <= a:end[2]
    " If the current, start, and end lines are all the same and the current
    " column is between the start and end columns
    return 1
  else
    " The current position is outisde the given range
    return 0
  endif
endfunction

function! s:select_a()
  let cur = getpos('.')
  call search('function', 'b')
  normal! eB
  let start = getpos('.')
  normal! f{%
  let mark = getpos('.')
  normal! t<space>
  if getpos('.')[2] == mark[2]
    normal! $
  endif
  let end = getpos('.')

  if IsWithinRange(cur, start, end)
    return ['v', start, end]
  else
    return 0
  endif
endfunction

function! s:select_i()
  let cur = getpos('.')
  call search('function', 'b')
  let start = getpos('.')
  normal! f{%
  let end = getpos('.')

  if IsWithinRange(cur, start, end)
    return ['v', start, end]
  else
    return 0
  endif
endfunction
