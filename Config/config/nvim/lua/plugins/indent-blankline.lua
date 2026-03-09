return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        -- Setup fine indent guides
        require("ibl").setup({
            indent = { char = "▏" },
            scope = { enabled = false },
        })
    end,
}
