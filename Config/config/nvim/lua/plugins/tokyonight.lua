return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            transparent = true,
            styles = { sidebars = "transparent", floats = "transparent" },
        })

        -- Set the colorscheme
        vim.cmd([[colorscheme tokyonight]])
        
        -- Set custom blue color for indentscope wave
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#7aa2f7" })
    end,
}
