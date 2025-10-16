return {
    "maxzwerin/mash.nvim",

    vim.keymap.set({ "n", "x", "o" }, "<leader>s", function()
        require("mash").jump()
    end)
}
