" NOTE: You must, of course, install ag / the_silver_searcher
command! -bang -nargs=* -complete=file Ag call ag#Ag('grep<bang>',<q-args>)
command! -bang -nargs=* -complete=file AgBuffer call ag#AgBuffer('grep<bang>',<q-args>)
command! -bang -nargs=* -complete=file AgAdd call ag#Ag('grepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFromSearch call ag#AgFromSearch('grep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAg call ag#Ag('lgrep<bang>', <q-args>)
command! -bang -nargs=* -complete=file LAgBuffer call ag#AgBuffer('lgrep<bang>',<q-args>)
command! -bang -nargs=* -complete=file LAgAdd call ag#Ag('lgrepadd<bang>', <q-args>)
command! -bang -nargs=* -complete=file AgFile call ag#Ag('grep<bang> -g', <q-args>)
command! -bang -nargs=* -complete=help AgHelp call ag#AgHelp('grep<bang>',<q-args>)
command! -bang -nargs=* -complete=help LAgHelp call ag#AgHelp('lgrep<bang>',<q-args>)

"-----------------------------------------------------------------------
" Plugin Settings: ag.
"-----------------------------------------------------------------------
" Set ag program name
let g:ag_prg = "ag --vimgrep"
" Set search from project root instead of current directory
let g:ag_working_path_mode = "R"

function! s:agSearchExpandWord()
    let l:agCmd = "Ag! " . expand('<cword>')
    let l:regexEscs = "^$.\\+?*()[]{}|"
    let l:ichar = 4
    let l:cmdLen = strlen(l:agCmd)
    while l:ichar < l:cmdLen
        if stridx(l:regexEscs, l:agCmd[l:ichar]) != -1
            let l:agCmd = l:agCmd[:l:ichar-1] . '\' . l:agCmd[l:ichar:]
            let l:ichar = l:ichar + 1
        endif
        let l:ichar = l:ichar + 1
    endwhile
    return substitute(l:agCmd, '#', '.', 'g')
endfunction

cabbrev ag Ag!
nnoremap <silent> <Leader>ag :execute(<sid>agSearchExpandWord())<cr>
