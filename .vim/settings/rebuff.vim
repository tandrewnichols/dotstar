if exists("g:rebuff_loaded") || &cp | finish | endif

function! s:Set(option, def)
  exec "let g:rebuff_" . a:option . " = get(g:, 'rebuff_" . a:option . "', a:def)"
endfunction

function! s:Get(option)
  exec "return g:rebuff_" . a:option
endfunction

call s:Set('show_unlisted', 0)
call s:Set('show_directories', 0)
call s:Set('show_hidden', 1)
call s:Set('show_help', 0)
call s:Set('show_top_content', 1)
call s:Set('default_sort_order', 'num')
call s:Set('vertical_split', 1)
call s:Set('window_size', 80)
call s:Set('relative_to_project', 1)
call s:Set('show_help_entries', 0)
call s:Set('show_nonexistent', 0)
call s:Set('open_with_count', 1)
call s:Set('copy_absolute_path', 1)
call s:Set('incremental_filter', 1)
call s:Set('preserve_toggles', 0)
call s:Set('window_position', 'rightbelow')
call s:Set('preview', 1)
call s:Set('reset_timeout', 1)
call s:Set('debounce_preview', 150)

let s:sort_methods = ['num', 'name', 'extension', 'root', 'mru']

let s:logo = [
      \  '   ___      __        ______',
      \  '  / _ \___ / /  __ __/ _/ _/',
      \  ' / , _/ -_) _ \/ // / _/ _/ ',
      \  '/_/|_|\__/_.__/\_,_/_//_/   '
      \]

let s:help_text = [
      \ '',
      \ '',
      \ '======================= HELP =======================',
      \ ' ?           Toggle help.',
      \ ' [count]<CR> With count, jump to or open buffer number [count].',
      \ '             Without count, open buffer under cursor.',
      \ ' -           Delete buffer under cursor.',
      \ ' +           Show only modified files.',
      \ ' .           Filter by file extension.',
      \ ' /           Filter by arbitrary text.',
      \ ' ~           Show only files in this project.',
      \ ' %           Copy path of buffer under cursor.',
      \ ' }           Jump to bottom of list.',
      \ ' {           Jump to top of list.',
      \ ' d           Toggle whether directories are shown.',
      \ ' e           Sort by file extension.',
      \ ' f           Sort by filename.',
      \ ' h           Toggle whether hidden buffers are shown.',
      \ ' H           Toggle help entries.',
      \ ' j | <Down>  Preview next buffer.',
      \ ' k | <Up>    Preview previous buffer.',
      \ ' n           Sort by buffer number.',
      \ ' q | <Esc>   Close Rebuff and revert to original buffer.',
      \ ' r           Reset original buffer list.',
      \ ' R           Reverse current buffer listing.',
      \ ' s           Open buffer under cursor in horizontal split.',
      \ ' S           Toggle sort method.',
      \ ' t           Open buffer under cursor in new tab.',
      \ ' T           Open buffer under cursor in background tab.',
      \ ' u           Toggle whether unlisted buffers are shown.',
      \ ' v           Open buffer under cursor in vertical split.',
      \ ' w           Wipeout buffer under cursor.',
      \ ' x           Toggle top content.',
      \]

function! Rebuff()
  let s:originBuffer = bufnr("%")
  silent let rawBufs = s:GetBufferList()

  let size = s:Get('window_size')
  let command = s:Get('vertical_split') ? 'vnew' : 'new'

  call s:CreateAugroup()

  if !empty("g:rebuff_window_position") && s:Get('window_position')
    exec s:Get('window_poisition') "keepjumps hide" size . command "[Rebuff]"
  else
    exec "keepjumps hide" size . command "[Rebuff]"
  endif

  let b:logo = s:BuildLogo(size)
  let b:buffer_objects = s:ParseBufferList(rawBufs)
  let b:orig_buffers = copy(b:buffer_objects)

  call s:SetBufferFlags()

  let b:current_sort = s:Get('default_sort_order')

  call s:Render()

  call s:ConfigureBuffer()
  call s:HighlightBuffer()
endfunction

function! s:GetBufferList()
  redir => bufoutput

  " Show all buffers including the unlisted ones.
  " [!] tells Vim to show the unlisted ones.
  buffers!
  redir END

  return split(bufoutput, '\n')
endfunction

