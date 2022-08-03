function! s:Fix() abort
  set cmdheight=1
  normal <C-w>_
endfunction

command Fix -nargs=0 call <SID>Fix()

function! FindUp(dir, ...) abort
  let dir = a:dir
  let path = a:0 == 1 ? a:1 : expand("%:p:h")

  while path != "/"
    let candidate = join([path, dir], "/")
    if isdirectory(candidate)
      return candidate
    endif

    let path = fnamemodify(path, ":h")
  endwhile
endfunction
