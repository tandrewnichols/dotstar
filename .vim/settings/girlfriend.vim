nnoremap <C-w><C-f> <C-w>vgf

call girlfriend#register#directory('manta-frontend', {
  \   'server/routes/*': {
  \     'suffixesadd': ['js', 'html'],
  \     'path': ['server/views', 'server/lib/data-builders'],
  \     'includeexpr': 'join([v:fname, "index"], "/")',
  \     'scopes': [
  \       {
  \         'pattern': [
  \           'name: ''\zs\f\+\ze''' 
  \         ]
  \       },
  \       {
  \         'pattern': [
  \           'builder: ''\zs\f\+\ze''' 
  \         ]
  \       }
  \     ]
  \   },
  \   'server/views/*': {
  \     'suffixesadd': 'html',
  \     'path': 'server/views/partials',
  \     'scopes': [
  \       {
  \         'pattern': [
  \           '{{>\s*\zs\f\+\ze\s*}}'
  \         ]
  \       }
  \     ]
  \   },
  \   'client/app/*': {
  \     'suffixesadd': 'js',
  \     'path': [
  \       'client/app/directives/**',
  \       'client/app/controllers/**',
  \       'client/app/admin/controllers/**',
  \       'client/app/components/**',
  \       'client/app/admin/components/**',
  \       'client/app/services',
  \       'client/app/templates',
  \       'client/app/admin/templates'
  \     ],
  \     'includeexpr': 'v:fname =~ "/" ? substitute(v:fname, "^admin/", "", "") : g:Abolish.dashcase(v:fname)',
  \     'scopes': [
  \       {
  \         'ft_include': 'javascript',
  \         'pattern': [
  \           'templateUrl: ''\zs\f\+\ze''',
  \           'controller: ''\zs\k\+\ze'''
  \         ]
  \       },
  \       {
  \         'ft_include': 'html',
  \         'pattern': [
  \           '\(ng-\)\?include="''\zs\f\+\ze''',
  \           'ng-controller="\zs\k\+\ze\( as vm\)\?"'
  \         ]
  \       }
  \     ]
  \   },
  \   'server/dev-routes/*': {
  \     'suffixesadd': ['js', 'json'],
  \     'path': 'common/spec-data'
  \   }
  \ })

call girlfriend#register#filetypes(['javascript', 'coffeescript'], {
  \   'suffixesadd': ['js', 'coffee', 'json']
  \ })
