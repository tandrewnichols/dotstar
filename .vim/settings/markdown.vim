augroup markdownCodeFences
    au!
    au BufNewFile,BufRead *.md,*.markdown call EnableMarkdownCodeFences()
augroup END

function! EnableMarkdownCodeFences()
  let text = join(getline(1,'$'), "\n")
  call TextEnableCodeSnip('javascript', '```js', '```', 'SpecialComment')
  call TextEnableCodeSnip('javascript', '```javascript', '```', 'SpecialComment')
  call TextEnableCodeSnip('javascript', '```json', '```', 'SpecialComment')
  call TextEnableCodeSnip('sh', '```bash', '```', 'SpecialComment')
  call TextEnableCodeSnip('sh', '```shell', '```', 'SpecialComment')
  call TextEnableCodeSnip('html', '```html', '```', 'SpecialComment')
  call TextEnableCodeSnip('coffee', '```coffee', '```', 'SpecialComment')
  call TextEnableCodeSnip('coffee', '```coffeescript', '```', 'SpecialComment')
  call TextEnableCodeSnip('xml', '```xml', '```', 'SpecialComment')
  call TextEnableCodeSnip('pug', '```pug', '```', 'SpecialComment')
  call TextEnableCodeSnip('pug', '```jade', '```', 'SpecialComment')
  call TextEnableCodeSnip('markdown', '```markdown', '```', 'SpecialComment')
  call TextEnableCodeSnip('css', '```css', '```', 'SpecialComment')
  call TextEnableCodeSnip('less', '```less', '```', 'SpecialComment')
endfunction

function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction
