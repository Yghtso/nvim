local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {'nvim-telescope/telescope.nvim', tag = '0.1.4'}
    use {'nvim-lua/plenary.nvim'}
    use { 'nvim-lualine/lualine.nvim'}
    use { 'nvim-tree/nvim-web-devicons', opt = true }
    use { "catppuccin/nvim", as = "catppuccin" }
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use "folke/trouble.nvim"
    use("theprimeagen/harpoon")
    use {"ThePrimeagen/refactoring.nvim"}
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use 'christoomey/vim-tmux-navigator'
    use("nvim-treesitter/nvim-treesitter-context")
    use("folke/zen-mode.nvim")
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'L3MON4D3/LuaSnip'}
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "mfussenegger/nvim-lint"
    use "jose-elias-alvarez/null-ls.nvim"
    use "mhartington/formatter.nvim"

    if packer_bootstrap then
        require('packer').sync()
    end
end)
