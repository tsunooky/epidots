-- Save file
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })

-- Save and quit
vim.keymap.set("n", "<C-x>", "<cmd>wq<CR>", { desc = "Save and quit" })

-- Quit without saving
vim.keymap.set("n", "<C-q>", "<cmd>q!<CR>", { desc = "Quit without saving" })

-- Tab navigation
vim.keymap.set("n", "+", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", ">", "<cmd>tabnext<CR>", { desc = "Next tab" })

-- Toggle neo-tree
vim.keymap.set("n", "<C-t>", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })

-- Go back in jump list
vim.keymap.set("n", "gb", "<C-o>", { desc = "Go back" })

-- Diagnostics (Erreurs)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error details" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous error" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next error" })

-- Toggle comment on current line (Normal mode)
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })

-- Toggle comment on selected block (Visual mode)
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
