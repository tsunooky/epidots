return {
    "williamboman/mason.nvim",
    config = function()
        -- Setup Mason for LSP management
        require("mason").setup()
    end,
}
