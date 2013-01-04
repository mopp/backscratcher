"=============================================================================
" File:BackScratcher.vim
" Author:Mopp
" Last Modified:04 Jan 2013
" License:Copyright (C) 2013 Mopp All Rights Reserved.
" Version:0.1 for Vim 7.3
"=============================================================================

"-------------------------------------------------------------------------------"
" Default Settings
"-------------------------------------------------------------------------------"
if (1 == g:BackScratcher_AutoBackParen_State)
    let g:BackScratcher_AutoBackParen_State = 0
    call BackScratcher#toggle_AutoBackParen()
endif

if (1 == g:BackScratcher_AutoPairParen_State)
    let g:BackScratcher_AutoPairParen_State = 0
    call BackScratcher#toggle_AutoPairParen()
endif

"-------------------------------------------------------------------------------"
" Auto Control Paren Functions
"   - 括弧を入力した時、自動で括弧内に戻る
"   - 括弧を入力した時、自動で閉じ括弧を保管する
"   - TODO:2つ有効にするための関数作成
"-------------------------------------------------------------------------------"
" 自動括弧戻り反転
function! BackScratcher#toggle_AutoBackParen()
    if (1 == g:BackScratcher_AutoPairParen_State)
        call BackScratcher#toggle_AutoPairParen()
    endif

    if (0 == g:BackScratcher_AutoBackParen_State)
        " フラグON
        let g:BackScratcher_AutoBackParen_State = 1

        " 各map実行
        for l:i in g:BackScratcher_ParenList
            execute 'inoremap <unique> '.l:i.' '.l:i.'<Left>'
        endfor
    else
        " フラグOFF
        let g:BackScratcher_AutoBackParen_State = 0

        " 各unmap実行
        for l:i in g:BackScratcher_ParenList
            if hasmapto(l:i, 'i')
                execute 'iunmap '.l:i
            endif
        endfor
    endif

    " log出力
    if !has('vim_starting') && 1 == g:BackScratcher_AutoParen_log_on
        echo 'AutoBack is'g:BackScratcher_AutoBackParen_State ? 'On' : 'Off'
    endif
endfunction

" 自動括弧閉じ反転
function! BackScratcher#toggle_AutoPairParen()
    if (1 == g:BackScratcher_AutoBackParen_State)
        call BackScratcher#toggle_AutoBackParen()
    endif

    if(0 == g:BackScratcher_AutoPairParen_State)
        " フラグON
        let g:BackScratcher_AutoPairParen_State = 1

        " 各map実行
        for l:i in g:BackScratcher_ParenList
            execute 'inoremap <unique> '.l:i[0].' '.l:i
        endfor
    else
        " フラグOFF
        let g:BackScratcher_AutoPairParen_State = 0

        " 各unmap実行
        for l:i in g:BackScratcher_ParenList
            if(hasmapto(l:i[0], 'i'))
                execute 'iunmap '.l:i
            endif
        endfor
    endif

    " log出力
    if !has('vim_starting') && 1 == g:BackScratcher_AutoParen_log_on
        echo 'AutoPair is'g:BackScratcher_AutoPairParen_State ? 'On' : 'Off'
    endif
endfunction


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
