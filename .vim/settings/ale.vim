let g:ale_json_fixjson_executable = 'fixjson'
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'css': ['stylelint'],
  \   'less': ['stylelint'],
  \   'coffee': ['coffeelint'],
  \   'html': ['htmlhint'],
  \   'json': ['fixjson', 'jsonlint'],
  \   'markdown': ['remark-lint']
  \ }

let g:ale_sign_error = '🚨'
let g:ale_sign_warning = '⚠️'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_less_stylelint_options = '--config ~/stylelint.config.js'
let g:ale_html_htmlhint_options = '--config ~/htmlhintrc.json'

" TODO: Pending a patch to ALE
let g:ale_coffee_coffeelint_options = '-f ~/.coffeelint'
" let g:ale_markdown_remark_lint_options = '-r ~/.remarkrc.json'

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'css': ['stylelint'],
  \   'less': ['stylelint'],
  \   'json': ['fixjson']
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

augroup AleConfig
  au!
  au BufEnter *.js call <SID>SetCorrectEslintConfig()
  au BufEnter *.coffee let b:ale_coffee_coffeelint_options = '-f ~/.coffeelint.json'
augroup END


nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

" Mnemonic: c = checker
call submode#enter_with('ale-marker', 'n', 'r', '[c', '<Plug>(ale_previous_wrap)')
call submode#enter_with('ale-marker', 'n', 'r', ']c', '<Plug>(ale_next_wrap)')
call submode#map('ale-marker', 'n', 'r', '[', '<Plug>(ale_previous_wrap)')
call submode#map('ale-marker', 'n', 'r', ']', '<Plug>(ale_next_wrap)')
