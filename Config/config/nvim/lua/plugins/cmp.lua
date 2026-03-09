return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Setup autocompletion engine
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            
            -- Disable documentation window
            window = {
                documentation = cmp.config.disable,
            },
            
            -- Limit completion menu to 8 entries
            performance = {
                max_view_entries = 8,
            },
            
            mapping = cmp.mapping.preset.insert({
                -- Navigate down with Tab
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                
                -- Navigate up with Shift-Tab
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                
                -- Confirm selection
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}
