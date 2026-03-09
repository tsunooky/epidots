return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
        -- Setup transparency for all UI elements
        require("transparent").setup({
            extra_groups = { 
                "NeoTreeNormal", 
                "NeoTreeNormalNC",
                "MiniIndentscopeSymbol"
            },
        })
    end,
}
