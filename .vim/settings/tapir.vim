" call tapir#env('smoketest', {
"   \   'stack': 'manta-site.e2e.smoketest.aws.ecnext.net',
"   \ })
"
" call tapir#env('production', {
"   \   'stack': 'manta-site.main.production.aws.ecnext.net'
"   \ })

" call tapir#var('smoketest-auth-service', 'http://authorization-service.manta-site.e2e.smoketest.aws.ecnext.net{{path}}')
