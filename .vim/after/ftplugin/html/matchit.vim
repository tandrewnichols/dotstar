let b:hogan_pattern = '\({{\)\@<=[#^]\([^}]\{-}\)}}:\({{\)\@<=/\2}}'
if len(b:match_words) > 0
  let b:match_words = b:match_words . ',' . b:hogan_pattern
else
  let b:match_words = b:hogan_pattern
endif
