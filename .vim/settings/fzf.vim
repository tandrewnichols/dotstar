let s:fzf_no_graph = '--color="always" --pretty=format:"%C(green)%<(14)%cn %C(auto)%h%d %s %C(cyan)%cr"'
let s:fzf_with_graph = '--graph --color="always" --pretty=format:"%C(green)%cn %C(auto)%h%d %s %C(cyan)%cr"'

let s:base_rip = 'rg --column --line-number --no-heading --hidden --follow --color "always"'

function! s:CallRipGrep(smartcase, where, ...) abort
  let args = copy(a:000)
  let flags = []
  let terms = []

  let cmd = s:base_rip

  if a:smartcase
    let cmd .= ' --smart-case '
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

  let term = join(terms, ' ')
  let term = '"' . term . '"'

  if len(flags)
    let cmd .= join(flags, ' ') . ' '
  endif

  let cmd .= term  . ' ' . where
  call fzf#vim#grep(cmd, 1, { 'options': '--expect='. join(keys(s:actions), ',') })
endfunction

function! s:RipWithRange(smartcase, where) range
  let lines = join(getline(a:firstline, a:lastline), '\n')
  call s:CallRipGrep(a:smartcase, a:where, lines)
endfunction

function! SetRipOpDir(dir) abort
  let s:rip_opt_dir = a:dir
endfunction

function! OperatorRip(wiseness) abort
  if a:wiseness ==# 'char'
    normal! `[v`]"ay
    call s:CallRipGrep(1, s:rip_opt_dir, @a)
  elseif a:wiseness ==# 'line'
    '[,']call s:RipWithRange(1, s:rip_opt_dir)
  endif
endfunction

nmap gr <Plug>(operator-ripgrep-root)
vmap gr <Plug>(operator-ripgrep-root)
call operator#user#define('ripgrep-root', 'OperatorRip', 'call SetRipOpDir(RootRelativeToCwd())')

nmap gR <Plug>(operator-ripgrep-rel)
vmap gR <Plug>(operator-ripgrep-rel)
call operator#user#define('ripgrep-rel', 'OperatorRip', 'call SetRipOpDir(expand("%:h"))')

nmap g- <Plug>(operator-ripgrep-cwd)
vmap g- <Plug>(operator-ripgrep-cwd)
call operator#user#define('ripgrep-cwd', 'OperatorRip', 'call SetRipOpDir(getcwd())')

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

command! -bang -nargs=* Rip :call s:CallRipGrep(<bang>1, RootRelativeToCwd(), <f-args>)
command! -bang -nargs=* Ripcwd :call s:CallRipGrep(<bang>1, getcwd(), <f-args>)
command! -bang -nargs=* Ripfile :call s:CallRipGrep(<bang>1, expand("%:h"), <f-args>)
command! -bang -nargs=* -complete=file Ripwhere :call s:CallRipGrep(<bang>1, '', <f-args>)
command! -bang -nargs=0 Scripts :call s:FzfScriptnames(<bang>0)
command! -bang -nargs=0 SoScript :call s:FzfScriptnames(<bang>0, 'so')
command! -bang -nargs=0 RunScript :call s:FzfScriptnames(<bang>0, 'Runtime!')

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><tab> <plug>(fzf-maps-i)

function! s:GitCheckoutAction(branch)
  exec "silent! Git checkout" a:branch
  redraw!
endfunction

function! s:GitDeleteAction(branches)
  exec "silent! Git branch -D" join(a:branches, ' ')
  redraw!
endfunction

function! s:FzfBranches(bang, all, fn, ...)
  let extra = a:0 == 1 ? a:1 . ' ' : ''
  let branches = split(system('git branch'), '\n')[0:-2]
  let branches = filter(branches, 'stridx(v:val, "\*")')
  let branches = map(branches, 'substitute(v:val, "^ *", "", "")')
  let branches = map(branches, 'substitute(v:val, " *$", "", "")')
  let opts = {
    \   'source': branches,
    \   'options': extra . '-x --ansi --header-lines=1 -d "\s\+" --prompt="Branch> "'
    \ }

  if a:all
    let opts['sink*'] = function(a:fn)
  else
    let opts.sink = function(a:fn)
  endif

  call fzf#run(fzf#wrap('gitbranch', opts, a:bang))
endfunction

command! -bang -nargs=0 Branches :call s:FzfBranches(<bang>0, 0, 's:GitCheckoutAction')
command! -bang -nargs=0 GbranchDel :call s:FzfBranches(<bang>0, 1, 's:GitDeleteAction', '-m')

nnoremap \b :Buffers<CR>
nnoremap \B :Branches<CR>
nnoremap \c :call <SID>CommitFormat(1)<CR>
nnoremap \C :call <SID>CommitFormat(0)<CR>
nnoremap \f :Files<CR>
nnoremap \F :GFiles<CR>
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
