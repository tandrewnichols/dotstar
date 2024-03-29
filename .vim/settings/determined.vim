call determined#command('Npm', 'npm', { 'vertical': 0, 'autoclose': 1, 'rows': '5', 'cols': '40%' })
call determined#command('Run', 'npm run', { 'reuse': 1 })
call determined#command('Repl', 'node', { 'background': 0 })
call determined#command('Node', 'node', { 'background': 0, 'vertical': 0, 'rows': '10', 'cols': '40%' })
call determined#command('Rg', 'rg', { 'expand': 1, 'background': 0, 'reuse': 1, 'complete': replete#byArg('Rg', ['replete#complete#bufwords', 'file'], '-\{1,2}[^ ]\{-} ') })
call determined#command('Grunt', 'grunt', { 'reuse': 1 })
call determined#command('Gulp', 'gulp', { 'reuse': 1 })
call determined#command('Push', 'push', { 'vertical': 0, 'autoclose': 1, 'rows': '3' })
call determined#command('Mocha', 'mocha --fgrep %', { 'expand': 1, 'reuse': 1 })
call determined#command('Jest', &shell . ' -c "NODE_ENV=development npm test -- %"', { 'reuse': 1, 'expand': 1 })
call determined#command('JestAll', &shell . ' -c "NODE_ENV=development jest --coverage --passWithNoTests"', { 'reuse': 1 })
call determined#command('Cargo', 'cargo', { 'reuse': 1, 'background': 0, 'expand': 1 })

function! s:CreateHTUICommands() abort
  call determined#command('Jest', &shell . ' -c "NODE_ENV=development jest %"', { 'reuse': 1, 'expand': 1 })
endfunction

augroup hometown-uis
  au!
  au BufEnter */ht/hometown-uis/*.spec.ts,*/ht/hometown-uis/*.spec.tsx call <SID>CreateHTUICommands()
  au BufEnter */ht/hometown-apis/*.spec.ts,*/ht/hometown-apis/*.spec.tsx call <SID>CreateHTUICommands()
augroup END
