return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.pick").setup()
      require("mini.ai").setup()
    end,
  },
}
