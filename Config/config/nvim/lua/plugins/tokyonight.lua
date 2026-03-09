return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Set the colorscheme
        vim.cmd([[colorscheme tokyonight]])
        
        -- Set custom blue color for indentscope wave
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#7aa2f7" })
    end,
}
