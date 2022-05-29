" vim-plug なかったら落としてくる
if empty(glob('$HOME/.config/nvim/site/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" 足りないプラグインがあれば :PlugInstall を実行
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('$HOME/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()
" ------------------------------------------------------------
"  key bind
" ------------------------------------------------------------
" Insert Mode
inoremap <silent> jj <ESC>"
let mapleader = "\<Space>"

" config
"" 24bit-color
if (has("termguicolors"))
	set termguicolors
endif

"" to UTF-8
"  set fenc=utf-8

"" not to make backup & swap file
set nobackup
set noswapfile

"" enable incremental search
set incsearch

" editor
"" set 4-width soft tab
set tabstop=4
set shiftwidth=4
set expandtab

"" trail eol space
set listchars=tab:^\ ,trail:~

"" smartindent
set smartindent

"" display
set title
set number
set ruler
set cursorline
syntax on

"" enable status line
set laststatus=2

"" enphasize display
set showmatch

"" enable eol cursor
set virtualedit=onemore

"" cli completion
set wildmode=list:longest

"  firenvim
let g:firenvim_config = {
  \ 'localSettings': {
    \ '.*': {
      \ 'selector': 'textarea',
      \ 'priority': 0,
\       },
\     }
  \ }

let g:dont_write = v:false
function! My_Write(timer) abort
  let g:dont_write = v:false
  write
endfunction

function! Delay_My_Write() abort
  if g:dont_write
    return
  end
  let g:dont_write = v:true
  call timer_start(10000, 'My_Write')
endfunction


let g:firenvim_font = 'HackGenNerd'
function! Set_Font(font) abort
  execute 'set guifont=' . a:font . ':h14'
endfunction

augroup Firenvim
  au TextChanged * ++nested call Delay_My_Write()
  au TextChangedI * ++nested call Delay_My_Write()
  au BufEnter github.com_*.txt set filetype=markdown | call Set_Font(g:firenvim_font)
  au BufEnter play.rust-lang.org_*.txt set filetype=rust | call Set_Font(g:firenvim_font)
  au BufEnter play.golang.org_*.txt set filetype=go |call Set_Font(g:firenvim_font)
augroup END