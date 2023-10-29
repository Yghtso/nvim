local lsp_zero = require('lsp-zero')

lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»',
})

lsp_zero.setup_servers({ 'lua_ls', 'rust_analyzer', 'clangd', 'html', 'tsserver' })

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }

    lsp_zero.buffer_autoformat()

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
end)

lsp_zero.set_server_config({
    single_file_support = false,
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
        }
    }
})


lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['rust_analyzer'] = { 'rust' },
        ['tsserver'] = { 'javascript', 'typescript' },
        ['html'] = { 'html' },
        ['clangd'] = { 'c', 'c++' },
    }
})

vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>td', "<cmd>Telescope diagnostics<cr>")
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