function! s:ParseBufferList(bufs)
  let returnList = []

  for str in a:bufs
    let num = s:ExtractBufNum(str)
    let flags = s:ExtractFlags(str)
    let name = s:ExtractFilename(str)

    let entry = { 'num': num, 'flags': flags, 'name': name }

    call s:CheckFilename(entry)
    call s:CheckFlags(entry)
    call add(returnList, entry)
  endfor

  return returnList
endfunction

function! s:GetRoot(name)
  if !s:Get('relative_to_project')
    return ''
  endif

  try
    let root = projectroot#get(a:name)
    if root == $HOME
      return '~'
    else
      let parts = split(root, '/')
      if len(parts)
        return parts[-1]
      endif
    endif
  catch
    return ''
  endtry
endfunction

function! s:CheckFilename(entry)
  let entry = a:entry
  let root = s:GetRoot(entry.name)
  let name = entry.name

  let entry.help = match(name, '\/') == -1 && match(name, '\.txt') > -1 && empty(glob(name))

  if !entry.help
    let name = fnamemodify(entry.name, ':p')
  endif

  let entry.exists = !empty(glob(name))
  let isDir = isdirectory(name)

  let entry.incwd = name =~ getcwd()
  let entry.inproject = getcwd() =~ root && !entry.help

  if entry.help
    let name = entry.name
  elseif entry.incwd
    let name = fnamemodify(entry.name, ":.")
  elseif entry.inproject && entry.name =~ '^\.\.'
    let name = entry.name
  elseif entry.inproject
    let name = s:RelativeTo(name, root)
  elseif !empty(root)
    let name = matchstr(name, root . '/.*$')
  endif

  if isDir
    let name .= '/'
  endif

  let entry.rawname = entry.name
  let entry.root = entry.help ? '' : root
  let entry.directory = isDir
  let entry.extension = fnamemodify(entry.name, ':e')

  let entry.name = name
  let entry.filename_length = len(entry.name)
endfunction

function! s:RelativeTo(name, where)
  let head = fnamemodify(getcwd(), ":h")
  let partial = substitute(head, '.*' . a:where, '', '')
  let base = '..' . split(a:name, a:where)[1]
  return substitute(partial, '\/[^\/]\+', '../', 'g') . base
endfunction

function! s:Matches(str, pat)
  return match(a:str, a:pat) > -1
endfunction

let s:flags = {
      \  'unlisted': 'u',
      \  'current': '%',
      \  'alternate': '#',
      \  'active': 'a',
      \  'hidden': 'h',
      \  'unmodifiable': '-',
      \  'readonly': '=',
      \  'running': 'R',
      \  'finished': 'F',
      \  'terminal': '[RF\?]',
      \  'modified': '+',
      \  'error': 'x'
      \}

function! s:CheckFlags(entry)
  let entry = a:entry
  let flags = entry.flags

  for key in keys(s:flags)
    let entry[ key ] = s:Matches(flags, s:flags[key])
  endfor

  let entry.flags = flags
  let entry.flag_length = len(flags)
endfunction

function! s:Trim(str)
  return substitute(substitute(a:str, '^ \+', '', ''), ' \+$', '', '')
endfunction

function! s:Pad(str, len)
  if len(a:str) < a:len
    return repeat(' ', a:len - len(a:str)) . a:str
  else
    return a:str
  endif
endfunction

function! s:CreateAugroup()
  augroup RebuffEnter
    autocmd!
    autocmd BufWinEnter \[Rebuff\] call s:SetMappings()
    autocmd BufWinLeave \[Rebuff\] call s:OnExit()
  augroup END
endfunction

function! s:SetBufferFlags()
  let b:current_sort = 'num'
  let b:current_filter = ''
  let b:toggles = exists('s:toggles') ? s:toggles : {
        \  'help': s:Get('show_help'),
        \  'help_entries': s:Get('show_help_entries'),
        \  'top_content': s:Get('show_top_content'),
        \  'unlisted': s:Get('show_unlisted'),
        \  'directories': s:Get('show_directories'),
        \  'hidden': s:Get('show_hidden'),
        \  'in_project': 0,
        \  'modified_only': 0,
        \  'reverse': 0
        \}
endfunction

function! s:ConfigureBuffer()
  let s:prev_timeout = &timeoutlen
  
  if s:Get('reset_timeout')
    let &timeoutlen = 0
  endif

  setlocal nonumber
  setlocal foldcolumn=0
  setlocal nofoldenable
  setlocal cursorline
  setlocal nospell
  setlocal nobuflisted
  setlocal filetype=rebuff
  setlocal buftype=nofile
  setlocal nomodifiable
  setlocal noswapfile
  setlocal nowrap
