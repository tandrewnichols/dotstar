command! -nargs=* Term call term_start(<q-args>, {
  \   'term_rows': '8',
  \   'term_finish': 'close'
  \ })
