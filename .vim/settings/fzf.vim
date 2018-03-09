let s:fzf_no_graph = '--color="always" --pretty=format:"%C(green)%<(14)%cn %C(auto)%h%d %s %C(cyan)%cr"'
let s:fzf_with_graph = '--graph --color="always" --pretty=format:"%C(green)%cn %C(auto)%h%d %s %C(cyan)%cr"'

let s:base_rip = 'rg --column --line-number --no-heading --fixed-strings --hidden --follow --color "always" --glob "!node_modules/*" --glob "!*/bower_components/*" --glob "!.git/*"'

let g:fzf_tags_command = 'es-ctags -R --exclude node_modules --exclude bower_components'

function! s:CallRipGrep(smartcase, where, ...) abort
  let args = copy(a:000)
  let flags = []
  let terms = []

  let cmd = s:base_rip

  if a:smartcase
    let cmd .= '--smart-case '
  endif

  for arg in args
    if match(arg, '^-') == 0
      call add(flags, arg)
    else
      call add(terms, arg)
    endif
  endfor

  let where = a:where
  
  if where == ''
    let where = remove(terms, -1)
  endif

  let term = '"' . substitute(shellescape(join(terms, ' ')), "'", '', 'g') . '"'

  if len(flags)
    let cmd .= join(flags, ' ') . ' '
  endif

  let cmd .= term  . ' ' . where
  call fzf#vim#grep(cmd, 1, 0)
endfunction

let s:actions = {
  \   'ctrl-t': 'tabe',
  \   'ctrl-x': 'split',
  \   'ctrl-v': 'vsplit'
  \ }

function! s:ScriptnamesAction(action, lines) abort
  let default = a:action == '' ? 'e' : a:action
  let lines = a:lines
  let action = remove(lines, 0)
  for line in a:lines
    let script = matchstr(line, '[0-9]\{1,3} *\zs.\+\ze')
    let cmd = get(s:actions, action, default)
    execute cmd script
  endfor
endfunction

function! s:ParseScriptLine(line)
  let [ num, script ] = split(a:line, ' ')
  let num = printf("%-3s", num[0:-2])
  return s:strip(printf("%s %s", s:yellow(num, 'Number'), s:yellow(script, 'Structure')))
endfunction

function! s:FzfScriptnames(bang, ...) abort
  redir => scripts
  silent! scriptnames
  redir END

  let source = split(scripts, '\n')

  let lines = map(source, 's:ParseScriptLine(v:val)')
  let opts = {
    \   'source': lines,
    \   'options': '-m -x --ansi --header-lines=1 -d "\s\+" --prompt="Script> "'
    \ }

  let args = a:0 > 0 ? [a:1] : ['']
  let opts = fzf#wrap('scriptnames', opts, 0)
  let opts['sink*'] = function('s:ScriptnamesAction', args)
  call fzf#run(opts)
endfunction

function! s:CommitFormat(buffer)
  if a:buffer
    let g:fzf_commits_log_options = s:fzf_no_graph
    BCommits
  else
    let g:fzf_commits_log_options = s:fzf_with_graph
    Commits
  endif
endfunction

command! -bang -nargs=* Rip :call s:CallRipGrep(<bang>1, projectroot#guess(expand("%:p")), <f-args>)
command! -bang -nargs=* Ripcwd :call s:CallRipGrep(<bang>1, getcwd(), <f-args>)
command! -bang -nargs=* Ripfile :call s:CallRipGrep(<bang>1, expand("%:h"), <f-args>)
command! -bang -nargs=* -complete=file Ripwhere :call s:CallRipGrep(<bang>1, '', <f-args>)
command! -bang -nargs=0 Scripts :call s:FzfScriptnames(<bang>0)
command! -bang -nargs=0 SoScript :call s:FzfScriptnames(<bang>0, 'so')
command! -bang -nargs=0 RunScript :call s:FzfScriptnames(<bang>0, 'Runtime!')

nnoremap \b :Buffers<CR>
nnoremap \c :call <SID>CommitFormat(1)<CR>
nnoremap \C :call <SID>CommitFormat(0)<CR>
nnoremap \f :Files<CR>
nnoremap \g :GFiles?<CR>
nnoremap \h :History:<CR>
nnoremap \H :Helptags<CR>
nnoremap \l :Lines<CR>
nnoremap \m :Maps<CR>
nnoremap \r :Rip 
nnoremap \R :RunScript<CR>
nnoremap \s :Scripts<CR>
nnoremap \S :SoScript<CR>
nnoremap \/ :History/<CR>
nnoremap \: :Commands<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><tab> <plug>(fzf-maps-i)


"--- Lifted from junegunn/fzf.vim ---"

function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction

function! s:get_color(attr, ...)
  let gui = has('termguicolors') && &termguicolors
  let fam = gui ? 'gui' : 'cterm'
  let pat = gui ? '^#[a-f0-9]\+' : '^[0-9]\+$'
  for group in a:000
    let code = synIDattr(synIDtrans(hlID(group)), a:attr, fam)
    if code =~? pat
      return code
    endif
  endfor
  return ''
endfunction

let s:ansi = {'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36}

function! s:csi(color, fg)
  let prefix = a:fg ? '38;' : '48;'
  if a:color[0] == '#'
    return prefix.'2;'.join(map([a:color[1:2], a:color[3:4], a:color[5:6]], 'str2nr(v:val, 16)'), ';')
  endif
  return prefix.'5;'.a:color
endfunction

function! s:ansi(str, group, default, ...)
  let fg = s:get_color('fg', a:group)
  let bg = s:get_color('bg', a:group)
  let color = s:csi(empty(fg) ? s:ansi[a:default] : fg, 1) .
        \ (empty(bg) ? '' : s:csi(bg, 0))
  let val = printf("\x1b[%s%sm%s\x1b[m", color, a:0 ? ';1' : '', a:str)
  return val
endfunction

for s:color_name in keys(s:ansi)
  execute "function! s:".s:color_name."(str, ...)\n"
        \ "  return s:ansi(a:str, get(a:, 1, ''), '".s:color_name."')\n"
        \ "endfunction"
endfor