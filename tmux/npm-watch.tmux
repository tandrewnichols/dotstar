split-window -v -p 30
send-keys 'dir=$(pwd)' C-m
send-keys 'cd $dir' C-m
send-keys 'npm run-script watch' C-m 
last-pane
