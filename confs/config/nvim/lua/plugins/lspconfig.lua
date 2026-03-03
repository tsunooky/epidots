return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp", -- Ensures we can link autocompletion capabilities
    },
    config = function()
        -- Automatically install required LSPs
        require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "bashls", "cmake" }
        })

        -- Modern Nvim 0.11 Keymaps (Triggered only when an LSP attaches to a buffer)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                
                -- Definition / Code
                vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
                
                -- Declaration / Header
                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
                
                -- Documentation hover
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                
                -- Rename variable everywhere
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            end,
        })

        -- Get completion capabilities from nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Setup C/C++ LSP using new Nvim 0.11 API (Merging with defaults)
        vim.lsp.config.clangd = vim.tbl_deep_extend("force", vim.lsp.config.clangd or {}, {
            capabilities = capabilities,
            filetypes = { "c", "cpp", "cc", "cxx", "objc", "objcpp", "cuda", "h", "hh", "hpp", "hxx" },
        })
        
        -- Setup Bash LSP
        vim.lsp.config.bashls = vim.tbl_deep_extend("force", vim.lsp.config.bashls or {}, {
            capabilities = capabilities,
        })
        
        -- Setup CMake LSP
        vim.lsp.config.cmake = vim.tbl_deep_extend("force", vim.lsp.config.cmake or {}, {
            capabilities = capabilities,
        })

        -- Enable the LSPs natively
        vim.lsp.enable("clangd")
        vim.lsp.enable("bashls")
    end,
}
