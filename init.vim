" In case its not auto-enable
set encoding=UTF-8

" set without plugin
:set number " Show number of line
:set autoindent " Auto indent when needed like in c files
:set tabstop=4 " make tab stop at 4 spaces
:set shiftwidth=4 " The same
:set smarttab " Make tab when needed
:set noswapfile " Get ride of shitty swap files
:set softtabstop=4 " Tab 4 spaces
:set showtabline=0  " Dont know why but it is here 
:set relativenumber " Make number relative to jump faster where i want
:set incsearch " when u '/' = search for something it inc letter by letter
:set cursorline " Show cursor line to be aware of where is the cursor
:set nohlsearch  " Disable highlight when finish searching

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
Plug 'nvim-lua/plenary.nvim' " For making telescope and harpoon working
Plug 'nvim-telescope/telescope.nvim' " Fuzzy finder eke file finder really fast
Plug 'ThePrimeagen/harpoon' " To have a better view of tabs and save file to temp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " To make telescope and live grep work
Plug 'https://github.com/szw/vim-maximizer' " To maximize a windows with one shortcut
Plug 'tpope/vim-fugitive' " Git update in neovim 
Plug 'https://github.com/ThePrimeagen/vim-be-good' " To be better at vim
Plug 'morhetz/gruvbox' " The best colorscheme ever !
Plug 'https://github.com/tpope/vim-commentary' " Easy commentting / gc to comment in visual
Plug 'christoomey/vim-tmux-navigator' " Make tmux and vim together just full of love betwen them
Plug 'puremourning/vimspector' " Debugger for vim in multiple language
Plug 'https://github.com/ludovicchabant/vim-gutentags' " Automatically update tags files
Plug 'kyazdani42/nvim-web-devicons' " Icons for Telescope

" Plugin unuse
"  Plug 'preservim/tagbar' " Menu for function,const,variable
"  Plug 'folke/trouble.nvim' " Don't use today

call plug#end()

" To get acces to this file
nnoremap <silent> <leader>rc :e $MYVIMRC<cr>

" For style / color / status bar / background / Nerd tree beauty
:colorscheme gruvbox  " The best colorscheme ever
highlight Normal ctermfg=white ctermbg=none 
let g:badwolf_darkgutter = 0
let g:badwolf_tabline = 1 " show tabline
let g:gruvbox_contrast_dark = 'hard' " Make gruvbox really dark mode
let g:airline_theme='base16_gruvbox_dark_hard' " Make status bar and buffer bar in theme with gruvbox
let g:NERDTreeDirArrowExpandable="" " When file not open in nerd tree show this icon
let g:NERDTreeDirArrowCollapsible="" " When file open in nerd tree show this icon

" nerd tree setup
nnoremap <C-e> :NERDTreeFind<CR> 
nnoremap <C-t> :NERDTreeToggle<CR>

" Airline setup
let g:airline#extensions#tabline#enabled = 1 " Show tab and buffer bar
let g:airline_powerline_fonts = 1 " Enable icons and symbols in bar 
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show number of buffer and tab for speed
let g:airline#extensions#whitespace#enabled = 0 " For beauty just disable unuse space
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}']) " Redesign of the bar for more minimalist line and column counter
let g:airline_section_y = '🦕' " Disable encoding format in status bar
" let g:airline#extensions#tabline#left_sep = ""
" let g:airline#extensions#tabline#left_alt_sep = ""
" let g:airline#extensions#tabline#right_sep = ""
" let g:airline#extensions#tabline#right_alt_sep = ""
let airline#extensions#coc#error_symbol = 'ﲍ' " Show this icon for error in status bar
let airline#extensions#coc#warning_symbol = '' " Show this icon for warning in status bar

" To enable rounded corner
let g:airline_left_sep = ""
let g:airline_right_sep = ""

" Vimspector setup (debug)
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nnoremap <leader>dk :call vimspector#StepOut()<CR>
nnoremap <leader>dl :call vimspector#StepInto()<CR>
nnoremap <leader>dj :call vimspector#StepOver()<CR>
nnoremap <leader>d_ :call vimspector#Restart()<CR>
nnoremap <leader>dn :call vimspector#Continue()<CR>
nnoremap <leader>drc :call vimspector#RunToCursor()<CR>
nnoremap <leader>dh :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dx :call vimspector#ToggleConditionalBreakpoint()<CR>

" Coc setup
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : <Tab>"" 
:set completeopt-=preview " For No Previews

" Telescope and harpoon setup
nnoremap <leader>p :Telescope find_files<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>H :Telescope live_grep<CR>
nnoremap <leader><Up> :Telescope help_tags<CR>
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>t :lua require("harpoon.ui").toggle_quick_menu()<CR>

" To navigate trought quickfix list
nnoremap <C-c> :cn<CR>
nnoremap <C-f> :cp<CR>

" To navigate throught buffers
nnoremap <leader>h :bp<CR>
nnoremap <leader>x :bd<CR>
nnoremap <leader>l :bn<CR>

" To deplace line in visual / insert / normal mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" To delete a pattern of word one by one
nnoremap c* *``cgn
nnoremap c# #``cgN

" To maximize windows and demaximize
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
nnoremap <leader>ko :call OpenTerminal()<CR>

" To make mouse usable or not
function Mouse()
	set mouse=a
endfunction
function Unmouse()
	set mouse=
endfunction
noremap <silent> <leader>mo :call Mouse()<CR>
noremap <silent> <leader>se :call Unmouse()<CR>

" space z to toggle quickfix window
nnoremap <leader>z :call asyncrun#quickfix_toggle(6)<cr>
" Compile in c
noremap <silent> <leader>c :AsyncRun gcc -Wall -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c without warning
noremap <silent> <leader>wc :AsyncRun gcc -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" -lm <cr>
" Compile in c++
noremap <silent> <leader>C :AsyncRun g++ -Wall -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c++ without warning
noremap <silent> <leader>wC :AsyncRun g++ -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" Compile in c#
noremap <silent> <leader># :AsyncRun mcs -out:$(VIM_FILEDIR)/$(VIM_FILENOEXT) $(VIM_FILEPATH)<cr>
" Compile in java
noremap <silent> <leader>j :AsyncRun javac $(VIM_FILEPATH)<cr>

" set the quickfix window 6 lines height.
let g:asyncrun_open = 6

" To hide the shit 
au VimEnter * silent exec "!kill -s SIGWINCH $PPID"

" Remap start and end of line which are show to end and start of the current line
map L $
map H ^

" Make p (yank) replace a whole function
nnoremap paw "_dawP
nnoremap pi{ "_di{P
nnoremap piB "_di{P
nnoremap pi} "_di}P
nnoremap pi( "_di(P
nnoremap pib "_di(P
nnoremap pi) "_di)P
nnoremap pi' "_di'P
nnoremap pi" "_di"P

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
