let g:VimuxOrientation = "h"
let g:VimuxHeight = "35"

function! s:RunNpm(cmd, ...)
  let args = a:0 > 0 ? a:000 : []
  let env = '-S'
  let module = expand('<cfile>')
  let len = len(args)

  if (len == 2)
    let env = args[0]
    let module = args[1]
  elseif len == 1 && args[0] =~ '$-'
    let env = args[0]
  elseif len == 1
    let module = args[0]
  endif

  call VimuxRunCommand(join(['npm', a:cmd, env, module], ' '))
endfunction

command! -nargs=* Npm call VimuxRunCommand('npm <args>')
command! -nargs=0 NpmInstall call <SID>RunNpm('i')
command! -nargs=0 NpmI call <SID>RunNpm('i')
command! -nargs=0 NpmDev call <SID>RunNpm('i', '-D')
command! -nargs=0 NpmID call <SID>RunNpm('i', '-D')
command! -nargs=* NpmRm call <SID>RunNpm('r', <f-args>)
command! -nargs=* NpmRun call <SID>VimuxRunCommand('npm run <args>')

command! -nargs=* Grunt call VimuxRunCommand('grunt <args>')
command! -nargs=0 GruntCi call VimuxRunCommand('grunt ci')
command! -nargs=1 GruntWatch call VimuxRunCommand('grunt watch:<args> --clear')
command! -nargs=0 GruntP call VimuxRunCommand('grunt p')
command! -nargs=1 GruntSpec call VimuxRunCommand('grunt spec:<args>')
command! -nargs=0 GruntUnit call VimuxRunCommand('grunt spec:unit')
command! -nargs=0 GruntE2e call VimuxRunCommand('grunt spec:e2e')
command! -nargs=0 GruntClean call VimuxRunCommand('grunt clean:coffee')

function! s:ExecCmd(plug, cmd)
  exec "normal \<Plug>" . a:plug
  write
  call VimuxRunCommand(a:cmd)
endfunction

function! s:AddTestCommands(cmd)
  let prefix = "command! -narg=0"
  exec prefix "TestFile call \<sid>ExecCmd('only-top', '" . a:cmd . "')"
  exec prefix "TestNearest call \<sid>ExecCmd('only-nearest', '" . a:cmd . "')"
  exec prefix "TestFunction call \<sid>ExecCmd('only-describe', '" . a:cmd . "')"
endfunction

augroup TestCommands
  au!
  au BufNewFile,BufRead */manta-frontend/client/spec/* call <sid>AddTestCommands('grunt ci')
  au BufNewFile,BufRead */manta-frontend/server/spec/* call<sid>AddTestCommands('grunt spec:unit')
  au BufNewFile,BufRead */manta-frontend/server/spec-e2e/* call<sid>AddTestCommands('grunt spec:e2e')
augroup END

function! s:InterruptAndClose()
  call VimuxInterruptRunner()
  call VimuxInterruptRunner()
  call VimuxCloseRunner()
endfunction

nnoremap <leader>vc :call <SID>InterruptAndClose()<CR>

function! s:GenerateTestFile()
  let path = expand("%:p")
  let target = path =~ 'manta-frontend/client' ? 'ng' : 'unit'
  let file = split(path, 'manta-frontend/')[1]
  call system('grunt testify:' . target . ':' . file)
  echo "Generated test file for " . file
endfunction

command! -nargs=0 Testify call s:GenerateTestFile()<CR>
