let g:swap#rules = deepcopy(g:swap#default_rules)
let g:swap#rules += [
  \   {
  \     'mode': 'n',
  \     'delimiter': ['/'],
  \     'surrounds': ['[''" ]/\?', '[''" ?\n]']
  \   }
  \ ]

" let g:swap#default_rules = [
      "   {
      "     'mode': 'x',
      "     'delimiter': ['\s\+'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\s\|\n\)\s*', '\s\+$'],
      "     'priority': -50
      "   },
      "   {
      "     'mode': 'x',
      "     'delimiter': ['\s*,\s*'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\s\|\n\)\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'body': '\%(\h\w*\s*\)\+\%(\h\w*\)\?',
      "     'delimiter': ['\s\+'],
      "     'priority': -50
      "   },
      "   {
      "     'mode': 'n',
      "     'body': '\%(\h\w*,\s*\)\+\%(\h\w*\)\?',
      "     'delimiter': ['\s*,\s*'],
      "     'priority': -10
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['\[', '\]', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\|\n\)\s\+', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['{', '}', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\|\n\)\s\+', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['(', ')', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\|\n\)\s\+', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['\[', '\]', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'filetype': ['vim'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\|\n\)\s*\\\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['{', '}', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'filetype': ['vim'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\|\n\)\s*\\\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['(', ')', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'filetype': ['vim'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\%(^\|\n\)\s*\\\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['(', ')', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'filetype': ['fortran'],
      "     'braket': [['(', ')'], ['[', ']']],
      "     'quotes': [['"', '"']],
      "     'literal_quotes': [["'", "'"]],
      "     'immutable': ['\s*&\s*\%(!.\{-}\)\?\n\s*\%(&\s*\)\?', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['\[', '\]', 1],
      "     'delimiter': ['\s*[,;[:space:]]\s*'],
      "     'filetype': ['matlab'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'immutable': ['\s*\.\{3}\s*\n\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['{', '}', 1],
      "     'delimiter': ['\s*[,;[:space:]]\s*'],
      "     'filetype': ['matlab'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'immutable': ['\s*\.\{3}\s*\n\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['(', ')', 1],
      "     'delimiter': ['\s*,\s*'],
      "     'filetype': ['matlab'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}']],
      "     'immutable': ['\s*\.\{3}\s*\n\s*', '\s\+$']
      "   },
      "   {
      "     'mode': 'n',
      "     'surrounds': ['{', '}', 1],
      "     'delimiter': ['\n'],
      "     'filetype': ['c'],
      "     'braket': [['(', ')'], ['[', ']'], ['{', '}'], ['/*', '*/']],
      "     'quotes': [['"', '"'], ["'", "'"]],
      "     'immutable': ['^\n', '\n\zs\s\+', '\s\+$']
      "   },
      " ]
