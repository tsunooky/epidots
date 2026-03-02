return {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buffer = args.buf }
                
                -- gd: Prototype/Header (.h)
                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
                -- gD: Implementation/Code (.c)
                vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
                -- gb: Go back
                vim.keymap.set("n", "gb", "<C-o>", opts)
                
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set({"n", "i"}, "<A-Insert>", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            end,
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        if vim.fn.has("nvim-0.11") == 1 then
            vim.lsp.config.clangd = {
                cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
                capabilities = capabilities,
            }
            vim.lsp.config.jdtls = { capabilities = capabilities }
            vim.lsp.enable("clangd")
            vim.lsp.enable("jdtls")
        else
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup({
                cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({ capabilities = capabilities })
        end
    end
}
