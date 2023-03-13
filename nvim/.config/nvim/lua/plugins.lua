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

    use 'tpope/vim-commentary'

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
end)
