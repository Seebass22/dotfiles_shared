require('plugins')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.breakindent = true
vim.opt.hidden = true

-- syntax on
vim.cmd([[
filetype indent on
filetype plugin on
]])

-- TODO uncomment with plugins
vim.cmd("colorscheme wal")

-- search as characters are entered
vim.opt.incsearch = true

-- better command line completion
vim.opt.wildmenu = true

-- TODO switch back to spaces
-- "indentation settings for using 4 spaces instead of tabs.
-- "does not change tabstop from its default value of 8.
-- "set shiftwidth=4
-- "set softtabstop=4
-- "set expandtab

-- Indentation settings for using hard tabs for indent.
-- Display tabs as four characters wide
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- " toggles between paste and nopaste
vim.opt.pastetoggle = "<F2>"

-- TODO plugins
-- let g:airline#extensions#tabline#enabled = 1
-- "let g:airline_left_sep='>'
-- "let g:airline_right_sep='<'

vim.opt.inccommand = "nosplit"
-- invisible characters
vim.opt.listchars = "tab:▸\\ ,eol:¬"

vim.cmd("nnoremap <bs> <c-^>")

-- unmap ZZ
vim.cmd("nnoremap ZZ <Nop>")

vim.cmd('nnoremap <Space><space> /<++><Enter>"_c4l')

-- "clear search with ctrl l
vim.cmd('nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>')

-- autocmd FileType markdown setlocal commentstring=<\!--\ %s\ -->
-- autocmd FileType vhdl setlocal commentstring=--\ %s
-- autocmd FileType matlab setlocal commentstring=\%\ %s"

-- let g:tex_flavor='latex'

-- TODO
-- " better diffs
-- set diffopt+=algorithm:patience
-- set diffopt+=indent-heuristic

-- TODO
-- " ***FZF***
-- nmap <leader>f :Files<cr>|             " fuzzy find files in the working directory
-- nmap <leader>g :GFiles<cr>|            " fuzzy find git files in the working directory
-- nmap <leader>b :Buffers<cr>|           " fuzzy find an open buffer
-- nmap <leader>t :BTags<cr>|             " fuzzy find tags in current buffer
-- nmap <leader>T :Tags<cr>|              " fuzzy find tags across project
-- vnoremap <c-p> "ry:<c-u>Rg <c-r>r<cr>| " Rg search visual selection

-- " ***GODOT***
-- nnoremap <F6> :GodotRun<cr>


-- " ***ULTISNIPS***
-- " change ultisnips binds
-- "TODO (changed for CoC)
-- " autocmd filetype tex CocDisable
-- autocmd filetype tex let g:UltiSnipsExpandTrigger="<tab>"
-- autocmd filetype tex let g:UltiSnipsJumpForwardTrigger="<tab>"
-- autocmd filetype tex let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

-- " ***VIMTEX***
-- " use zathura as PDF viewer for vimtex
-- let g:vimtex_view_method='zathura'

-- " let g:vimtex_complete_enabled=0

-- " used for callback
-- let g:vimtex_compiler_progname="nvr"

-- " enable folding
-- let g:vimtex_fold_enabled=1
-- let g:vimtex_fold_manual=1

-- " suppress overfull/underfull warnings in quickfix list
-- let g:vimtex_quickfix_ignore_filters = [
--       \ 'Underfull',
--       \ 'Overfull',
--       \]
