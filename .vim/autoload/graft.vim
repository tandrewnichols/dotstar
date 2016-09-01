let s:counter = 1
function! graft#RegisterFiletype(filetype)
  execute "augroup graftRegisterFileType_" . a:filetype . "_" . s:counter
  let s:counter += 1
  execute "autocmd!"
  execute "autocmd Filetype " . a:filetype . " echo \"Filetype " . a:filetype . " was loaded\""
  execute "augroup END"
endfunction

function! graft#Run(type)

endfunction
