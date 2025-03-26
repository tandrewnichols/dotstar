let g:ale_json_fixjson_executable = 'fixjson'
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'javascript.jsx': ['eslint'],
  \   'typescript': ['tsserver'],
  \   'typescript.tsx': ['tsserver'],
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

let g:ale_virtualtext_cursor = 'disabled'

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

" function s:ConfigurePrettierForOlive(type) abort
"   let b:ale_fixers = [a:type]
"   let b:ale_pattern_options = { 'node_modules': {'ale_fixes': []}}
"   let b:ale_fix_on_save = 1
" endfunction

augroup aleconfig
	au!
  " au BufEnter */olive/*.* call <SID>ConfigurePrettierForOlive('prettier')
  " au BufEnter */olive/ui/*.tsx,*/olive/ui/*.ts,*/olive/ui/*.jsx,*/olive/ui/*.js call <SID>ConfigurePrettierForOlive('eslint')
	au BufEnter *.go let b:ale_fix_on_save = 1
augroup END

let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'css': ['stylelint'],
  \   'less': ['stylelint'],
  \   'json': ['fixjson'],
  \   'go': ['gofmt'],
  \   'rust': ['rustfmt']
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

hi ALEWarningSignAlt cterm=bold ctermfg=yellow
highlight link ALEWarningSign ALEWarningSignAlt
