" vim-eunuch is deprecating :Remove, but I prefer it
" to delete because it's more analogous to "rm" and
" because :delete is a thing, so tab completion is
" cleaner with :Remove
if !exists(':Remove')
  command -bang Remove Delete<bang>
endif
