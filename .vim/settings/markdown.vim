let g:markdown_fenced_languages = ['js=javascript', 'html', 'css', 'less', 'bash=sh', 'vim', 'ruby']

function! s:StopJob() abort
  call job_stop(s:job)
  unlet s:job
endfunction

function! s:StartJob() abort
  let s:job = job_start(['mdlive', '--file', expand('%')])
  au markdown BufDelete *.md call <SID>StopJob()
endfunction

augroup markdown
  au!
  au Filetype markdown command! -buffer Markdown call <SID>StartJob()
augroup END
