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

vim.cmd("colorscheme wal")

-- search as characters are entered
vim.opt.incsearch = true

-- better command line completion
vim.opt.wildmenu = true

-- "indentation settings for using 4 spaces instead of tabs.
-- "does not change tabstop from its default value of 8.
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Indentation settings for using hard tabs for indent.
-- Display tabs as four characters wide
-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4

-- " toggles between paste and nopaste
vim.opt.pastetoggle = "<F2>"

vim.g['airline#extensions#tabline#enabled'] = true

vim.opt.inccommand = "nosplit"
-- invisible characters
-- vim.opt.listchars = { tab = '▸', eol = '¬' }
-- vim.opt.listchars = { space = '_', tab = '>~' }

vim.cmd("nnoremap <bs> <c-^>")

-- unmap ZZ
vim.cmd("nnoremap ZZ <Nop>")

vim.cmd('nnoremap <Space><space> /<++><Enter>"_c4l')

-- "clear search with ctrl l
vim.cmd('nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>')

-- autocmd FileType markdown setlocal commentstring=<\!--\ %s\ -->
-- autocmd FileType vhdl setlocal commentstring=--\ %s
-- autocmd FileType matlab setlocal commentstring=\%\ %s"

-- " ***GODOT***
-- nnoremap <F6> :GodotRun<cr>

-- " ***VIMTEX***
vim.cmd([[
let g:tex_flavor='latex'

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
]])

local neogit = require("neogit")

neogit.setup {
    use_magit_keybindings = true,
}

-- *** LSPCONFIG ***
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['gdscript'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {}
    }
}

-- nvim-cmp
-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end

local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        -- order is priority
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        -- only show suggestions after 5 chars
        { name = 'buffer', keyword_length = 5 },
    },
}

-- luasnip setup
local ls = require 'luasnip'
ls.config.set_config {
    -- remember last snippet
    -- allow jumping back to it
    history = true,

    -- enable dynamic snippets
    updateevents = "TextChanged,TextChangedI",
}

require("luasnip.loaders.from_snipmate").lazy_load({paths = "./snippets/"})
