return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
              ".git",
              ".cache"
          },
        },
        follow_current_file = { enabled = true },
      },
    })
    
    vim.keymap.set('n', '<C-t>', ':Neotree toggle<CR>', { silent = true })
  end
}
