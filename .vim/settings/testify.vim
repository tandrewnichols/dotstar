function! s:GenerateTestFile(filename) abort
  if a:filename =~ 'manta-frontend'
    let file = split(a:filename, 'manta-frontend\d*/')[1]
    call system('grunt testify:' . file)
    echo " " emoji#for('raised_hands') " Generated test file for" file
  else
    echo "File is not in manta-frontend. Not generating a test file."
  endif
endfunction

function! s:MoveTestFile(a, b) abort
  if a:a =~ 'manta-frontend' && a:b =~ 'manta-frontend'
    let fileA = split(a:a, 'manta-frontend\d*/')[1]
    let fileB = split(a:b, 'manta-frontend\d*/')[1]
    call system('grunt testify:' . fileA . ':' . fileB)
    echo " " emoji#for('raised_hands') " Moved test file for" fileA
  endif
endfunction

function! s:Testify(...) abort
  let args = a:000
  if len(args) < 2
    let path = len(args) == 0 ? expand("%:p") : fnamemodify(args[0], ":p")
    call s:GenerateTestFile(path)
  elseif len(args) == 2
    call s:MoveTestFile(fnamemodify(args[0], ":p"), fnamemodify(args[1], ":p"))
  else
    echo "Too many arguments. Testify takes 0, 1, or 2 argments."
  endif
endfunction

command! -nargs=* -complete=file Testify call s:Testify(<f-args>)
