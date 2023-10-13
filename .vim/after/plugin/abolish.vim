if exists('g:noplugins') || exists('g:bones') | finish | endif

Abolish copmany company
Abolish withing within
Abolish sycned synced

" Add titlecase back to Abolish
function! s:snakecase(word)
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)
  return word
endfunction

function! s:spacecase(word)
  return substitute(s:snakecase(a:word),'_',' ','g')
endfunction

function! s:function(name) abort
  return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '.*\zs<SNR>\d\+_'),''))
endfunction

function! s:titlecase(word)
  return substitute(s:spacecase(a:word), '\(\<\w\)','\=toupper(submatch(1))','g')
endfunction

call extend(g:Abolish, {
  \   'titlecase': s:function('s:titlecase')
  \ })
