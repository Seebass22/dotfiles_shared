"vundle stuff:
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" plugin-manager
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"statusline
Plugin 'vim-airline/vim-airline'

"wal colortheme
Plugin 'dylanaraps/wal.vim'
"
"highlights yanked text
Plugin 'machakann/vim-highlightedyank'

"git wrapper
Plugin 'tpope/vim-fugitive'

"github extension for fugitive
Plugin 'tpope/vim-rhubarb'

"comment stuff out easily
Plugin 'tpope/vim-commentary'

"search/select/edit sandwiched textobjects
Plugin 'machakann/vim-sandwich'

"i3 config syntax highlighting
Plugin 'PotatoesMaster/i3-vim-syntax'

"snippet functionality
Plugin 'SirVer/ultisnips'

"call tmux/nvim terminal for make
Plugin 'tpope/vim-dispatch'

"nvim terminal support for dispatch (:Make)
Plugin 'radenling/vim-dispatch-neovim'

"fzf functions
Plugin 'junegunn/fzf.vim'

"latex plugin
Plugin 'lervag/vimtex'

"note plugin
Plugin 'vimwiki/vimwiki'

"align stuff
Plugin 'junegunn/vim-easy-align'

"database integration
Plugin 'tpope/vim-dadbod'


"easier web-dev
Plugin 'mattn/emmet-vim'

"C# autocompletion
" Plugin 'OmniSharp/omnisharp-vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"actual vimrc:
set number
set relativenumber
set nocompatible
set ignorecase
set smartcase
set breakindent
set hidden
"set showbreak=\\\\\
syntax on
filetype indent on
filetype plugin on

"set background=light
colorscheme wal

" search as characters are entered
set incsearch

" highlight matches
"set hlsearch

" better command line completion
set wildmenu

" highlight current line
"set cursorline

"indentation settings for using 4 spaces instead of tabs.
"does not change tabstop from its default value of 8.
"set shiftwidth=4
"set softtabstop=4
"set expandtab

"Indentation settings for using hard tabs for indent.
"Display tabs as four characters wide
set shiftwidth=4
set tabstop=4

" toggles between paste and nopaste
"set pastetoggle=<F2>

let g:airline#extensions#tabline#enabled = 1
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'

if has('nvim')
	" show the effects of commands incrementally
	set inccommand=nosplit
	" invisible characters
	set listchars=tab:▸\ ,eol:¬
endif

"backspace switches to alternative buffer
nnoremap <bs> <c-^>

"F2 runs make
nnoremap <F2> :Make<CR>

"F3 runs make run (nvim terminal)
nnoremap <F3> :Make run<CR>

"delete switches to next buffer
nnoremap <DEL> :bn<CR>

"unmap ZZ
nnoremap ZZ <Nop>

"bind to remove trailing spaces after lines (do not use on vimrc)
"nnoremap <F5> :%s/\s\+$//e

nnoremap <Space><space> /<++><Enter>"_c4l

"clear search with ctrl l
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>

"run gnu octave on file
command Octave !octave --no-gui %
"format tables
command Plot r !~/bashscripts/plot.sh
command Plot2 r !~/bashscripts/plot.sh -r
"print MPD/Spotify song
command Music r !~/bashscripts/musicstatus.sh
"sign code file
command Sign 0r ~/Documents/notes/echtzeitsysteme_sign
"include guards
command Header norm ggO%hr_0gUWI#ifndef yyplcwdefineGo#endif
command Include norm ggO%hr_0gUWI#ifndef yyplcwdefineGo#endif
command Guards norm ggO%hr_0gUWI#ifndef yyplcwdefineGo#endif

"comment syntax for markdown (vim-commentary plugin)
autocmd FileType markdown setlocal commentstring=<\!--\ %s\ -->
autocmd FileType vhdl setlocal commentstring=--\ %s
autocmd FileType matlab setlocal commentstring=\%\ %s"

" automatic folding for c/cpp, folds open first
autocmd FileType c\|cpp set foldmethod=syntax
autocmd FileType c\|cpp set nofoldenable

let g:tex_flavor='latex'

" better diffs
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" ***ULTISNIPS***
" change ultisnips binds
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" makes custom snippets work
let g:UltiSnipsSnippetsDir = "~/.vim/ultisnips"
let g:UltiSnipsSnippetDirectories=["ultisnips"]

" ***VIMTEX***
" use zathura as PDF viewer for vimtex
let g:vimtex_view_method='zathura'

" let g:vimtex_complete_enabled=0

" used for callback
let g:vimtex_compiler_progname="nvr"

" enable folding
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=1


" ***VIMWIKI***
" vimwiki with md support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" ***EasyAlign**
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ***QUICK-SCOPE***
" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"

" ***FZF***
nmap <leader>f :Files<cr>|             " fuzzy find files in the working directory
nmap <leader>g :GFiles<cr>|            " fuzzy find git files in the working directory
nmap <leader>b :Buffers<cr>|           " fuzzy find an open buffer
nmap <leader>t :BTags<cr>|             " fuzzy find tags in current buffer
nmap <leader>T :Tags<cr>|              " fuzzy find tags across project
vnoremap <c-p> "ry:<c-u>Rg <c-r>r<cr>| " Rg search visual selection
