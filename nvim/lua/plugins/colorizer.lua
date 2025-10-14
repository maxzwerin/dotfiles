return {
  {
    "norcalli/nvim-colorizer.lua",
    enabled = true,
    config = function()
        require("colorizer").setup()
    end,
    opts = {
      user_default_options = {
        mode = "background",
        names = false,
      },
    },
  },
}
