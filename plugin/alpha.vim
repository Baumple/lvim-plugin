if exists("g:loaded_alpha") | finish | endif "prevent loading file twice

let s:save_cpo = &cpo 
set cpo&vim

command! AlphaHelloWorld lua require("ligatures").dbg()
command! LigLine lua require("ligatures").lig_line()
command! LigWord lua require("ligatures").lig_word()

lua require("ligatures").custom_word_map = { { "-->", "!>" }}

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_alpha = 1
