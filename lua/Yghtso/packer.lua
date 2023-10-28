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
    -- My plugins here

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { "catppuccin/nvim", as = "catppuccin" }

    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

    use "folke/trouble.nvim"

    use 'nvim-tree/nvim-web-devicons'

    use("theprimeagen/harpoon")

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }
    use("mbbill/undotree")

    use("tpope/vim-fugitive")

    use 'christoomey/vim-tmux-navigator'

    use("nvim-treesitter/nvim-treesitter-context");

    use("folke/zen-mode.nvim")

    if packer_bootstrap then
        require('packer').sync()
    end
end)
