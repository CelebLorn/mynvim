" autocmdの設定
augroup MyAutoCmd
  autocmd!
augroup END

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
" 人権
inoremap <silent> jj <ESC>

" 無名レジスタとクリップボードを同期
set clipboard+=unnamed

" ポップアップメニューの色
highlight Pmenu ctermbg=6 guibg=#4c745a
highlight PmenuSel ctermbg=3 guibg=#d4b979
highlight PmenuSbar ctermbg=0 guibg=#333333

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

" プット後のカーソルを末尾に自動移動
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Leaderキーをスペースに割り当て
let mapleader = "\<Space>"


" デフォルトで拡張正規表現を使うように(vscodeだと困るのでnvimのみ)
if has('nvim')
    nnoremap / /\v
    nnoremap ? ?\v
endif 

" Ctrl+sで保存
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" 画面分割のショートカット
nnoremap <Leader>wv <C-w>v<C-w>l
nnoremap <Leader>ws <C-w>s<C-w>j


" jとkの動作を見た目通りにする
nnoremap j gj
nnoremap k gk

" undoをいい感じに
if has('persistent_undo')
	let undo_path = expand('$VIM/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

" mugen用のファイルをmugen用のカラーで読ませる
au BufRead,BufNewFile *.cns,*.st set filetype=mugen


" deinのインストール
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

"dein Scripts-----------------------------
"
" 自動でいらないキャッシュを消させる
let g:dein#auto_recache = 1

if &compatible
  set nocompatible               " Be iMproved
endif

let g:dein_dir = $CACHE . '/dein'


" init.vimとかtomlとか置いてるディレクトリ
if has('win32') || has ('win64')
    let $VIM_CONFIG_DIR = '~/AppData/Local/nvim'
else
    let $VIM_CONFIG_DIR = '~/.config/nvim'
endif
" プラグイン管理用toml
let $MY_DEIN_TOML = $VIM_CONFIG_DIR . '/dein.toml'
let $MY_DEIN_TOML_LAZY = $VIM_CONFIG_DIR . '/dein_lazy.toml'
let $MY_DEIN_TOML_LOCAL = $VIM_CONFIG_DIR . '/dein_local.toml'

" 設定開始
if dein#load_state(g:dein_dir)
	call dein#begin(g:dein_dir)

	" tomlを読み込む
	call dein#load_toml($MY_DEIN_TOML, {'lazy': 0})
    if filereadable(expand($MYVIMRC_LOCAL))
        call dein#load_toml($MY_DEIN_TOML_LOCAL, {'lazy': 0})
    endif
	call dein#load_toml($MY_DEIN_TOML_LAZY, {'lazy': 1})

    " 設定終了
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


"End dein Scripts-------------------------

" PCごとの設定など
let $MYVIMRC_LOCAL = $VIM_CONFIG_DIR .. '/local.vim'

if filereadable(expand($MYVIMRC_LOCAL))
    source $MYVIMRC_LOCAL
endif

