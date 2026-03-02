return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("neogen").setup({
            enabled = true,
            languages = {
                c = {
                    template = {
                        annotation_convention = "doxygen"
                    }
                },
                cpp = {
                    template = {
                        annotation_convention = "doxygen"
                    }
                }
            }
        })

        vim.keymap.set("n", "<leader>df", ":lua require('neogen').generate()<CR>", { silent = true })
    end,
}