endfunction

function! s:Plug(name, cmd)
  exec "nnoremap <Plug>Rebuff" . a:name  a:cmd . "\<CR>"
endfunction

call s:Plug('ToggleHelpText', ":call \<sid>Toggle('help')")
call s:Plug('HandleEnter', ":\<C-u>call \<sid>HandleEnter(v:count)")
call s:Plug('DeleteBuffer', ":call \<sid>BufferAction('bd')")
call s:Plug('ToggleModified', ":call \<sid>Toggle('modified_only')")
call s:Plug('FilterByExtension', ":call \<sid>FilterBy('extension')")
call s:Plug('FilterByText', ":call \<sid>FilterBy('name')")
call s:Plug('ToggleHelpEntries', ":call \<sid>Toggle('help_entries')")
call s:Plug('ToggleInProject', ":call \<sid>Toggle('in_project')")
call s:Plug('CopyPath', ":call \<sid>CopyPath()")
call s:Plug('JumpToBottom', ":call \<sid>JumpTo(b:buffer_range[1])")
call s:Plug('JumpToTop', ":call \<sid>JumpTo(b:buffer_range[0])")
call s:Plug('ToggleDirectories', ":call \<sid>Toggle('directories')")
call s:Plug('SortByExtension', ":call \<sid>SetSortTo('extension')")
call s:Plug('SortByFilename', ":call \<sid>SetSortTo('name')")
call s:Plug('ToggleHidden', ":call \<sid>Toggle('hidden')")
call s:Plug('MoveDown', ":\<C-u>call \<sid>MoveTo('j', v:count)")
call s:Plug('MoveUp', ":\<C-u>call \<sid>MoveTo('k', v:count)")
call s:Plug('MoveDownAlt', ":\<C-u>call \<sid>MoveTo('j', v:count)")
call s:Plug('MoveUpAlt', ":\<C-u>call \<sid>MoveTo('k', v:count)")
call s:Plug('SortByBufferNumber', ":call \<sid>SetSortTo('num')")
call s:Plug('RestoreOriginal', ":call \<sid>RestoreOriginalBuffer()\<CR>:bw")
call s:Plug('EscapeRebuff', ":call \<sid>RestoreOriginalBuffer()\<CR>:bw")
call s:Plug('Reverse', ":call \<sid>Toggle('reverse')")
call s:Plug('Reset', ":call \<sid>Reset()")
call s:Plug('HorizontalSplit', ":call \<sid>OpenCurrentBufferIn('sb')")
call s:Plug('ToggleSort', ":call \<sid>ToggleSort()")
call s:Plug('OpenInTab', ":call \<sid>OpenCurrentBufferInTab()")
call s:Plug('OpenInBackgroundTab', ":call \<sid>OpenCurrentBufferInTab('background')")
call s:Plug('ToggleUnlisted', ":call \<sid>Toggle('unlisted')")
call s:Plug('VerticalSplit', ":call \<sid>OpenCurrentBufferIn('vert sb')")
call s:Plug('WipeoutBuffer', ":call \<sid>BufferAction('bw')")
call s:Plug('ToggleTop', ":call \<sid>Toggle('top_content')")

function! s:CreateMap(key, plug)
  let plug = "<Plug>Rebuff" . a:plug
  if !hasmapto(plug)
    exec "nmap <buffer> <silent> <nowait>" a:key plug
  endif
endfunction

