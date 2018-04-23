if exists("g:loaded_tmux") || &cp | finish | endif

let g:loaded_tmux = 1

" TODO: Look into 'watch' (or other) for monitoring/polling for tmux pane changes

let g:tmux_manifest = {}

function! s:BuildTmuxManifest() abort
  let sessions = split(system('tmux ls'), '\n')
  for session in sessions
    call s:GetWindowInSession(session)
  endfor

  " echo system('node -e "console.log(JSON.stringify(' . string(g:tmux_manifest) . ', null, 2))"')
endfunction

function! s:GetWindowInSession(session)
  let name = split(a:session, ':')[0]
  let windows = split(system('tmux list-windows -t ' . name), '\n')
  for window in windows
    call s:GetPanesInWindow(name, window)
  endfor
endfunction

function! s:GetPanesInWindow(session, window)
  let name = split(a:window, ':')[0]
  let panes = split(system('tmux list-panes -F "#{pane_index} #{pane_current_command} #{pane_pid}" -t ' . a:session . ':' . name), '\n')
  for pane in panes
    let [num, process, pid] = split(pane, ' ')
    let key = printf('%s:%d.%d', a:session, name, num)
    if process !=# 'bash'
      call s:FindChildOfParentPid(key, pid)
    else
      let g:tmux_manifest[ key ] = process
    endif
  endfor
endfunction

function! s:FindChildOfParentPid(key, parent) abort
  let info = split(system('ps -o pid -o ppid -o args | grep "[0-9]\+\s\+' . a:parent . '"'), '\n')

  if len(info)
    let parts = split(info[0], '\s\+')
    let pid = remove(parts, 0)
    let parent = remove(parts, 0)
    let args = join(parts, ' ')
    let g:tmux_manifest[ a:key ] = args
    call s:FindChildOfParentPid(a:key, pid)
  endif
endfunction

call s:BuildTmuxManifest()

command! -nargs=* -complete=custom,tmux#getPanes TmuxSend call tmux#sendKeys(<f-args>)
