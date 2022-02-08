" vim-columnize - Organize text into columns, interactively
" Maintainer:   Jer Wilson <superjer@superjer.com>
" URL:          https://github.com/superjer/vim-columnize
" Version:      0.1
"
" License:
" Copyright Jer Wilson. Distributed under the same terms as Vim itself.
" See :help license
"
" Installation:
" Put this file in your ~/.vim/plugin dir or, if you use a bundler, clone
" https://github.com/superjer/vim-columnize to your bundles dir.
"
" Description:

if exists("g:loaded_columnize")
  finish
endif
let g:loaded_columnize = 1

" Columnize
function! Columnize(...) range abort
  let firstline = a:firstline
  let lastline = a:lastline
  if firstline >= lastline
    let firstline = line("'<")
    let lastline = line("'>")
    if firstline >= lastline
      let firstline = line('.')
      let lastline = firstline + str2nr(input("Number of lines to Columnize: ")) - 1
      if firstline >= lastline
        echo "Error: Columnizing requires a valid range"
        return
      endif
    endif
  endif
  let origsearch = @/
  exec "normal! :".firstline.",".lastline."s/\\v$/#/\n"
  let stcol = 1
  let i = 0
  while a:0 == 0 || l:i < a:0
    let @/ = ""
    redraw
    if( a:0 > 0 )
      let patt = a:000[l:i]
    else
      let patt = input(stcol."| Enter column delimiter (Esc or empty to finish): ")
    endif
    if empty(patt) | break | endif
    let bestcol = stcol
    " find the farthest out delimiter, then push them all out as far
    for firstpass in [1,0]
      for nl in range(firstline,lastline)
        exec "silent! normal! ".nl."G".stcol."|/\\v($|(\\V".patt."\\v))\n"
        let thiscol = col('.')
        if line('.') != nl | continue | endif
        if thiscol == stcol | continue | endif
        if firstpass
          if thiscol > bestcol | let bestcol = thiscol | endif
        else
          exec "normal! i" . repeat(' ',bestcol - thiscol)
        endif
      endfor
    endfor
    " continue columnizing only right of stcol
    let stcol = bestcol + strlen(patt) - 1
    let i = l:i + 1
  endwhile
  exec "normal! :".firstline.",".lastline."s/\\v\\s*#$//\n"
  exec ":redraw | echo 'Columnized ".(lastline-firstline+1)." lines, ".(l:i+1)." columns'"
  let @/ = origsearch
endfunction
noremap <C-S> :call Columnize()<CR>
