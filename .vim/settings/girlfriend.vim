call girlfriend#register#directory('manta-frontend', {
  \   'server/views/*': {
  \     'suffixesadd': 'html',
  \     'path': 'server/views/partials',
  \     'scopes': [
  \       {
  \         'ft_whitelist': 'html',
  \         'pattern': [
  \           '{{>\s*\zs\f\+\ze\s*}}'
  \         ]
  \       }
  \     ]
  \   },
  \   'client/app/*': {
  \     'suffixesadd': 'js',
  \     'path': ['client/app/templates', 'client/app/js/directives/**', 'client/app/js/controllers/**', 'client/app/js/services'],
  \     'includeexpr': 'g:Abolish.dashcase(v:fname)',
  \     'scopes': [
  \       {
  \         'ft_whitelist': 'javascript',
  \         'pattern': [
  \           'templateUrl: ''\zs\f\+\ze''',
  \           'controller: ''\zs\k\+\ze'''
  \         ]
  \       },
  \       {
  \         'ft_whitelist': 'html',
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
