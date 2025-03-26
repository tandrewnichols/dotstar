let g:codeium_disable_bindings = 1
imap <script><silent><nowait><expr> <C-l> codeium#Accept()
imap <script><silent><nowait><expr> <C-w> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-a> codeium#AcceptNextLine()
imap <C-j>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-k>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-]>   <Cmd>call codeium#Clear()<CR>
