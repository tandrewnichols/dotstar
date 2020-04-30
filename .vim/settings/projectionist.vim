function! s:PlaceCursor()
  if &modifiable && search('[~][%]') && expand("%:t") !~ 'projections.json'
    normal! "_ddk
  endif
endfunction

augroup ProjectionistCursor
  au!
  au User ProjectionistActivate call s:PlaceCursor()
augroup END

let g:projectionist_heuristics = {
  \   "src/|node_modules/": {
  \     "src/components/*.js": {
  \       "type": "component",
  \       "template": [
  \         "import React from 'react';",
  \         "",
  \         "export default class {basename|capitalize} extends React.Component {",
  \         "  render() {",
  \         "    return (",
  \         "      <div></div>",
  \         "    );",
  \         "  }",
  \         "}"
  \       ]
  \     },
  \     "src/containers/*.js": {
  \       "type": "container",
  \       "template": [
  \         "import {open} connect {close} from 'react-redux';",
  \         "import {basename|capitalize} from '../components/{basename}';",
  \         "import * as actions from '../actions/{basename}';",
  \         "",
  \         "const mapStateToProps = ({ {basename} }) => {",
  \         "  return { {basename} };",
  \         "};",
  \         "",
  \         "const mapDispatchToProps = (dispatch) => {",
  \         "  return {",
  \         "",
  \         "  };",
  \         "};",
  \         "",
  \         "export default connect(mapStateToProps, mapDispatchToProps)({basename|capitalize});"
  \       ]
  \     }
  \   },
  \   "node_modules/|test/": {
  \     "*.js": {
  \       "alternate": "test/{}.js"
  \     },
  \     "test/*.js": {
  \       "alternate": "{}.js"
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
  \       "alternate": "test/{}.vader",
  \       "template": [
  \         "if exists(\"g:loaded_{}\") || &cp | finish | endif",
  \         "",
  \         "let g:loaded_{} = 1",
  \         "",
  \         "let g:{}_VERSION = '1.0.0'"
  \       ],
  \       "type": "plugin"
  \     },
  \     "autoload/*.vim": {
  \       "alternate": "test/{}.vader",
  \       "type": "autoload"
  \     },
  \     "test/*.vader": {
  \       "alternate": "{}.vim",
  \       "type": "test"
  \     },
  \     "doc/*.txt": {
  \       "type": "help",
  \       "template": [
  \         "*{}.txt* Description",
  \         "",
  \         "INTRODUCTION                                     *{}*",
  \         "",
  \         "Description",
  \         "",
  \         "CONTENTS                                         *{}-contents*",
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
  \         "  12. Version                                    |{}-version|",
  \         "  13. License                                    |{}-license|",
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
  \         "     run `:helptags`.",
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
  \         "     git clone https://github.com/tandrewnichols/vim-{}.git",
  \         "<",
  \         "     Then run `:Helptags`",
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
  \         "If you experience issues using vim-{}, please report them at",
  \         "<https://github.com/tandrewnichols/vim-{}/issues>.",
  \         "",
  \         "CONTRIBUTING                                     *{}-contributing*",
  \         "",
  \         "I always try to be open to suggestions, but I do still have opinions about what",
  \         "this should and should not be so . . . it never hurts to ask before investing a",
  \         "lot of time on a patch.",
  \         "",
  \         "VERSION                                          *{}-version*",
  \         "",
  \         "Version 1.0.0",
  \         "",
  \         "LICENSE                                          *{}-license*",
  \         "",
  \         "The MIT License (MIT)",
  \         "",
  \         "Copyright (c) 2019 Andrew Nichols",
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
  \     },
  \     "README.md": {
  \       "template": [
  \         "# Vim-pluginname",
  \         "",
  \         "## Overview",
  \         "",
  \         "## Installation",
  \         "",
  \         "If you don't have a preferred installation method, I really like vim-plug and recommend it.",
  \         "",
  \         "#### Manual",
  \         "",
  \         "Clone this repository and copy the files in plugin/, autoload/, and doc/ to their respective directories in your vimfiles, or copy the text from the github repository into new files in those directories. Make sure to run `:helptags`.",
  \         "",
  \         "#### Plug (https://github.com/junegunn/vim-plug)",
  \         "",
  \         "Add the following to your vimrc, or something sourced therein:",
  \         "",
  \         "```vim",
  \         "Plug 'tandrewnichols/vim-pluginname'",
  \         "```",
  \         "",
  \         "Then install via `:PlugInstall`",
  \         "",
  \         "#### Vundle (https://github.com/gmarik/Vundle.vim)",
  \         "",
  \         "Add the following to your vimrc, or something sourced therein:",
  \         "",
  \         "```vim",
  \         "Plugin 'tandrewnichols/vim-pluginname'",
  \         "```",
  \         "",
  \         "Then install via `:BundleInstall`",
  \         "",
  \         "#### NeoBundle (https://github.com/Shougo/neobundle.vim)",
  \         "",
  \         "Add the following to your vimrc, or something sourced therein:",
  \         "",
  \         "```vim",
  \         "NeoBundle 'tandrewnichols/vim-pluginname'",
  \         "```",
  \         "",
  \         "Then install via `:BundleInstall`",
  \         "",
  \         "#### Pathogen (https://github.com/tpope/vim-pathogen)",
  \         "",
  \         "```sh",
  \         "git clone https://github.com/tandrewnichols/vim-pluginname.git ~/.vim/bundle/vim-pluginname",
  \         "```",
  \         "",
  \         "## Usage",
  \         "",
  \         "## Contributing",
  \         "",
  \         "I always try to be open to suggestions, but I do still have opinions about what this should and should not be so . . . it never hurts to ask before investing a lot of time on a patch.",
  \         "",
  \         "## License",
  \         "",
  \         "See [LICENSE](./LICENSE)"
  \       ]
  \     }
  \   }
  \ }
