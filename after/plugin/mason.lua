local lsp_zero = require('lsp-zero')

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    ensure_installed = { 'html', "tsserver", "lua_ls", "rust_analyzer", "clangd" },
    handlers = {
        lsp_zero.default_setup,
    },
})
