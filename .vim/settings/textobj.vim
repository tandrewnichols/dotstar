call textobj#user#plugin('object', {
\   'path': {
\     'pattern': "[\$a-zA-Z0-9_.]\*",
\     'select': ['io'],
\   },
\   'full': {
\     'pattern': "[\$a-zA-Z0-9_.]\*[\$a-zA-Z0-9_.[\\]]\*",
\     'select': ['ao'],
\   }
\ })

call textobj#user#plugin('hogan', {
\   'variable': {
\     'pattern': ['{{[#^>!\/]\?\s*', '\s*}}'],
\     'select-a': 'ah',
\     'select-i': 'ih'
\   }
\ })

call textobj#user#plugin('mustache', {
\   'variable': {
\     'pattern': ['{{[#^][^}]\{-}}}', '{{\/\?[^}]\{-}}}'],
\     'select-a': 'am',
\     'select-i': 'im'
\   }
\ })

" Same as above but for linewise copy/paste
call textobj#user#plugin('mustchetag', {
\   'variable': {
\     'pattern': ['{{[#^][^}]\{-}}}', '{{\/\?[^}]\{-}}}'],
\     'select-a': 'aM',
\     'select-i': 'iM',
\     'region-type': 'V'
\   }
\ })

" TODO: end at next block of the same level instead of the next block of any kind
function! s:SelectContextA() abort
  call search('x\?\(context\|describe\)\(\.only\)\? ''.\+'', ->', 'bcWz')
  let start = getpos('.')
  call search('x\?\(context\|describe\)\(\.only\)\? ''.\+'', ->', 'Wz')
  let end = getpos('.')
  return ['V', start, end]
endfunction

function! s:SelectContextI() abort
  call search('x\?\(context\|describe\)\(\.only\)\? ''.\+'', ->', 'bcWz')
  normal! j
  let start = getpos('.')
  call search('x\?\(context\|describe\)\(\.only\)\? ''.\+'', ->', 'Wz')
  normal! k
  if getline('.') =~ '^$'
    normal! k
  endif
  let end = getpos('.')
  return ['V', start, end]
endfunction

let s:sfile = expand("<sfile>")

function! s:CreateTestContextTextObj() abort
  call textobj#user#plugin('testcontext', {
    \   'variable': {
    \     'sfile': s:sfile,
    \     'select-a': 'aT',
    \     'select-i': 'iT',
    \     'select-a-function': 's:SelectContextA',
    \     'select-i-function': 's:SelectContextI'
    \   }
    \ })
endfunction

augroup TextObjTestContext
  au!
  au BufEnter *spec*.coffee call s:CreateTestContextTextObj()
augroup END

" TODO: implement key/value grabbing
" call textobj#user#plugin('keyvalue', {
" \   'kv-i': {
" \     'pattern': '[\'"]\<\?[^:]\{-}:\s?[\'"]
" \   }
" \ })

" Redefine matchit textobj mapping
xmap a%  <Plug>(textobj-matchit-a)
omap a%  <Plug>(textobj-matchit-a)
xmap i%  <Plug>(textobj-matchit-i)
omap i%  <Plug>(textobj-matchit-i)

let g:textobj#quote#educate = 0
nnoremap <silent> <leader>r" ggvG<Plug>ReplaceWithStraight
nnoremap <silent> <leader>r' ggvG<Plug>ReplaceWithStraight
vnoremap <silent> <leader>r" <Plug>ReplaceWithStraight
vnoremap <silent> <leader>r' <Plug>ReplaceWithStraight

" Redefine css textobj mapping
xmap acs <Plug>(textobj-css-a)
omap acs <Plug>(textobj-css-a)
xmap ics <Plug>(textobj-css-i)
omap ics <Plug>(textobj-css-i)

xmap acc <Plug>(textobj-comment-a)
omap acc <Plug>(textobj-comment-a)
xmap icc <Plug>(textobj-comment-i)
omap icc <Plug>(textobj-comment-i)
xmap aCc <Plug>(textobj-comment-big-a)

let g:skip_default_textobj_word_column_mappings = 1

xnoremap <silent> aco :<C-u>call TextObjWordBasedColumn("aw")<CR>
xnoremap <silent> aCo :<C-u>call TextObjWordBasedColumn("aW")<CR>
xnoremap <silent> ico :<C-u>call TextObjWordBasedColumn("iw")<CR>
xnoremap <silent> iCo :<C-u>call TextObjWordBasedColumn("iW")<CR>
onoremap <silent> aco :call TextObjWordBasedColumn("aw")<CR>
onoremap <silent> aCo :call TextObjWordBasedColumn("aW")<CR>
onoremap <silent> ico :call TextObjWordBasedColumn("iw")<CR>
onoremap <silent> iCo :call TextObjWordBasedColumn("iW")<CR>

xmap aN <Plug>(textobj-lastpat-n)
omap aN <Plug>(textobj-lastpat-n)
xmap iN <Plug>(textobj-lastpat-n)
omap iN <Plug>(textobj-lastpat-n)
xmap aP <Plug>(textobj-lastpat-N)
omap aP <Plug>(textobj-lastpat-N)
xmap iP <Plug>(textobj-lastpat-N)
omap iP <Plug>(textobj-lastpat-N)

" b for block, as in paragraph, not the
" standard ab and ib block which can also
" be done with { and }.
" See ../yankring.vim
" xnoremap ab ap
" onoremap ab ap
" xnoremap ib ip
" onoremap ib ip
let g:targets_nl = 'np'

"======textobjs=======
" " = quotes
" # = hashes
" $ = dollar signs
" % = matchit
" & = ampersands
" ' = single quoes
" ( = parens
" ) = parens
" * = stars
" + = plusses
" , = commas
" - = minuses
" . = dots
" / = slashes
" : = colons
" ; = semi-colons
" < = angled brackets
" = = equals
" > = angled brackets
" B = brackets
" Cc = comment with whitespace
" Co = columns, but bigger?
" E = ERB interpolation
" M = mustache tag (contents of the tag, linewise)
" N = lastpat forwards
" P = lastpat backwards
" S = space
" W = WORD
" [ = brackets
" \ = back slashes
" ] = bracket
" _ = underscores
" ` = backticks
" a = argument
" b = block
" cs = css
" cc = comment
" co = column
" da = datetime auto
" dd = datetime date
" df = datetime full
" dt = datetime time
" dz = datetime timezone
" e = everything
" f = function
" g = gitgutter hunk
" h = hogan interpolation (inner contents of {{ }})
" i = indent
" l = line
" m = mustache tag(contents of the tag, non-linewise)
" n = next
" o = object path
" p = previous
" q = quote
" s = sentence
" t = tag
" u = uri
" v = variable segment
" w = word
" x = xml/html attribute
" y = syntax
" { = brackets
" | = pipes
" } = brackets
" ~ = tildes
