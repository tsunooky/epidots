return {
    "stevearc/conform.nvim",
    config = function()
        -- Setup formatters
        require("conform").setup({
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                cmake = { "cmake_format" },
                sh = { "shfmt" },
            },
            formatters = {
                ["clang-format"] = {
                    args = function(_, ctx)
                        local name = ctx.filename
                        if vim.bo[ctx.buf].filetype == "c" then
                            name = vim.fn.fnamemodify(name, ":r") .. ".c"
                        end
                        return { "-assume-filename", name }
                    end,
                },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end,
}
