local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim', tag = '0.1.4' }
    use { 'nvim-lua/plenary.nvim' }

    use { 'nvim-lualine/lualine.nvim' }
    use { 'nvim-tree/nvim-web-devicons', opt = true }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "onsails/lspkind.nvim" }

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-context")

    use "folke/trouble.nvim"
    use("theprimeagen/harpoon")
    use { "ThePrimeagen/refactoring.nvim" }
    use("mbbill/undotree")

    use("tpope/vim-fugitive")

    use 'christoomey/vim-tmux-navigator'

    use("folke/zen-mode.nvim")

    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }

    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"

    use "rafamadriz/friendly-snippets"

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            {
                'L3MON4D3/LuaSnip',
                dependencies = { "rafamadriz/friendly-snippets" },
            },
        }
    }

    use "mfussenegger/nvim-lint"
    use "jose-elias-alvarez/null-ls.nvim"
    use "mhartington/formatter.nvim"

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    if packer_bootstrap then
        require('packer').sync()
    end
end)
