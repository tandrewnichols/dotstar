if exists("g:loaded_coc") || &cp | finish | endif

let g:loaded_coc = 1

let g:coc_VERSION = '1.0.0'

let g:ulti_expand_or_jump_res = 0

function! s:HandleTab()
  echom string(coc#pum#info())
  if (UltiSnips#CanExpandSnippet() || UltiSnips#CanJumpForwards()) && !coc#pum#visible()
    echom '1'
    call UltiSnips#ExpandSnippetOrJump()
    return coc#pum#stop()
  endif

  if coc#pum#visible()
    echom '2'
    return coc#pum#next(1)
  endif

    echom '3'
  return "\<tab>"
endfunction

function! s:HandleShiftTab()
  if UltiSnips#CanJumpBackwards()
    UltiSnips#JumpBackwards()
    return ""
  endif

  if coc#pum#visible()
    return coc#pum#prev(1)
  endif

  return "\<s-tab>"
endfunction

function! s:HandleEnter()
  if coc#pum#visible()
    let info = coc#pum#info()
    call coc#pum#confirm()

    if info.size == 1 || info.index > 0
      return EndwiseAppend(EunuchNewLine("\r"))
    else
      return ""
    endif
  endif

  " Allow endwise and eunuch to do their endline magic
  " but still do the normal CR if not
  return EndwiseAppend(EunuchNewLine("\r"))
endfunction

inoremap <tab> <C-R>=<SID>HandleTab()<CR>
inoremap <s-tab> <C-R>=<SID>HandleShiftTab()<CR>
inoremap <CR> <C-R>=<SID>HandleEnter()<CR>
