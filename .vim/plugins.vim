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

" ------------
" TAGLIST PLUS
" ------------

let Tlist_Close_On_Select=1
let Tlist_Use_Right_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_WinWidth='auto'
let Tlist_Exit_OnlyWindow=1

" Open Tagbar code outline
nnoremap <silent> <leader>tl :TlistToggle<CR>

" ---------
" SYNTASTIC
" ---------

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_quiet_messages = { "level": "warnings",
                                 \ "type":  "style",
                                 \ "regex": ["Line exceeds maximum allowed length","proprietary attribute"]}

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
nnoremap <silent> <leader>gc :Gcommit<CR>


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

nmap <leader>w' ysiw'
nmap <leader>md ysiw`
nmap <leader>js ysiw"


" -------------------
" RAINBOW PARENTHESES
" -------------------

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" Toggle rainbow parens
nnoremap <leader>( :RainbowParenthesesToggle<CR>


" -----------------
" VIM-COFFEE-SCRIPT
" -----------------

" TODO: This isn't working
"let g:coffee_lint_options='-f ~/.coffeelint.json'


" ------------
" CONQUE SHELL
" ------------

" Fire up bash buffer in vertical split
nnoremap <leader>shv :ConqueTermVSplit bash<CR>
nnoremap <leader>shh :ConqueTermSplit bash<CR>
nnoremap <leader>sht :ConqueTermTab bash<CR>


" ------
" EUNUCH
" ------

nnoremap <leader>mv :exec ":Move ".input("New file name (relative to cwd)? ")<CR>
nnoremap <leader>rn :exec ":Rename ".input("New file name (realtive to __dirname)? ")<CR>
