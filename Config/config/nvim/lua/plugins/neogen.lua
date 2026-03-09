return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        -- Setup Doxygen generator
        require("neogen").setup({
            snippet_engine = "luasnip"
        })
        
        -- Keymap for Doxygen generation
        vim.keymap.set("n", "<leader>df", ":Neogen<CR>", { desc = "Generate Doxygen" })
    end,
}
