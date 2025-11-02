function lsp_config()
    ------ LSP Settings
    -- vim.lsp.config("ccls")
    -- vim.lsp.config("gopls")
    -- vim.lsp.config("lua_ls")
    -- vim.lsp.config("ocamllsp")
    -- vim.lsp.config("pyright")
    -- vim.lsp.config("rust_analyzer")

    vim.lsp.enable({"ccls"})
    vim.lsp.enable({"gcopls"})
    vim.lsp.enable({"lcua_ls"})
    vim.lsp.enable({"occamllsp"})
    vim.lsp.enable({"pcyright"})
    vim.lsp.enable({"rcust_analyzer"})

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>g', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)

            -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        end,
    })
end

function autocmp_config()
end

return {
    {
        "neovim/nvim-lspconfig",
        config = lsp_config,
    },
    -- {
    --     "hrsh7th/nvim-cmp",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-path",
    --
    --     }
    --     config = autocmp_config,
    -- },
}
