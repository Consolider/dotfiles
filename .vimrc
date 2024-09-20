"" Enable row numbers
" set number

" Disable "Visual mode" when marking text
set mouse=
set ttymouse=

" Sets default clipboard to the system clipboard
set clipboard=unnamedplus

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible


" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugin and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on


" Turn syntax highlighting on.
syntax on


" Use space characters instead of tabs.
set expandtab

" Set tab width to 4 columns.
set tabstop=4

" Do not save backup files.
set nobackup

" Use highlighting when doing a search.
set hlsearch


" Always show statusline
set laststatus=2

set statusline=
set statusline+=%1*%<%F%=           " %< = Left align. %F = filename. %= = Split statusline.
set statusline+=%2*\ line:%l/%L\    " Current line/All lines.
set statusline+=%3*\ col:%c\        " Current column.
set statusline+=%4*\ [%p%%]\        " Percent of file.

" Change color of statusline.
hi User1 ctermfg=0 ctermbg=14 cterm=bold
hi User2 ctermfg=0 ctermbg=4  cterm=bold
hi User3 ctermfg=0 ctermbg=2  cterm=bold
hi User4 ctermfg=0 ctermbg=6  cterm=bold

"   NR-16   NR-8    COLOR NAME
"       0      0    Black
"       1      4    DarkBlue
"       2      2    DarkGreen
"       3      6    DarkCyan
"       4      1    DarkRed
"       5      5    DarkMagenta
"       6      3    Brown, DarkYellow
"       7      7    LightGray, LightGrey, Gray, Grey
"       8      0*   DarkGray, DarkGrey
"       9      4*   Blue, LightBlue
"       10     2*   Green, LightGreen
"       11     6*   Cyan, LightCyan
"       12     1*   Red, LightRed
"       13     5*   Magenta, LightMagenta
"       14     3*   Yellow, LightYellow
"       15     7*   White
