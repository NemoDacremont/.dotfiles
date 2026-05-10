local mason_setup = false

vim.api.nvim_create_autocmd('UIEnter', {
    callback = function(_)
        if mason_setup then
            mason_setup = true
            return
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_enable = false,
        })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, {})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, {})
        vim.keymap.set('n', 'gR', vim.lsp.buf.rename, {})
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, {})
        vim.keymap.set({ 'n', 'x' }, 'gf', function()
            vim.lsp.buf.format({ async = true })
        end, {})
    end
})
