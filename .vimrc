"Plugins
call pathogen#infect()
syntax enable
filetype plugin indent on

"Rules
:set number relativenumber

"ctags
set tags=tags

".swp files' locations
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

"Colors
colorscheme desert
let g:indentLine_color_term = 239

"Tabs
set expandtab
set tabstop     =2
set softtabstop =2
set shiftwidth  =2

"Switch splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"New lines without insert
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

set runtimepath^=~/.vim/bundle/ag

"Find files and text within files
map <leader>p <C-P>
map <leader>f :Ag!<Space>""<Left>
map <leader>P :tabnew<Enter><leader>p
map <leader>F :tabnew<Enter><leader>f

"Switch tabs
map <leader><left> gT
map <leader><right> gt

"New tabs
map <leader>t :tabnew<Enter>
map <leader>T :Te<Enter>

"Save
map <leader>s :w<Enter>

"Quit screen
map <leader>q :q<Enter>
