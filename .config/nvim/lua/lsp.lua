require("mason").setup()

vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

vim.opt.completeopt = { "menuone", "noselect", "popup" }

require('cmp_nvim_lsp').default_capabilities()
local cmp = require('cmp')
local luasnip = require('luasnip')

--
-- Completion code from lsp_zero
--

---If the completion menu is visible it will navigate to the next item in
---the list. If cursor is on top of the trigger of a snippet it'll expand
---it. If the cursor can jump to a luasnip placeholder, it moves to it.
---If the cursor is in the middle of a word that doesn't trigger a snippet
---it displays the completion menu. Else, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
local function luasnip_supertab(select_opts)
    return cmp.mapping(function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
            cmp.select_next_item(select_opts)
        elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
        else
            cmp.complete()
        end
    end, {'i', 's'})
end

---If the completion menu is visible it will navigate to previous item in the
---list. If the cursor can navigate to a previous snippet placeholder, it
---moves to it. Else, it uses the fallback.
---@param select_opts? cmp.SelectOption
---@return cmp.Mapping
local function luasnip_shift_supertab(select_opts)
    return cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item(select_opts)
        elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {'i', 's'})
end

--
-- End Completion code from lsp_zero
--
cmp.setup {
    sources = {
        { name = 'nvim_lsp' }
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = luasnip_supertab(),
        ['<S-Tab>'] = luasnip_shift_supertab(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
}

--
-- CONFIGS
--

require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name)
            vim.lsp.enable(server_name)
        end,
    }
})

vim.lsp.config['lua_ls'] = {
    -- Command and arguments to start the server.
    -- cmd = { 'lua-language-server' },
    -- Filetypes to automatically attach to.
    filetypes = { 'lua' },
    -- Sets the 'workspace' to the directory where any of these files is found.
    -- Files that share a root directory will reuse the LSP server connection.
    -- Nested lists indicate equal priority, see |vim.lsp.Config|.
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    -- Specific settings to send to the server. The schema is server-defined.
    -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
}

vim.lsp.config['ltex_plus'] = {
    filetypes = { 'vimwiki', 'markdown', 'md', 'pandoc', 'vimwiki.markdown.pandoc', 'tex', 'latex' },
    settings = {
        ltex = {
            -- language = 'en'
            language = 'fr'
        }
    },
}

vim.lsp.config('yamlls', {
    single_file_support = true,
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            trace = { server = 'verbose' },
            schemas = {
                kubernetes = {
                    '/*.k8s.yml',
                }
            },
        },
    }
})

