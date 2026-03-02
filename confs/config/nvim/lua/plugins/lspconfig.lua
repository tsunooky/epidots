return {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
        vim.filetype.add({
            extension = {
                hh = "cpp",
                hxx = "cpp",
                hpp = "cpp",
                inc = "cpp",
            },
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buffer = args.buf }
                
                vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gb", "<C-o>", opts)
                
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set({"n", "i"}, "<A-Insert>", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            end,
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local root_files = { "Makefile", "configure.ac", ".git", "compile_flags.txt", "compile_commands.json" }

        if vim.fn.has("nvim-0.11") == 1 then
            vim.lsp.config.clangd = {
                cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
                capabilities = capabilities,
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                root_markers = root_files,
            }
            vim.lsp.config.jdtls = { 
                capabilities = capabilities,
                root_markers = { "pom.xml", "gradle.build", ".git" },
            }
            vim.lsp.enable("clangd")
            vim.lsp.enable("jdtls")
        else
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup({
                cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
                capabilities = capabilities,
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                root_dir = lspconfig.util.root_pattern(unpack(root_files)),
            })
            lspconfig.jdtls.setup({ 
                capabilities = capabilities,
                root_dir = lspconfig.util.root_pattern("pom.xml", "gradle.build", ".git"),
            })
        end
    end
}
