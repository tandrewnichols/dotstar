" TODO: Handle non-file buffers like Rebuff
"
" function! s:DidYouMean() abort
"   let file = expand('%')
"   if filereadable(file) || get(g:, 'did_you_mean_off', 0) || !empty(expand('%:e'))
"     return
"   endif
"
"   let pat = file . '*'
"   let choices = glob(pat, 0, 1)
"   if !len(choices)
"     return
"   endif
"
"   let display = ['Did you mean:']
"   for choice in choices
"     let index = index(choices, choice) + 1
"     call add(display, join([index, choice], '. '))
"   endfor
"
"   let selection = inputlist(display)
"   if empty(selection)
"     return
"   endif
"
"   if selection > 0 && selection <= len(choices)
"     let curbuf = bufnr('%')
"     let timer = timer_start(0, function('<SID>ReplaceBuffer', [choices[selection - 1], curbuf]))
"   endif
" endfunction
"
" function! s:ReplaceBuffer(name, num, ...) abort
"   exec 'silent e' fnameescape(a:name)
"   exec 'silent bd' a:num
" endfunction
"
" augroup DidYouMean
"   au!
"   au BufNewFile * call s:DidYouMean()
" augroup END
