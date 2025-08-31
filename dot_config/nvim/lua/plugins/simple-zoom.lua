-- A simple plugin to add a Tmux-like zoom functionality to Neovim

return {
  "fasterius/simple-zoom.nvim",
  opts = {
    hide_tabline = true,
  },
  keys = function()
    return {
      {
        "<leader>z",
        ":SimpleZoomToggle<CR>",
        desc = "Toggle zoom on a single pane",
      },
    }
  end,
}
