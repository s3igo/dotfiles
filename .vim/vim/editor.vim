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

"" auto reload .vimrc
augroup source-vimrc
	autocmd!
	autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
	autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

"" HTML/XML closure completion
augroup MyXML
	autocmd!
	autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
	autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END
