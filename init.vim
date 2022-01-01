" set without plugin
:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set noswapfile
:set softtabstop=4
:set showtabline=0
:set relativenumber
:set incsearch
:set cursorline
:set nohlsearch

" Remap leader to space bar , '/' when no remap
:let mapleader = "\<Space>"

" Call of all plugin 
call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Use cs' to change the '' to  another thing like {}
Plug 'https://github.com/justinmk/vim-syntax-extra' " Extra syntax color
Plug 'https://github.com/preservim/nerdtree' " NerdTree / file browser like IDE
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons for more beautiful style
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto complete + snippets
Plug 'https://github.com/jiangmiao/auto-pairs' " a simple auto pairs
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'honza/vim-snippets' " Snippets for speeedd
Plug 'skywind3000/asyncrun.vim' " to start quickfix
Plug 'https://github.com/vim-airline/vim-airline' " To magnify the vim status bar
Plug 'vim-airline/vim-airline-themes' " To magnify even more the status bar
Plug 'othree/yajs.vim' " Color and auto complete react...
Plug 'mxw/vim-jsx'
Plug 'nvim-lua/plenary.nvim' " For making telescope and harpoon working
Plug 'nvim-telescope/telescope.nvim' " Fuzzy finder eke file finder really fast
Plug 'ThePrimeagen/harpoon' " To have a better view of tabs and save file to temp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " To make telescope and live grep work
Plug 'kyazdani42/nvim-web-devicons' " More ICONS
Plug 'https://github.com/szw/vim-maximizer' " To maximize a windows with one shortcut
Plug 'tpope/vim-fugitive' " Git update in neovim 
Plug 'https://github.com/ThePrimeagen/vim-be-good' " To be better at vim
Plug 'morhetz/gruvbox' " The best colorscheme ever !
Plug 'https://github.com/tpope/vim-commentary' " Easy commentting / gc to comment in visual

" Plugin unuse
Plug 'folke/trouble.nvim' " Don't use today
Plug 'puremourning/vimspector' " Don't use today

:set encoding=UTF-8
call plug#end()

" For style / color / status bar / background / Nerd tree beauty
:colorscheme gruvbox
highlight Normal ctermfg=white ctermbg=none
let g:badwolf_darkgutter = 0
let g:badwolf_tabline = 1
let g:gruvbox_contrast_dark = 'hard'
let g:airline_theme='base16_gruvbox_dark_hard'
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" nerd tree setup
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Airline setup
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_y = airline#section#create_right(['🐧  ','ffenc'])
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

" Coc setup
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : <Tab>""
:set completeopt-=preview " For No Previews

" Telescope and harpoon setup
nnoremap <leader>p :Telescope find_files<CR>
nnoremap <leader>h :Telescope live_grep<CR>
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>t :lua require("harpoon.ui").toggle_quick_menu()<CR>

" To navigate trought quickfix list
nnoremap <C-c> :cn<CR>
nnoremap <C-f> :cp<CR>

" To deplace line in visual / insert / normal mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" To delete a pattern of word one by one
nnoremap c* *``cgn
nnoremap c# #``cgN

" To refresh tags files in programme for c 
nnoremap :ze :w !ctags -R Desktop/Programme<CR><CR>

" To maximize windows and demaximize
nnoremap <C-y> :MaximizerToggle<CR>
nnoremap <C-d> :MaximizerToggle!<CR>

" To simplify switching windows
nnoremap <C-h> :winc h<CR>
nnoremap <C-j> :winc j<CR>
nnoremap <C-k> :winc k<CR>
nnoremap <C-l> :winc l<CR>

" To make basic move more clean
nnoremap Y y$
nnoremap n nzzzn
nnoremap N Nzzzv
nnoremap J mzJ`z
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
"inoremap <Tab> <C-v><Tab>

" fugitive setup
nmap <leader>gj :diffget //3<CR>
nmap <leader>gk :diffget //2<CR>
nmap <leader>gs :G<CR>

" Terminal command 
function! OpenTerminal()
	vsplit 
	vertical resize 60
	winc l
	term
	set nonu
	set norelativenumber
	startinsert
endfunction
tnoremap <Esc><Esc> <C-\><C-n>
nnoremap <leader>te :call OpenTerminal()<CR>

" To make mouse usable or not
function Mouse()
	set mouse=a
endfunction
function Unmouse()
	set mouse=
endfunction
noremap <silent> <leader>mo :call Mouse()<CR>
noremap <silent> <leader>om :call Unmouse()<CR>

" space z to toggle quickfix window
nnoremap <leader>z :call asyncrun#quickfix_toggle(6)<cr>
" Compile in c
noremap <silent> <leader>c :AsyncRun gcc -Wall -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c without warning
noremap <silent> <leader>wc :AsyncRun gcc -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c++
noremap <silent> <leader>C :AsyncRun g++ -Wall -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c++ without warning
noremap <silent> <leader>wC :AsyncRun g++ -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c#
noremap <silent> <leader>m :AsyncRun mcs -out:$(VIM_FILEDIR)/$(VIM_FILENOEXT) $(VIM_FILEPATH)<cr>
" Compile in java
noremap <silent> <leader>j :AsyncRun javac $(VIM_FILEPATH)<cr>

" set the quickfix window 6 lines height.
let g:asyncrun_open = 6

" To hide the shit 
au VimEnter * silent exec "!kill -s SIGWINCH $PPID"

" Just to avoid arrow keys bad habits
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

