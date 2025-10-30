{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.vim-full.customize {
      name = "vim";
      vimrcConfig.customRC = ''
        " 24bit-color
        if (has("termguicolors"))
            set termguicolors
        endif

        " to UTF-8
        set fenc=utf-8

        " not to make backup & swap & viminfo file
        set nobackup
        set noswapfile
        set viminfo+=n$XDG_STATE_HOME/viminfo

        " enable mouse(wheel) control
        set mouse=a
        set ttymouse=xterm2

        " enable incremental search
        set incsearch

        " set 4-width soft tab
        set tabstop=4
        set shiftwidth=4
        set expandtab

        " trail eol space
        set listchars=tab:^\ ,trail:~

        " smartindent
        set smartindent

        " display
        set title
        set number
        set cursorline
        syntax on

        " enable status line
        set laststatus=2

        " enphasize display
        set showmatch

        " enable eol cursor
        set virtualedit=onemore

        " cli completion
        set wildmode=list:longest
      '';
    })
  ];
}
