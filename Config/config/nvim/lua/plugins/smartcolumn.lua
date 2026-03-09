return {
    "m4xshen/smartcolumn.nvim",
    config = function()
        -- Show column at 80 only when exceeded
        require("smartcolumn").setup({
            colorcolumn = "80",
            disabled_filetypes = { "help", "text", "markdown" },
        })
    end,
}
