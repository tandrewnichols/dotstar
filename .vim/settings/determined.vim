call determined#command('Npm', 'npm', { 'vertical': 0, 'autoclose': 1, 'rows': '5', 'cols': '40%' })
call determined#command('Run', 'npm run', { 'reuse': 1 })
call determined#command('Repl', 'node', { 'background': 0 })
call determined#command('Node', 'node', { 'background': 0, 'vertical': 0, 'rows': '10', 'cols': '40%' })
call determined#command('Rg', 'rg', { 'expand': 1, 'background': 0, 'reuse': 1, 'complete': replete#byArg('Rg', ['replete#complete#bufwords', 'file'], '-\{1,2}[^ ]\{-} ') })
call determined#command('Grunt', 'grunt', { 'reuse': 1 })
call determined#command('Gulp', 'gulp', { 'reuse': 1 })
call determined#command('Push', 'push', { 'vertical': 0, 'autoclose': 1, 'rows': '3' })
call determined#command('Mocha', 'mocha --fgrep %', { 'expand': 1, 'reuse': 1 })

let s:JestEscapeLambda = { filename -> "'" . substitute(filename, "'", "'\\''", 'g')->substitute('\v([()\[\]])', '\\\\\1', 'g') . "'" }

call determined#command('Jest', &shell . ' -c "NODE_ENV=development npm test -- %"', { 'reuse': 1, 'expand': 1, 'escape': s:JestEscapeLambda })
call determined#command('JestAll', &shell . ' -c "NODE_ENV=development jest --coverage --passWithNoTests"', { 'reuse': 1 })
call determined#command('Cargo', 'cargo', { 'reuse': 1, 'background': 0, 'expand': 1 })

function! s:CreateHTCommands(...) abort
  if a:0 > 0
    call determined#command('Jest', &shell . ' -c "TZ=UTC NODE_ENV=development jest % -c ' . a:1 . '"', {
      \    'reuse': 1,
      \    'expand': 1,
      \    'escape': s:JestEscapeLambda
      \  })
  else
    call determined#command('Jest', &shell . ' -c "TZ=UTC NODE_ENV=development jest %"', { 'reuse': 1, 'expand': 1, 'escape': s:JestEscapeLambda })
  endif
endfunction

augroup hometown-uis
  au!
  au BufEnter */ht/hometown-uis*/*.spec.ts,*/ht/hometown-uis/*.spec.tsx call <SID>CreateHTCommands()
  au BufEnter */ht/hometown-apis*/*.spec.ts,*/ht/hometown-apis/*.spec.tsx call <SID>CreateHTCommands()
  au BufEnter */ht/htw-cms*/*.test.ts,*/ht/htw-cms/*.test.tsx call <SID>CreateHTCommands('jest.unit.config.ts')
  au BufEnter */ht/boxoffice/tests/* call determined#command('PhpUnit', 'php bin/phpunit -c phpunit.xml.dist %', { 'reuse': 1, 'expand': 1 })
augroup END
