if exists("g:loaded_coc") || &cp | finish | endif

let g:loaded_coc = 1

let g:coc_VERSION = '1.0.0'

let g:ulti_expand_or_jump_res = 0

function! s:HandleTab()
  if (UltiSnips#CanExpandSnippet() || UltiSnips#CanJumpForwards()) && (!coc#pum#visible() || coc#pum#info().index < 0)
    call UltiSnips#ExpandSnippetOrJump()
    return coc#pum#stop()
  endif

  if coc#pum#visible()
    return coc#pum#next(1)
  endif

  return "\<tab>"
endfunction

function! s:HandleShiftTab()
  if UltiSnips#CanJumpBackwards()
    call UltiSnips#JumpBackwards()
    return coc#pum#stop()
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

    if info.inserted != v:true
      return EndwiseAppend(EunuchNewLine("\r"))
    endif

    return coc#pum#stop()
  endif

  " Allow endwise and eunuch to do their endline magic
  " but still do the normal CR if not
  return EndwiseAppend(EunuchNewLine("\r"))
endfunction

inoremap <tab> <C-R>=<SID>HandleTab()<CR>
inoremap <s-tab> <C-R>=<SID>HandleShiftTab()<CR>
inoremap <CR> <C-R>=<SID>HandleEnter()<CR>

inoremap <expr> <Down> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
inoremap <expr> <Up> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
