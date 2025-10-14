return {
    "abecodes/tabout.nvim",
    event = "InsertCharPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("tabout").setup({
            tabkey = "<Tab>",       -- key to trigger tabout
            completion = false,     -- no nvim-cmp
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
                { open = "<", close = ">" },
            },
        })
    end,
}
