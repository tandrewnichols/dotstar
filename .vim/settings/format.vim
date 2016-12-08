function! s:FormatJsObj()
  execute "normal maF{vf}:s/\\v(,|\\s*\\{)\\s*/\\1\\r/g\<CR>\<S-V>:s/\\v\\s*\\}\\s*/\\r\\}/g\<CR>\<S-V>'a=dma"
endfunction

command! Format call <SID>FormatJsObj()
