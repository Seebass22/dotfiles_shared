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

"statusline themes
Plugin 'vim-airline/vim-airline-themes'

"highlights yanked text
Plugin 'machakann/vim-highlightedyank'

"git wrapper
Plugin 'tpope/vim-fugitive'

"github extension for fugitive
Plugin 'tpope/vim-rhubarb'

"comment stuff out easily
Plugin 'tpope/vim-commentary'

"i3 config syntax highlighting
Plugin 'PotatoesMaster/i3-vim-syntax'

" two letter find movement
Plugin 'justinmk/vim-sneak'

"snippet functionality
" Plugin 'SirVer/ultisnips'

"default snippets
"Plugin 'honza/vim-snippets'

" C# autocompletion
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

"invisible characters
set listchars=tab:▸\ ,eol:¬

if has('nvim')
	set inccommand=nosplit
endif

"backspace switches to alternative buffer
nnoremap <bs> <c-^>

"bind to remove trailing spaces after lines (do not use on vimrc)
"nnoremap <F5> :%s/\s\+$//e

"inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
nnoremap <Space><space> /<++><Enter>"_c4l
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>

"for loop (REPLACED BY ULTISNIPS)
"count <leader>for
" inoremap <leader>for <esc>Ifor (int i = 0; i < <esc>A; i++) {<enter>}<esc>O

"run gnu octave on file
command Octave !octave --no-gui %

"comment syntax for markdown (vim-commentary plugin)
autocmd FileType markdown setlocal commentstring=<\!--\ %s\ -->

"change ultisnips binds
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"makes custom snippets work
" let g:UltiSnipsSnippetsDir = "~/.vim/ultisnips"
" let g:UltiSnipsSnippetDirectories=["ultisnips"]

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" let omnisharp use system installed mono
" let g:OmniSharp_server_use_mono = 1
