function! s:WatchVader() abort
  augroup WatchVader
    au!
    au BufWritePost test/*.{vim,vader} Vader
  augroup END
endfunction

function! s:UnwatchVader() abort
  au! WatchVader
endfunction

function! s:CreateVaderCommands() abort
  command! -buffer WatchVader call s:WatchVader()
  command! -buffer UnwatchVader call s:UnwatchVader()
endfunction

augroup FileTypeVim
  au!
  au FileType vim,vader call s:CreateVaderCommands()
  au FileType vader 
    \ let b:endwise_addition = '\=submatch(0)=~"aug\\%[roup]" ? submatch(0) . " END" : "end" . submatch(0)' |
    \ let b:endwise_words = 'fu\%[nction],wh\%[ile],if,for,try,aug\%[roup]\%(\s\+\cEND\)\@!' |
    \ let b:endwise_end_pattern = '\%(end\%(fu\%[nction]\|wh\%[hile]\|if\|for\|try\)\)\|aug\%[roup]\%(\s\+\cEND\)' |
    \ let b:endwise_syngroups = 'vimFuncKey,vimNotFunc,vimCommand,vimAugroupKey,vimAugroup,vimAugroupError'
augroup END