function! s:SetMappings()
  call s:CreateMap('?', 'ToggleHelpText')
  call s:CreateMap("\<CR>", 'HandleEnter')
  call s:CreateMap("\<Esc>", 'EscapeRebuff')
  call s:CreateMap('-', 'DeleteBuffer')
  call s:CreateMap('+', 'ToggleModified')
  call s:CreateMap('.', 'FilterByExtension')
  call s:CreateMap('/', 'FilterByText')
  call s:CreateMap('~', 'ToggleInProject')
  call s:CreateMap('%', 'CopyPath')
  call s:CreateMap('}', 'JumpToBottom')
  call s:CreateMap('{', 'JumpToTop')
  call s:CreateMap('d', 'ToggleDirectories')
  call s:CreateMap('e', 'SortByExtension')
  call s:CreateMap('f', 'SortByFilename')
  call s:CreateMap('h', 'ToggleHidden')
  call s:CreateMap('H', 'ToggleHelpEntries')
  call s:CreateMap('j', 'MoveDown')
  call s:CreateMap('k', 'MoveUp')
  call s:CreateMap('n', 'SortByBufferNumber')
  call s:CreateMap('q', 'RestoreOriginal')
  call s:CreateMap('r', 'Reset')
  call s:CreateMap('R', 'Reverse')
  call s:CreateMap('s', 'HorizontalSplit')
  call s:CreateMap('S', 'ToggleSort')
  call s:CreateMap('t', 'OpenInTab')
  call s:CreateMap('T', 'OpenInBackgroundTab')
  call s:CreateMap('u', 'ToggleUnlisted')
  call s:CreateMap('v', 'VerticalSplit')
  call s:CreateMap('w', 'WipeoutBuffer')
  call s:CreateMap('x', 'ToggleTop')
  call s:CreateMap("\<Down>", 'MoveDownAlt')
  call s:CreateMap("\<Up>", 'MoveUpAlt')
endfunction

function! s:OnExit()
  if s:Get('preserve_toggles')
    let s:toggles = copy(b:toggles)
  endif

  if s:Get('reset_timeout')
    let &timeoutlen = s:prev_timeout
  endif
endfunction

function! s:PreviewBuffer()
  if s:Get('preview')
    let buf = s:GetBufferFromLine()
    if !empty(buf)
      call s:OpenInOtherSplit(buf.num)
    endif
  endif
endfunction

function! s:GetBufferFromLine()
  let line = getline('.')
  if !empty(line) && line =~ '^[ +]\+\d\+ [u%#ah=RF?x -]\+ [\~a-zA-Z0-9\/\._-]\+$'
    let num = s:ExtractBufNum(line)
    return s:FindBuffer('num', num)
  endif
endfunction

function! s:FindBuffer(key, val)
  for b in b:buffer_objects
    if b[ a:key ] == a:val
      return b
    endif
  endfor
endfunction

function! s:OpenInOtherSplit(num)
  wincmd p
  exec "b" a:num
  wincmd p
endfunction

function! s:RestoreOriginalBuffer()
  call s:OpenInOtherSplit(s:originBuffer)
endfunction

function! s:OpenCurrentBufferInTab(...)
  let curtab = tabpagenr()
  call s:RestoreOriginalBuffer()
  let target = s:GetBufferFromLine()

  bw
  tabnew
  let current = bufnr('%')
  exec "b" target.num
  " Cleanup the unnamed buffer created by tabnew
  exec "bw" current

  if a:0 == 1
    exec "normal!" curtab . "gt"
  endif
endfunction

function! s:OpenCurrentBufferIn(cmd)
  call s:RestoreOriginalBuffer()
  let buf = s:GetBufferFromLine()
  q
  exec a:cmd buf.num
endfunction

function! s:BufferAction(cmd)
  " Get the buffer to delete
  let buf = s:GetBufferFromLine()

  " Then delete the line from the buffer list
  setlocal modifiable
  normal! "_dd
  setlocal nomodifiable

  call s:RemoveBuffer(buf)

  " Then switch buffers so that the
  " buffer can be deleted
  call s:PreviewBuffer()

  " Delete the buffer
  exec a:cmd buf.num
endfunction

function! s:RemoveBuffer(buf)
  let i = index(b:buffer_objects, a:buf)
  call remove(b:buffer_objects, i)
endfunction

