_: {
  opts = {
    shiftwidth = 4;
    softtabstop = 4;
    expandtab = true;
    smartindent = true;
    breakindent = true;
    visualbell = true;
    ignorecase = true;
    smartcase = true;
    shell = "fish";
    swapfile = false;
    termguicolors = true;
    pumblend = 25;
    number = true;
    list = true;
    cursorline = true;
    guicursor = [
      "n-v-sm-t:block"
      "c-i-ci-ve:ver25"
      "r-cr-o:hor20"
    ];
    listchars = {
      space = "･";
      tab = ">-";
      eol = "¬";
      extends = "»";
      precedes = "«";
      nbsp = "+";
      trail = "~";
    };
    laststatus = 3;
    signcolumn = "yes";
    colorcolumn = [
      80
      100
      120
    ];
    showmatch = true;
    scrolloff = 5;
    relativenumber = true;
    winborder = "single";
  };
}
