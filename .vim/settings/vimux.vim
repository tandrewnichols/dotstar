let g:VimuxOrientation = "h"
let g:VimuxHeight = "35"

function! s:Npm(...)
  let cmd = a:0 == 0 ? 'install' : a:1
  let env = a:0 == 1 ? '-S' : a:2
  let module = a:0 == 2 ? expand('<cfile>') : a:3

  call VimuxRunCommand(join(['npm', cmd, env, module], ' '))
endfunction

command! -nargs=* Npm call <sid>Npm(<f-args>)
command! -nargs=* Grunt call VimuxRunCommand('grunt <args>')

function! s:InterruptAndClose()
  call VimuxInterruptRunner()
  call VimuxInterruptRunner()
  call VimuxCloseRunner()
endfunction

nnoremap <leader>vc :call <SID>InterruptAndClose()<CR>
let s:raised_hands = '🙌'
function! s:GenerateTestFile()
  let path = expand("%:p")
  let target = path =~ 'manta-frontend/client' ? 'ng' : 'unit'
  let file = split(path, 'manta-frontend/')[1]
  call system('grunt testify:' . target . ':' . file)
  echo " " emoji#for('raised_hands') " Generated test file for" file
endfunction

command! -nargs=0 Testify call s:GenerateTestFile()
