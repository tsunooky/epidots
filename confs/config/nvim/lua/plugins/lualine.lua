return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Setup elegant statusline
        require("lualine").setup({
            options = {
                theme = "tokyonight",
                component_separators = "|",
                section_separators = "",
            },
        })
    end,
}
