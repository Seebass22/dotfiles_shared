return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- statusline
    use 'vim-airline/vim-airline'

    -- Lazy loading:
    -- Load on specific commands
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

    -- nvim terminal support for dispatch (:Make)
    use 'radenling/vim-dispatch-neovim'

    -- comments
    use 'tpope/vim-commentary'

    -- LaTeX
    use 'lervag/vimtex'

    -- magit clone
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

    -- wal colorscheme
    use 'dylanaraps/wal.vim'

    use 'habamax/vim-godot'

    -- Configurations for Nvim LSP
    use 'neovim/nvim-lspconfig'

    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    use 'hrsh7th/cmp-buffer' -- complete words from current buffer
    use 'hrsh7th/cmp-path' -- complete file paths
    use 'hrsh7th/cmp-nvim-lua' -- complete nvim api functions

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- for sardine https://sardine.raphaelforment.fr/editors/vim.html
    use 'jpalardy/vim-slime'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)
