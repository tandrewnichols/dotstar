" ------
" VUNDLE
" ------

" Install bundles
nnoremap <leader>bi :BundleInstall<CR>


" -----
" GUNDO
" -----

let gundo_close_on_revert=1

" Open Gundo undo tree
nnoremap <silent> <leader>un :GundoToggle<CR>


" --------
" NERDTREE
" --------

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" Open nerd tree
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>

" Open nerd tree at a directory
nnoremap <silent> <leader>ne :exec ":NERDTree ".input("Dir? ")<CR>

" ------
" TAGBAR
" ------

let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_show_linenumbers=1

" Open Tagbar code outline
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" ---------
" SYNTASTIC
" ---------

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['rubylint']

" -----
" CTRLP
" -----

let g:ctrlp_by_filename=1

" ---------
" SIGNATURE
" ---------

" Go to next mark
nnoremap <leader>j :call signature#GotoMark("pos", "next", "spot")<CR>

" Go to previous mark
nnoremap <leader>k :call signature#GotoMark("pos", "prev", "spot")<CR>

" Go to next marked line
nnoremap <leader>J :call signature#GotoMark("pos", "next", "line")<CR>

" Go to prevoius marked line
nnoremap <leader>K :call signature#GotoMark("pos", "prev", "line")<CR>

" Go to next alphabetical mark
nnoremap <leader>aj :call signature#GotoMark("alpha", "next", "spot")<CR>

" Go to previous alphabetical mark
nnoremap <leader>ak :call signature#GotoMark("alpha", "prev", "spot")<CR>

" Go to next alphabetical marked line
nnoremap <leader>Aj :call signature#GotoMark("alpha", "next", "line")<CR>

" Go to previous alphabetical marked line
nnoremap <leader>Ak :call signature#GotoMark("alpha", "prev", "line")<CR>

" Go to next marker of this type
nnoremap <leader>tj :call signature#GotoMarker("next")<CR>

" Go to previous marker of this type
nnoremap <leader>tk :call signature#GotoMarker("prev")<CR>


" ----
" TERN
" ----

" TernDef
nnoremap <silent> <leader>td :TernDef<CR>

" TernDefSplit
nnoremap <silent> <leader>ts :TernDefSplit<CR>

" TernType
nnoremap <silent> <leader>tt :TernType<CR>

" TernRef
nnoremap <silent> <leader>tr :TernRefs<CR>

" TernRename
nnoremap <silent> <leader>tn :TernRename<CR>


" --------
" FUGITIVE
" --------

" Show git status
nnoremap <silent> <leader>st :Gstatus<CR>

" Show git blame for current file in vsplit
nnoremap <silent> <leader>bl :Gblame<CR>

" Show git diff for current file in vsplit
nnoremap <silent> <leader>df :Gdiff<CR>

" Git commit
nnoremap <silent> <leader>cm :Gcommit<CR>


" ---------
" VIM-MOCHA
" ---------

let g:mocha_command = "!mocha -R spec -u bdd --compilers coffee:coffee-script {spec}"
nnoremap <leader>sc :call mocha#RunCurrentSpecFile()<CR>
nnoremap <leader>sn :call mocha#RunNearestSpec()<CR>
nnoremap <leader>sl :call mocha#RunLastSpec()<CR>
nnoremap <leader>sa :call mocha#RunAllSpecs()<CR>


" ----------
" TOGGLELIST
" ----------

let g:toggle_list_no_mappings=1
nnoremap <script> <leader>qf :call ToggleQuickfixList()<CR>
nnoremap <script> <leader>ll :call ToggleLocationList()<CR>


" --------
" SURROUND
" --------

nmap <leader>qt ysiw"
