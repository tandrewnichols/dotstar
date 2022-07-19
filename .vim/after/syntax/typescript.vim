command -nargs=+ HiLink hi def link <args>

hi clear typescriptStorageClass
HiLink typescriptStorageClass Identifier

hi clear typescriptGlobalObjects
HiLink typescriptGlobalObjects Constant

hi clear typescriptLogicSymbols
HiLink typescriptLogicSymbols Operator

syntax match   tsFuncCall       /\<\K\k*\ze\s*(/
HiLink tsFuncCall Structure

hi clear typescriptParens
HiLink typescriptParens Type

hi clear typescriptBraces
HiLink typescriptBraces Type

exe 'syntax match typescriptArrowFunction /=>/           skipwhite skipempty nextgroup=jsFuncBlock,jsCommentFunction '.(exists('g:javascript_conceal_arrow_function') ? 'conceal cchar='.g:javascript_conceal_arrow_function : '')
exe 'syntax match typescriptArrowFunction /()\ze\s*=>/   skipwhite skipempty nextgroup=typescriptArrowFunction '.(exists('g:javascript_conceal_noarg_arrow_function') ? 'conceal cchar='.g:javascript_conceal_noarg_arrow_function : '')
exe 'syntax match typescriptArrowFunction /_\ze\s*=>/    skipwhite skipempty nextgroup=typescriptArrowFunction '.(exists('g:javascript_conceal_underscore_arrow_function') ? 'conceal cchar='.g:javascript_conceal_underscore_arrow_function : '')
HiLink typescriptArrowFunction Type

delcommand HiLink
