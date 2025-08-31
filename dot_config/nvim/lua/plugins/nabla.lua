-- take your scientific notes ✏️ in Neovim

-- Requires LaTeX parser: install with `:TSInstall latex`.

return {
  "jbyuki/nabla.nvim",
  event = "VeryLazy",
  -- https://github.com/jbyuki/nabla.nvim/issues/91
  -- config = function()
  --   if vim.bo.filetype == "markdown" then
  --     require("nabla").enable_virt({ autogen = true })
  --   end
  -- end,
  keys = function()
    return {
      {
        "<leader>p",
        ':lua require("nabla").popup()<cr>',
        desc = "NablaPopUp",
      },
    }
  end,
}
