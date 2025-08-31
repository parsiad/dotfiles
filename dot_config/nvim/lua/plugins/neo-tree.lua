-- Neovim plugin to manage the file system and other tree like structures

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(arg)
          vim.wo.number = true
          vim.wo.relativenumber = true
        end,
      },
    },
  },
}
