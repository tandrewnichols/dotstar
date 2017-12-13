let g:grepper = {
      \   'tools': ['grep', 'ag', 'git'],
      \   'dir': 'repo,cwd',
      \   'repo': ['.git'],
      \   'next_tool': '<c-n>',
      \   'grep': {
      \     'grepprg': 'grep -rIn --exclude-dir=assets --exclude=access*.log --exclude=prebid*.js --exclude=yslow.js --exclude-dir=.git --exclude-dir=instrumented --exclude-dir=node_modules --exclude-dir=reports --exclude-dir=public --exclude-dir=dist --exclude-dir=generated --exclude-dir=bower_components --exclude-dir=vendor --exclude-dir=coverage $* .',
      \     'grepprgbuf': 'grep -HIn -- $* $.',
      \     'grepformat': '%f:%l:%m',
      \     'escape': '\^$.*[]'
      \   }
      \ }
nmap gr <Plug>(GrepperOperator)
xmap gr <Plug>(GrepperOperator)
vmap gr <Plug>(GrepperOperator)