function! s:FilterBy(prop)
  if s:Get('incremental_filter')
    if !exists("b:filter_text")
      let b:filter_text = ""
    endif

    try
      let code = getchar()
    catch
      let code = "\<Esc>"
    endtry

    let char = type(code) == 0 ? nr2char(code) : code

    if char == "\<Esc>"
      let b:filter_text = ""
      let b:current_filter = ""
      call s:Render()
    elseif char == "\<CR>"
      let b:filter_text = ""
    else
      let b:filter_text .= escape(char, '/.~')
      let b:current_filter = 'v:val.' . a:prop . ' =~ ''' . b:filter_text . ''''
      call s:Render()
      redraw!
      call s:FilterBy(a:prop)
    endif
  else
    let text = input('/')
    let b:current_filter = 'v:val.' . a:prop . ' =~ ''' . escape(text, '/.~') . ''''
    call s:Render()
  endif
endfunction

function! s:CopyPath()
  let currentBuffer = s:GetBufferFromLine()
  let text = currentBuffer.name
  if s:Get('copy_absolute_path')
    let text = fnamemodify(currentBuffer.rawname, ":p")
  endif

  let @" = text
endfunction

let s:filters = {
      \ 'directories': '!v:val.directory',
      \ 'hidden': '!v:val.hidden',
      \ 'help_entries': '!v:val.help',
      \}

function! s:Filter()
  let list = copy(b:buffer_objects)
  let predicate = []

  if !b:toggles.unlisted
    if b:toggles.help_entries
      call add(predicate, '(!v:val.unlisted || v:val.help)')
    else
      call add(predicate, '!v:val.unlisted')
    endif
  endif

  if b:toggles.modified_only
    call add(predicate, 'v:val.modified')
  endif

  if b:toggles.in_project
    call add(predicate, 'v:val.inproject')
  endif

  for k in keys(s:filters)
    if !b:toggles[ k ]
      call add(predicate, s:filters[ k ])
    endif
  endfor

  if !empty(b:current_filter)
    call add(predicate, b:current_filter)
  endif

  if len(predicate)
    return filter(list, join(predicate, ' && '))
  else
    return list
  endif
endfunction

function! s:FilterUnlisted(list)
  let pattern = '\d \+u'
  let list = filter(copy(a:list), 'v:val !~ pattern')
  return list
endfunction

function! s:Render(...)
  " Save off the current cursor position
  let currentBuffer = s:GetBufferFromLine()

  setlocal modifiable

  " Clear the whole buffer
  normal! "_ggdG

  " Render the top content unless it's being hidden
  if b:toggles.top_content
    call setline(1, b:logo)
  endif

  let list = s:Filter()
  if len(list)
    let list = s:Sort(list)
  endif
  let lines = s:Map(list, function('s:ConstructEntry'))

  if b:toggles.reverse
    call reverse(lines)
  endif

  " Render the current list
  call setline('$', lines)

  call s:SetBufferRange(lines)

  " Render help unless it's being hidden
  if b:toggles.help
    call append('$', s:help_text)
  endif

  setlocal nomodifiable

  if a:0 == 1 && a:1 == 1
    call search('%')
    normal! 0
  else
    call s:SetCursorPosition(currentBuffer)
  endif

  " And preview the current line
  call s:PreviewBuffer()
endfunction

function! s:SetBufferRange(lines)
  let start = b:toggles.top_content ? len(b:logo) : 0
  let end = start + len(a:lines)
  let b:buffer_range = [start, end]
endfunction

function! s:SetCursorPosition(currentBuffer)
  " Try to position onto the same buffer as before
  if empty(a:currentBuffer) || !search(a:currentBuffer.num . '')
    " If that fails, position on the current buffer
    if !search('%')
      " And then if that fails (e.g. when filtering) just
      " use the first line in the buffer range
      call setpos('.', [bufnr('%'), b:buffer_range[0], 0, 0])
    endif
  endif
  
  " Make sure we're at the beginning of the line
  normal! 0
endfunction

function! s:Map(list, fn)
  return map(copy(a:list), a:fn)
endfunction

function! s:ConstructEntry(i, entry)
  let entry = a:entry
  let line = '  '
  let line .= entry.modified ? '+' : ' '
  let line .= s:Pad(entry.num, 3)
  let line .= ' '
  let line .= s:Pad(entry.flags, 5)
  let line .= ' '
  let line .= entry.name
  return line
endfunction

function! s:Toggle(option)
  let b:toggles[ a:option ] = !b:toggles[ a:option ]
  call s:Render()
endfunction

function! s:MoveTo(dir, count)
  let suffix = !empty(a:count) ? a:count . a:dir : a:dir
  exec "normal!" suffix

  " Debounce previewing for faster scrolling
  if s:Get('debounce_preview')
    if exists("b:preview_timeout")
      call timer_stop(b:preview_timeout)
    endif

    let b:preview_timeout = timer_start(s:Get('debounce_preview'), function('s:CallPreview'))
  else
    call s:PreviewBuffer()
  endif
endfunction

function! s:CallPreview(...)
  unlet b:preview_timeout
  call s:PreviewBuffer()
endfunction

function! s:HighlightBuffer()
  if has("syntax")
    " Top content definitions
    syn match rebuffBorder     "^-\+$"
    syn match rebuffLogo       "^|\zs.\+\ze|$" contained
    syn region rebuffSide      start="|" end="|" contains=rebuffLogo

    " Buffer listing definitions
    syn match rebuffModified   "+"
    syn match rebuffBufNumber  "\s\d\+\s"
    syn match rebuffCurrent    "%.\+$"
    syn match rebuffNonCurrent "[# ][ah].\+$"
    syn match rebuffUnlisted   "u[# ][ah ].\+$"

    " Help content definitions
    syn match rebuffHelpBorder "^=\+ HELP =\+$"
    syn match rebuffDesc       " [A-Z][Ra-z ]\+\."
    syn match rebuffShortcut   "^ \([?+\.\/{},~%defhHnqrRsStTuvwx-]\|\[count\]<CR>\|j | <Down>\|k | <Up>\|q | <Esc>\)"


    " Top content highlighting
    hi def link rebuffBorder     Keyword
    hi def link rebuffSide       Keyword
    hi def link rebuffLogo       Include

    " Buffer linsting highlighting
    hi def link rebuffModified   String
    hi def link rebuffCurrent    Function
    hi def link rebuffBufNumber  Identifier
    hi def link rebuffNonCurrent Constant
    hi def link rebuffUnlisted   Type

    " Help content highlighting
    hi def link rebuffHelpBorder Keyword
    hi def link rebuffDesc       NONE
    hi def link rebuffShortcut   Include
  endif
endfunction

function! s:ToggleSort()
  let nxt = index(s:sort_methods, b:current_sort) + 1
  if nxt == len(s:sort_methods)
    let b:current_sort = s:sort_methods[0]
  else
    let b:current_sort = s:sort_methods[nxt]
  endif

  call s:Render()
endfunction

function! s:SetSortTo(type)
  let b:current_sort = a:type
  call s:Render()
endfunction

function! s:Sort(list)
  if has_key(a:list[0], b:current_sort)
    if b:current_sort == 'num'
      return sort(a:list, 's:Compare')
    else
      return s:SortBy(a:list, b:current_sort)
    endif
  else
    return a:list
  endif
endfunction

function! s:SortBy(list, by)
  let by = a:by
  let list = copy(a:list)

  function! s:SortAlpha(first, second) closure
    let a = a:first[ by ]
    let b = a:second[ by ]

    if a == b
      return 0
    endif

    let sorted = sort([a, b])
    if sorted[0] == a
      return -1
    endif

    return 1
  endfunction

  return sort(list, 's:SortAlpha')
endfunction

function! s:Compare(a, b)
  let a = a:a.num + 0
  let b = a:b.num + 0

  if a < b
    return -1
  elseif a == b
    return 0
  else
    return 1
  endif
endfunction

function! s:ExtractFilename(entry)
  return matchstr(a:entry, '^ *\d\+[^"]\+"\zs[^"]\+\ze"')
endfunction

function! s:ExtractFlags(entry)
  return matchstr(a:entry, '^ *\d\+\zs[^"]\+\ze"')
endfunction

function! s:ExtractBufNum(entry)
  return matchstr(a:entry, '^[ +]*\zs\d\+\ze')
endfunction

function! s:BuildLogo(size)
  let isEven = fmod(a:size, 2) == 0.0
  let left = float2nr(floor((a:size - 30) / 2))
  let right = isEven ? left : left + 1

  let lines = [ repeat('-', a:size) ]
  for line in s:logo
    call add(lines, '|' . repeat(' ', left) . line . repeat(' ', right) . '|')
  endfor

  call add(lines, '|' . repeat(' ', a:size - 2) . '|')
  call add(lines, repeat('-', a:size))
  call add(lines, '')
  call add(lines, '')

  return lines
endfunction

function! s:Reset()
  call s:SetBufferFlags()
  call s:Render(1)
endfunction

function! s:HandleEnter(count)
  if !empty(a:count)
    if s:Get('open_with_count')
      bw
      exec "b" a:count
    else
      call s:FindByNumber(a:count)
      call s:PreviewBuffer()
    endif
  else
    bw
  endif
endfunction

function! s:FindByNumber(count)
  call search('^[ +]\+' . a:count)
  normal! 0
endfunction

function! s:JumpTo(line)
  exec a:line
  normal! 0
  call s:PreviewBuffer()
endfunction

command! -nargs=0 Ls :call Rebuff()
nnoremap <leader>ls :Ls<CR>
