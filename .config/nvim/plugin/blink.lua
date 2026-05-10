local blink_setup = false

vim.api.nvim_create_autocmd('UIEnter', {
    callback = function(_)
        if blink_setup then
            blink_setup = true
            return
        end

        require("blink.cmp").setup({
            keymap = {
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    'snippet_forward',
                    'fallback'
                },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
            },
            signature = { enabled = true },
        })
    end
})
