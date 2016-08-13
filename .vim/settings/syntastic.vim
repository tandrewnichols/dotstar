let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_quiet_messages = { "level": "warnings",
                                 \ "type":  "style",
                                 \ "regex": ["Line exceeds maximum allowed length","proprietary attribute"]}
let g:syntastic_html_tidy_blocklevel_tags = ['flot']
