return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 4,
            },
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
            },
        })

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                
                if vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
                end
                
                vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            end,
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config.clangd = vim.tbl_deep_extend("force", vim.lsp.config.clangd or {}, {
            capabilities = capabilities,
            filetypes = { "c", "cpp", "cc", "cxx", "objc", "objcpp", "cuda", "h", "hh", "hpp", "hxx" },
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--clang-tidy-checks=*",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--all-scopes-completion",
            },
            settings = {
                clangd = {
                    diagnostics = {
                        -- On demande à clangd de ne pas promouvoir les warnings en erreurs
                        warningsAsErrors = false,
                    }
                }
            }
        })
        
        vim.lsp.config.bashls = vim.tbl_deep_extend("force", vim.lsp.config.bashls or {}, {
            capabilities = capabilities,
        })
        
        vim.lsp.config.cmake = vim.tbl_deep_extend("force", vim.lsp.config.cmake or {}, {
            capabilities = capabilities,
        })

        vim.lsp.enable("clangd")
        vim.lsp.enable("bashls")
        vim.lsp.enable("cmake")
    end,
}
