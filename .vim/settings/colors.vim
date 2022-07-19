function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command -nargs=+ HiLink hi def link <args>

HiLink jsFuncCall             Structure
HiLink jsStorageClass         Identifier
HiLink jsExportDefault        Keyword
HiLink jsImport               Keyword
HiLink jsExport               Keyword
HiLink jsModuleAs             Keyword
HiLink jsFrom                 Keyword
HiLink jsTemplateBraces       Delimiter
HiLink jsBrackets             Type
HiLink jsFuncBraces           Type
HiLink jsFuncParens           Type
HiLink jsClassBraces          Type
HiLink jsIfElseBraces         Type
HiLink jsTryCatchBraces       Type
HiLink jsModuleBraces         Type
HiLink jsObjectBraces         Type
HiLink jsObjectSeparator      Type
HiLink jsFinallyBraces        Type
HiLink jsRepeatBraces         Type
HiLink jsSwitchBraces         Type
HiLink jsDestructuringBraces  Type
HiLink jsDestructuringNoise   Delimiter
HiLink jsModuleAsterisk       Type
HiLink jsModuleComma          Type

HiLink jsxTagName             Function

delcommand HiLink
