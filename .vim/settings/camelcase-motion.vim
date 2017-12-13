for letter in ['n', 'o', 'x']
  exec letter . "map \<silent> \<leader>w \<Plug>CamelCaseMotion_w"
  exec letter . "map \<silent> \<leader>e \<Plug>CamelCaseMotion_e"
  exec letter . "map \<silent> \<leader>B \<Plug>CamelCaseMotion_B"
  exec letter . "map \<silent> \<leader>ge \<Plug>CamelCaseMotion_ge"
endfor
