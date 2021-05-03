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

"pico-8 syntax highlighting
Plugin 'ssteinbach/vim-pico8-syntax'

"easier web-dev
Plugin 'mattn/emmet-vim'

"rainbow parens
" Plugin 'luochen1990/rainbow'

"godot stuff
Plugin 'habamax/vim-godot'

"CoC
"" Use release branch (recommend)
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

"live markdown preview
Plugin 'iamcco/markdown-preview.nvim'

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

"LaTeX
command Latex 0r ~/Documents/notes/vim_include/LaTeX_vim
command Listings r ~/Documents/notes/vim_include/LaTeX_listings.tex

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


" ***VIMWIKI***
" vimwiki with md support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_table_mappings = 0

" ***EasyAlign**
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ***QUICK-SCOPE***
" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


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


" ***COC***
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" ***ULTISNIPS***
" change ultisnips binds
"TODO (changed for CoC)
autocmd filetype tex CocDisable
autocmd filetype tex let g:UltiSnipsExpandTrigger="<tab>"
autocmd filetype tex let g:UltiSnipsJumpForwardTrigger="<tab>"
autocmd filetype tex let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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

