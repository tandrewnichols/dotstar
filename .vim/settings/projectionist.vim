function! s:PlaceCursor()
  if &modifiable && search('[\~][%]')
    normal! "_ddk
  endif
endfunction

augroup ProjectionistCursor
  au!
  au User ProjectionistActivate call s:PlaceCursor()
augroup END

let g:projectionist_heuristics = {
  \   "lib/|test/": {
  \     "lib/*.js": {
  \       "alternate": "test/{}.js"
  \     },
  \     "test/*.js": {
  \       "alternate": "lib/{}.js"
  \     }
  \   },
  \   "tasks/|test/": {
  \     "tasks/*.js": {
  \       "alternate": "test/{}.js"
  \     },
  \     "test/*.js": {
  \       "alternate": "tasks/{}.js"
  \     }
  \   },
  \   "plugin/|autoload/": {
  \     "plugin/*.vim": {
  \       "alternate": "test/{}.vim",
  \       "template": [
  \         "if exists(\"g:{}_loaded\") || &cp | finish | endif",
  \         "",
  \         "let g:{}_loaded = 1"
  \       ],
  \       "type": "plugin"
  \     },
  \     "autoload/*.vim": {
  \       "alternate": "test/{}.vim",
  \       "type": "autoload"
  \     },
  \     "doc/*.txt": {
  \       "type": "help",
  \       "template": [
  \         "*{}.txt* Description",
  \         "",
  \         "Logo",
  \         "INTRODUCTION                                     |{}|",
  \         "",
  \         "Description",
  \         "CONTENTS                                         |{}-contents|",
  \         "",
  \         "  1.  Overview                                   |{}-overview|",
  \         "  2.  Requirements                               |{}-requirements|",
  \         "  3.  Installation                               |{}-installation|",
  \         "  4.  Usage                                      |{}-usage|",
  \         "  5.  Commands                                   |{}-commands|",
  \         "  6.  Functions                                  |{}-functions|",
  \         "  7.  Mappings                                   |{}-mappings|",
  \         "  8.  Plugs                                      |{}-plugs|",
  \         "  9.  Options                                    |{}-options|",
  \         "  10. Issues                                     |{}-issues|",
  \         "  11. Contributing                               |{}-contributing|",
  \         "  12. License                                    |{}-license|",
  \         "",
  \         "OVERVIEW                                         *{}-overview*",
  \         "",
  \         "REQUIREMENTS                                     *{}-requirements*",
  \         "",
  \         "INSTALLATION                                     *{}-installation*",
  \         "",
  \         "  1. Manual",
  \         "",
  \         "     Clone this repository and copy the files in plugin/, autoload/, and doc/",
  \         "     to their respective directories in your vimfiles, or copy the text from",
  \         "     the github repository into new files in those directories. Make sure to",
  \         "     run `:helptag`.",
  \         "",
  \         "  2. Plug <https://github.com/junegunn/vim-plug>",
  \         "",
  \         "     Add the following to your vimrc, or something sourced therein: >",
  \         "",
  \         "     Plug 'tandrewnichols/vim-{}'",
  \         "<",
  \         "     Then install via `:PlugInstall`",
  \         "",
  \         "  3. Vundle <https://github.com/gmarik/Vundle.vim>",
  \         "",
  \         "     Add the following to your vimrc, or something sourced therein: >",
  \         "",
  \         "     Plugin 'tandrewnichols/vim-{}'",
  \         "<",
  \         "     Then install via `:BundleInstall`",
  \         "",
  \         "  4. NeoBundle <https://github.com/Shougo/neobundle.vim>",
  \         "",
  \         "     Add the following to your vimrc, or something sourced therein: >",
  \         "",
  \         "     NeoBundle 'tandrewnichols/vim-{}'",
  \         "<",
  \         "     Then install via `:BundleInstall`",
  \         "",
  \         "  5. Pathogen <https://github.com/tpope/vim-pathogen> >",
  \         "",
  \         "     cd ~/.vim/bundle",
  \         "     git clone https://github.com/tandrewnichols/vim-lodash.git",
  \         "<",
  \         "Then run `:Helptags`",
  \         "",
  \         "USAGE                                            *{}-usage*",
  \         "",
  \         "COMMANDS                                         *{}-commands*",
  \         "",
  \         "FUNCTIONS                                        *{}-functions*",
  \         "",
  \         "MAPPINGS                                         *{}-mappings*",
  \         "",
  \         "PLUGS                                            *{}-plugs*",
  \         "",
  \         "OPTIONS                                          *{}-options*",
  \         "",
  \         "ISSUES                                           *{}-issues*",
  \         "",
  \         "If you experience issues using vim-rebuff, please report them at",
  \         "<https://github.com/tandrewnichols/vim-{}/issues>.",
  \         "",
  \         "CONTRIBUTING                                     *{}-contributing*",
  \         "",
  \         "I always try to be open to suggestions, but I do still have opinions about what",
  \         "this should and should not be so . . . it never hurts to ask before investing a",
  \         "lot of time on a patch.",
  \         "",
  \         "LICENSE                                          *{}-license*",
  \         "",
  \         "The MIT License (MIT)",
  \         "",
  \         "Copyright (c) 2018 Andrew Nichols",
  \         "",
  \         "Permission is hereby granted, free of charge, to any person obtaining a copy of",
  \         "this software and associated documentation files (the \"Software\"), to deal in",
  \         "the Software without restriction, including without limitation the rights to",
  \         "use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies",
  \         "of the Software, and to permit persons to whom the Software is furnished to do",
  \         "so, subject to the following conditions:",
  \         "",
  \         "The above copyright notice and this permission notice shall be included in all",
  \         "copies or substantial portions of the Software.",
  \         "",
  \         "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR",
  \         "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,",
  \         "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE",
  \         "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER",
  \         "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,",
  \         "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE",
  \         "SOFTWARE.",
  \         "",
  \         "vim:tw=78:ts=2:ft=help:norl:"
  \       ]
  \     }
  \   }
  \ }
