local lsp_zero = require('lsp-zero')

lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»',
})

lsp_zero.setup_servers({ 'lua_ls', 'rust_analyzer', 'clangd', 'html', 'tsserver' })

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.buffer_autoformat()

    local opts = { buffer = bufnr }

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

lsp_zero.buffer_autoformat()

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

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>td', "<cmd>Telescope diagnostics<cr>")
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)




local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require('lspkind')
lspkind.init()

cmp.setup({
    formatting = {

        -- here is where the change happens
        format = function (entry, vim_item)
           vim_item.kind = lspkind.presets.default[vim_item.kind]
           vim_item.menu = ({
               nvim_lsp = "[LSP]",
               look = "[Dict]",
               buffer = "[Buffer]",
            })[entry.source.name]
            vim_item.kind, vim_item.menu = vim_item.menu, vim_item.kind
            return vim_item
        end
    },

    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        {
            option = {
                keyword_pattern = [[\k\+]],
            }
        },
        { name = 'path' }
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
})

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
