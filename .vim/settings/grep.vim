set grepprg=rg\ --vimgrep

" let g:grep_cmd_opts = '--vimgrep'

command! -bang -nargs=* FzfRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".fzf#shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* FzfRG call fzf#vim#grep2("rg --column --line-number --no-heading --color=always --smart-case -- ", <q-args>, fzf#vim#with_preview(), <bang>0)

function! s:get_visual_selection() abort
  let l = getline("'<")
  let [line1, col1] = getpos("'<")[1:2]
  let [line2, col2] = getpos("'>")[1:2]
  return l[col1 - 1: col2 - 1]
endfunction

nnoremap <leader>sf :exec "CtrlSF" expand("<cword>")<CR>
vnoremap <leader>sf <Esc>:exec 'CtrlSF <C-R><C-R>=<SID>get_visual_selection()<CR>'<CR>
