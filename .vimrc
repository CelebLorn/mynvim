" ===========================================
" .vimrc (no plugins, but usable, but speedy)
" ===========================================

" エンコーディングの設定
set encoding=utf-8
if has('win32') || has ('win64')
    set fileencodings=sjis,utf-8,euc-jp,cp932
else
    set fileencodings=utf-8,sjis,euc-jp,cp932
endif

" 行番号の表示
set nu
" 入力中コマンドの表示
set showcmd
" tabはスペース4つ
set expandtab
set tabstop=4
set shiftwidth=4

" インデント
set smartindent

" 無名レジスタとクリップボードを同期
set clipboard+=unnamed

" ターミナルの色
set termguicolors

" スワップファイルを無効化
set noswapfile
" undoファイルを無効化
set noundofile
" バックアップファイルを無効化
set nobackup

" 検索を随時するように
set incsearch

" 検索を大文字小文字無視するように
set ignorecase
" 検索を大文字がある場合には区別するように
set smartcase

" 自動でカレントディレクトリを移動するように
set autochdir

" ポップアップメニューの最大表示数
set pumheight=10

if has('nvim')
    " ターミナルを開いたらに常にinsertモードに入る
    autocmd TermOpen * :startinsert
    " ターミナルでは行番号を非表示にする
    autocmd TermOpen * setlocal norelativenumber
    autocmd TermOpen * setlocal nonumber
endif

" --------------------------------------------------
" remap
" --------------------------------------------------

" 人権
inoremap <silent> jj <ESC>

" プット後のカーソルを末尾に自動移動(vscodeだとうまく動かんので回避)
if 1
    vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]
endif


" デフォルトで拡張正規表現を使うように(vscodeだと困るのでnvimのみ)
if 1
    nnoremap / /\v
    nnoremap ? ?\v
endif 

" Leaderキーをスペースに割り当て
let mapleader = "\<Space>"

" Ctrl+sで保存
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" 画面分割のショートカット
nnoremap <Leader>wv <C-w>v<C-w>l
nnoremap <Leader>ws <C-w>s<C-w>j


" jとkの動作を見た目通りにする
nnoremap j gj
nnoremap k gk

" nvimのターミナル設定
if has('nvim')
    tnoremap <silent> jj <C-\><C-n>
endif

" windowsでのターミナルモードの設定
if has('win32') || has('win64')
    if executable('bash')
        set shell=bash
    else
        set shell=powershell
    endif
endif
set shellcmdflag=-c
set shellquote="

" undoをいい感じに
if has('persistent_undo')
	let undo_path = expand('$VIM/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif
set undolevels=100 " undo上限 100回で十分

" カラースキーム
colorscheme industry
