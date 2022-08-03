call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

"statusline
Plug 'vim-airline/vim-airline'

"wal colortheme
Plug 'dylanaraps/wal.vim'
"
"highlights yanked text
Plug 'machakann/vim-highlightedyank'

"git wrapper
Plug 'tpope/vim-fugitive'

"comment stuff out easily
Plug 'tpope/vim-commentary'

"search/select/edit sandwiched textobjects
"Plug 'machakann/vim-sandwich'

"i3 config syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax'

"snippet functionality
Plug 'SirVer/ultisnips'

"call tmux/nvim terminal for make
Plug 'tpope/vim-dispatch'

"nvim terminal support for dispatch (:Make)
Plug 'radenling/vim-dispatch-neovim'

"fzf functions
Plug 'junegunn/fzf.vim'

"latex plugin
Plug 'lervag/vimtex'

"align stuff
Plug 'junegunn/vim-easy-align'

"pico-8 syntax highlighting
Plug 'ssteinbach/vim-pico8-syntax'

"easier web-dev
Plug 'mattn/emmet-vim'

"godot stuff
Plug 'habamax/vim-godot'

"live markdown preview
Plug 'iamcco/markdown-preview.nvim'

"TOML syntax
Plug 'cespare/vim-toml'

"tweaks for writing prose
Plug 'reedes/vim-pencil'

"distraction-free writing
Plug 'junegunn/goyo.vim'

"org-mode syntax
Plug 'axvr/org.vim'

" Initialize plugin system
call plug#end()

"actual vimrc:
set number
set relativenumber
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

" better command line completion
set wildmenu

"indentation settings for using 4 spaces instead of tabs.
"does not change tabstop from its default value of 8.
"set shiftwidth=4
"set softtabstop=4
"set expandtab

"Indentation settings for using hard tabs for indent.
"Display tabs as four characters wide
" set shiftwidth=4
" set tabstop=4

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

"F3 runs octave on file (nvim terminal)
autocmd filetype matlab nnoremap <F3> :terminal octave -q --no-gui --persist %<CR>

"F4 toggles relativenumber
nnoremap <F4> :set rnu!<CR>

"unmap ZZ
nnoremap ZZ <Nop>

"bind to remove trailing spaces after lines (do not use on vimrc)
"nnoremap <F5> :%s/\s\+$//e

nnoremap <Space><space> /<++><Enter>"_c4l

"clear search with ctrl l
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>

"run gnu octave on file
command Octave !octave -q --no-gui %
"format tables
command Plot r !~/bashscripts/plot.sh
command Plot2 r !~/bashscripts/plot.sh -r
"print MPD/Spotify song
command Music r !~/bashscripts/musicstatus.sh
"include guards
command Header norm ggO%hr_0gUWI#ifndef yyplcwdefineGo#endif
command Include norm ggO%hr_0gUWI#ifndef yyplcwdefineGo#endif
command Guards norm ggO%hr_0gUWI#ifndef yyplcwdefineGo#endif
"format html file as one line
command OneLine r !~/bashscripts/to_one_line.sh index.html

"LaTeX
command Latex 0r ~/Documents/notes/other/vim_include/LaTeX_vim
command Listings r ~/Documents/notes/other/vim_include/LaTeX_listings.tex

"comment syntax (vim-commentary plugin)
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

" ***EasyAlign**
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"
" ***FZF***
nmap <leader>f :Files<cr>|             " fuzzy find files in the working directory
nmap <leader>g :GFiles<cr>|            " fuzzy find git files in the working directory
nmap <leader>b :Buffers<cr>|           " fuzzy find an open buffer
nmap <leader>t :BTags<cr>|             " fuzzy find tags in current buffer
nmap <leader>T :Tags<cr>|              " fuzzy find tags across project
vnoremap <c-p> "ry:<c-u>Rg <c-r>r<cr>| " Rg search visual selection

nmap <Left> :bp<cr>
nmap <Right> :bn<cr>


" ***GODOT***
nnoremap <F6> :GodotRun<cr>

"
" ***ULTISNIPS***
" change ultisnips binds
"TODO (changed for CoC)
" autocmd filetype tex CocDisable
autocmd filetype tex let g:UltiSnipsExpandTrigger="<tab>"
autocmd filetype tex let g:UltiSnipsJumpForwardTrigger="<tab>"
autocmd filetype tex let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ***VIMTEX***
" use zathura as PDF viewer for vimtex
let g:vimtex_view_method='zathura'

" let g:vimtex_complete_enabled=0

" used for callback
let g:vimtex_compiler_progname="nvr"

" enable folding
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=1

" suppress overfull/underfull warnings in quickfix list
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \]
