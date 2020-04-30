command! -nargs=+ -complete=custom,parsnip#complete Parsnip call parsnip#generate(<f-args>)
