" let g:ale_linters_explicit = 1
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'css': ['stylelint'],
      \   'less': ['stylelint'],
      \   'coffee': ['coffeelint -f ~/.coffeelint.json']
      \ }

let g:ale_sign_error = '🚨'
let g:ale_sign_warning = '⚠️'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let g:ale_less_stylelint_options = '--config ~/stylelint.config.js'

let g:ale_fixers = {
      \   'javascript': ['eslint']
      \ }

let g:ale_lint_delay = 500
let g:ale_pattern_options = {
      \   '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
      \   '\.min\.css$': {'ale_linters': [], 'ale_fixers': []}
      \ }

function! s:SetCorrectEslintConfig()
  let currentFile = expand("%:p")
  let project = projectroot#guess(currentFile)
  let eslintFile = project . '/.eslint.json'

  if currentFile =~ 'manta-frontend/client'
    " Check for client first
    let eslintFile = project . '/.eslint.client.json'
  elseif project =~ 'manta-frontend'
    " Always use the server eslint for everything in manta-frontend
    " that's not in client
    let eslintFile = project . '/.eslint.server.json'
  elseif empty(glob(eslintFile))
    let eslintFile = '~/.eslint.json'
  endif

  let b:ale_javascript_eslint_options = '-c ' . eslintFile
endfunction

augroup EslintConfig
  au!
  au BufEnter *.js call <SID>SetCorrectEslintConfig()
augroup END


nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

" Mnemonic: c = checker
call submode#enter_with('ale-marker', 'n', 'r', '[c', '<Plug>(ale_previous_wrap)')
call submode#enter_with('ale-marker', 'n', 'r', ']c', '<Plug>(ale_next_wrap)')
call submode#map('ale-marker', 'n', 'r', '[', '<Plug>(ale_previous_wrap)')
call submode#map('ale-marker', 'n', 'r', ']', '<Plug>(ale_next_wrap)')
