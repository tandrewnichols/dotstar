call tmux#create('GruntWatchCi', 'grunt watch:ci')
call tmux#create('GruntWatchUnit', 'grunt watch:unit')
call tmux#create('GruntWatchE2e', 'grunt watch:e2e')
call tmux#create('GruntCi', 'grunt ci')
call tmux#create('GruntSpecUnit', 'grunt spec:unit')
call tmux#create('GruntSpecE2e', 'grunt spec:e2e')
