function s:GetDefault(dict, key, default) abort
  return has_key(a:dict, a:key) ? (a:dict[a:key] ?? a:default) : a:default
endfunction

function! s:Claude(opts) range abort
  let print = s:GetDefault(a:opts, 'print', 0)
  let mods = s:GetDefault(a:opts, 'mods', 'vert')
  let cwd = s:GetDefault(a:opts, 'cwd', projectroot#guess())

  let prompt = s:GetDefault(a:opts, 'prompt', '')

  let claudeStartOpts = { 'cwd': cwd, 'mods': mods, 'print': print, 'prompt': prompt }

  if len(prompt) > 0
    let command = split(prompt, ' ')[0]
    if command == 'print'
      let claudStartOpts.print = 1
    elseif command == 'init'
      let claudeStartOpts.prompt = '/init'
    elseif command == 'refactor'
      let claudeStartOpts.prompt = 'Refactor lines ' . a:firstline . ' to ' . a:lastline . ' in  ' . expand("%:p")
    elseif command == 'extract'
      let claudeStartOpts.prompt = 'Extract lines ' . a:firstline . ' to ' . a:lastline . ' in  ' . expand("%:p") . ' to a new function in the same file.'
    elseif command == 'explain'
      let claudeStartOpts.prompt = 'Explain lines ' . a:firstline . ' to ' . a:lastline . ' in  ' . expand("%:p")
    endif
  endif

  call ClaudeStart(claudeStartOpts)
endfunction

command! -bang -nargs=* -range Claude <line1>,<line2>call <SID>Claude({ 'print': <bang>0, 'mods': <q-mods>, 'prompt': <q-args> })
command! -bang -nargs=* -range ClaudeHere <line1>,<line2>call <SID>Claude({ 'print': <bang>0, 'mods': <q-mods>, 'prompt': <q-args>, 'cwd': expand('%:p:h') })
nnoremap <leader>c :call <SID>Claude({})<CR>
nnoremap <leader>C :call <SID>Claude({ 'cwd': expand('%:p:h') })<CR>

function! ClaudeStart(opts) abort
  let mods = a:opts.mods
  let print = a:opts.print
  let cwd = a:opts.cwd
  let prompt = a:opts.prompt
  let cmd = 'claude'

  if print
    let cmd .= ' -p'
  endif

  if len(prompt) > 0
    let cmd .= ' "' . shellescape(escape(prompt, '\'))[1:-2] . '"'
  endif

  execute mods "call term_start('" . cmd . "', { 'cwd': '" . cwd . "' })"
endfunction
