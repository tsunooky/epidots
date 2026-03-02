vim.keymap.set({"n", "i", "v"}, "<C-s>", "<Cmd>write<CR>")
vim.keymap.set({"n", "i", "v"}, "<C-x>", "<Cmd>x<CR>")
vim.keymap.set({"n", "i", "v"}, "<C-q>", "<Cmd>q!<CR>")

vim.keymap.set("n", "+", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "<", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", ">", "<Cmd>tabnext<CR>")
