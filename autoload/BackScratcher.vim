"=============================================================================
" File:BackScratcher.vim
" Author:Mopp
" Last Modified:04 Jan 2013
" License:Copyright (C) 2013 Mopp All Rights Reserved.
" Version:0.1 for Vim 7.3
"=============================================================================


"-------------------------------------------------------------------------------"
" Quick Delete Strings Functions
"   - 設定された区切り文字までを削除する
"-------------------------------------------------------------------------------"
" @isInsert 削除後に挿入するか否か
" @isInclude 区切り文字を含むか否か
function! BackScratcher#delete_Str_Cursol2Delimiter(isInsert, isInclude)
    " [bufnum, lnum, col, off]
    let l:cursolPos = getpos('.')

    " 現在カーソルのある列、以降の文字列を取得(カーソル文字も含む)
    let l:afterCursolStr =  strpart(getline(line('.')), remove(l:cursolPos, 2) - 1)

    " 区切り文字のいずれかがあるか検出 標準 -> [';', ':', ')', '}', ']', '.', ',', '"', '''']
    for l:i in g:BackScratcher_DelimiterList
        " 区切り文字が存在すれば削除処理開始
        if -1 != stridx(l:afterCursolStr, l:i)
            " 文字削除
            execute 'normal d'.['t', 'f'][a:isInclude].l:i

            if 1 == a:isInsert
                startinsert
            endif

            " 削除したのでループを抜ける
            break
        endif
    endfor
endfunction

" vim:set ft=vim sw=4:
