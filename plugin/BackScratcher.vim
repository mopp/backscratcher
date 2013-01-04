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
    let g:BackScratcher_DelimiterList = [';', ':', ')', '}', ']', '.', ',', '"', '''']
endif

nnoremap <silent> <script> <Plug>BackScratcher_Toggle_AutoBackParen :call BackScratcher#toggle_AutoBackParen()<CR>
nnoremap <silent> <script> <Plug>BackScratcher_Toggle_AutoPairParen :call BackScratcher#toggle_AutoPairParen()<CR>

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
