let g:projectionist_heuristics = {
      \   "lib/|test/": {
      \     "lib/*.js": {
      \       "alternate": "test/{}.js"
      \     },
      \     "test/*.js": {
      \       "alternate": "lib/{}.js"
      \     }
      \   },
      \   "tasks/|test/": {
      \     "tasks/*.js": {
      \       "alternate": "test/{}.js"
      \     },
      \     "test/*.js": {
      \       "alternate": "tasks/{}.js"
      \     }
      \   }
      \ }
