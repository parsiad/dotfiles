-- A fancy, configurable, notification manager for NeoVim

return {
  {
    "rcarriga/nvim-notify",
    opts = {
      level = 4,
      render = "minimal",
      stages = "static",
      timeout = 10000,
    },
  },
}
