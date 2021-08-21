let g:ale_json_fixjson_executable = 'fixjson'
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'css': ['stylelint'],
  \   'less': ['stylelint'],
  \   'coffee': ['coffeelint'],
  \   'html': ['htmlhint'],
  \   'json': ['fixjson', 'jsonlint'],
  \   'markdown': ['remark-lint'],
  \   'vim': ['vint'],
  \   'sh': ['shellcheck'],
  \   'go': ['gopls']
  \ }

let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
" let g:ale_less_stylelint_options = '--config ~/stylelint.config.js'
let g:ale_html_htmlhint_options = '--config ~/htmlhintrc.json'

" TODO: Pending a patch to ALE
let g:ale_coffee_coffeelint_options = '-f ~/.coffeelint'
" let g:ale_markdown_remark_lint_options = '-r ~/.remarkrc.json'

function s:ConfigurePrettierForOlive() abort
  let b:ale_fixers = ['prettier']
  let b:ale_pattern_options = { 'node_modules': {'ale_fixes': []}}
  let b:ale_fix_on_save = 1
endfunction

augroup aleconfig
	au!
	au BufEnter */olive/*.jsx,*/olive/*.* call <SID>ConfigurePrettierForOlive()
	au BufEnter *.go let b:ale_fix_on_save = 1
augroup END

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'css': ['stylelint'],
  \   'less': ['stylelint'],
  \   'json': ['fixjson'],
  \   'go': ['gofmt']
  \ }

let g:ale_lint_delay = 500
let g:ale_pattern_options = {
      \   '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
      \   '\.min\.css$': {'ale_linters': [], 'ale_fixers': []}
      \ }

function! s:SetCorrectStylelintConfig()
  if !exists("b:projectroot")
    return
  endif

  let currentfile = expand("%:p")
  let stylelintFile = b:projectroot . '/stylelint.json'

  if empty(glob(stylelintFile))
    let stylelintFile = '~/stylelint.config.json'
  endif

  let b:ale_less_stylelint_options = '--config ' . stylelintFile
endfunction

augroup AleConfig
  au!
  au BufEnter *.less,*.css,*.sass call <SID>SetCorrectStylelintConfig()
augroup END

" Don't overwrite [c and ]c in diffs
nmap <expr> <silent> [c &diff ? ':normal! [c' : '<Plug>(ale_previous_wrap)'
nmap <expr> <silent> ]c &diff ? ':normal! ]c' : '<Plug>(ale_next_wrap)'

" Mnemonic: c = checker
call submode#enter_with('ale-marker', 'n', 'er', '[c', '&diff ? '':normal! [c<CR>'' : ''<Plug>(ale_previous_wrap)''')
call submode#enter_with('ale-marker', 'n', 'er', ']c', '&diff ? '':normal! ]c<CR>'' : ''<Plug>(ale_next_wrap)''')
call submode#map('ale-marker', 'n', 'er', '[', '&diff ? '':normal! [c<CR>'' : ''<Plug>(ale_previous_wrap)''')
call submode#map('ale-marker', 'n', 'er', ']', '&diff ? '':normal! ]c<CR>'' : ''<Plug>(ale_next_wrap)''')

hi ALEWarningSignAlt cterm=bold ctermfg=yellow
highlight link ALEWarningSign ALEWarningSignAlt
