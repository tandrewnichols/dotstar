function! Log(message)
  if bufexists("_live_logger") > 0
    vertical sbuffer _live_logger
    $put=a:message
    execute "normal \<C-W>h"
  else
    vnew | setlocal switchbuf=usetab buftype=nofile noswapfile | file _live_logger
    $put=a:message
    execute "normal \<C-W>h"
  endif
endfunction

function! TabLog()
  tabe _live_logger
endfunction
