if split(projectroot#guess(expand("%:p")), '/')[-1] ==# 'manta-frontend'
  nnoremap <buffer> <leader>cdc :call CdToDirectory('client')<CR>
  nnoremap <buffer> <leader>cds :call CdToDirectory('server')<CR>
  nnoremap <buffer> <leader>cdt :call CdToDirectory('tasks')<CR>
endif
