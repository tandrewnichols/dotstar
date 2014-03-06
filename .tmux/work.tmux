send-keys 'server' C-m
rename-window vim
new-window -n grunt
send-keys 'server' C-m
new-window -n 'lineman run'
send-keys 'client' C-m
send-keys 'lineman run' C-m
new-window -n 'lineman spec'
send-keys 'client' C-m
send-keys 'lineman spec' C-m
new-window -n 'lineman e2e'
send-keys 'client' C-m
select-window -t 0
