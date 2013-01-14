"=============================================================================
" File:BackScratcher.vim
" Author:Mopp
" Last Modified:04 Jan 2013
" License:Copyright (C) 2013 Mopp All Rights Reserved.
" Version:0.1 for Vim 7.3
"=============================================================================


" 存在するなら読み込み済みなのでfinish
if exists("g:loaded_BackScratcher") || 1 == &compatible
    finish
endif
let g:loaded_BackScratcher = 1

"-------------------------------------------------------------------------------"
" Default Settings
"-------------------------------------------------------------------------------"
"-------------------------------------------------------------------------------"
" Auto Control Paren Functions
"   - 括弧を入力した時、自動で括弧内に戻る
"   - 括弧を入力した時、自動で閉じ括弧を保管する
"   - TODO:2つ有効にするための関数作成
"-------------------------------------------------------------------------------"
" 自動括弧戻り反転
function! s:toggle_AutoBackParen()
    if (1 == g:BackScratcher_AutoPairParen_State)
        call <SID>toggle_AutoPairParen()
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
function! s:toggle_AutoPairParen()
    if (1 == g:BackScratcher_AutoBackParen_State)
        call <SID>toggle_AutoBackParen()
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
" Default Settings
"-------------------------------------------------------------------------------"

if !exists('g:BackScratcher_AutoParen_log_on')
    let g:BackScratcher_AutoParen_log_on = 1
endif

if !exists('g:BackScratcher_ParenList') || 0 == len(g:BackScratcher_ParenList)
    " 自動的に操作する対象の括弧
    let g:BackScratcher_ParenList = ['{}', '[]', '()', '""', '''''', '<>']
endif

if !exists('g:BackScratcher_AutoBackParen_State')
    let g:BackScratcher_AutoBackParen_State = 1
endif

if !exists('g:BackScratcher_AutoPairParen_State')
    let g:BackScratcher_AutoPairParen_State = 0
endif

if !exists('g:BackScratcher_DelimiterList')
    " 区切り文字リスト 優先順位はリストの並びごとに高→低
    let g:BackScratcher_DelimiterList = ['.', ',', '"', '''', ';', ':', ')', '}', ']']
endif

" 自動括弧関数を設定値によって呼び出し
if (1 == g:BackScratcher_AutoBackParen_State)
    let g:BackScratcher_AutoBackParen_State = 0
    call s:toggle_AutoBackParen()
endif

if (1 == g:BackScratcher_AutoPairParen_State)
    let g:BackScratcher_AutoPairParen_State = 0
    call s:toggle_AutoPairParen()
endif

" Map定義
nnoremap <silent> <script> <Plug>BackScratcher_Toggle_AutoBackParen :call <SID>toggle_AutoBackParen()<CR>
nnoremap <silent> <script> <Plug>BackScratcher_Toggle_AutoPairParen :call <SID>toggle_AutoPairParen()<CR>

if !hasmapto('<Plug>BackScratcher_Toggle_AutoBackParen', 'n')
    nmap <Leader>ab  <Plug>BackScratcher_Toggle_AutoBackParen
endif

if !hasmapto('<Plug>BackScratcher_Toggle_AutoPairParen', 'n')
    nmap <Leader>ap  <Plug>BackScratcher_Toggle_AutoPairParen
endif

nnoremap <silent> <script> <Plug>BackScratcher_Delete_Str_A :call BackScratcher#delete_Str_Cursol2Delimiter(0, 0)<CR>
nnoremap <silent> <script> <Plug>BackScratcher_Delete_Str_B :call BackScratcher#delete_Str_Cursol2Delimiter(0, 1)<CR>
nnoremap <silent> <script> <Plug>BackScratcher_Delete_Str_C :call BackScratcher#delete_Str_Cursol2Delimiter(1, 0)<CR>
nnoremap <silent> <script> <Plug>BackScratcher_Delete_Str_D :call BackScratcher#delete_Str_Cursol2Delimiter(1, 1)<CR>

if !hasmapto('<Plug>BackScratcher_Delete_Str_A', 'n')
    nmap <Leader>di <Plug>BackScratcher_Delete_Str_A
endif
if !hasmapto('<Plug>BackScratcher_Delete_Str_B', 'n')
    nmap <Leader>da <Plug>BackScratcher_Delete_Str_B
endif
if !hasmapto('<Plug>BackScratcher_Delete_Str_C', 'n')
    nmap <Leader>dci <Plug>BackScratcher_Delete_Str_C
endif
if !hasmapto('<Plug>BackScratcher_Delete_Str_D', 'n')
    nmap <Leader>dca <Plug>BackScratcher_Delete_Str_D
endif

" vim:set ft=vim sw=4:
