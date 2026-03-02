return {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#7aa2f7" })
        
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#7aa2f7" })
            end,
        })

        require("mini.indentscope").setup({
            symbol = "▏",
            options = { try_as_border = true },
            draw = {
                delay = 50,
                animation = require("mini.indentscope").gen_animation.quadratic({
                    easing = "in-out",
                    duration = 15,
                    unit = "step",
                }),
            },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "neo-tree", "lazy", "mason" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end
}
