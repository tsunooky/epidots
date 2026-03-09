return {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
        -- Setup blue wave animation for current scope
        require("mini.indentscope").setup({
            symbol = "▏",
            options = { try_as_border = true },
        })
    end,
}
