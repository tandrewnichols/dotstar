call textobj#user#plugin('object', {
\   'path': {
\     'pattern': "[\$a-zA-Z0-9_.]\*",
\     'select': ['io'],
\   },
\   'full': {
\     'pattern': "[\$a-zA-Z0-9_.]\*[\$a-zA-Z0-9_.[\\]]\*",
\     'select': ['ao'],
\   }
\ })

