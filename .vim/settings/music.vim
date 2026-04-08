command -nargs=0 FormatSongs %s/^\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\).*/\2 (\4) - \3 - \1/g
