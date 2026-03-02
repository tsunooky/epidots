return {
    "jbyuki/instant.nvim",
    config = function()
        vim.g.instant_username = os.getenv("USER") or "epita_student"
        
        vim.keymap.set("n", "<leader>is", "<Cmd>InstantStartServer<CR>")
        vim.keymap.set("n", "<leader>ij", ":InstantJoinSession ")
        vim.keymap.set("n", "<leader>iq", "<Cmd>InstantStopSession<CR>")
    end
}
