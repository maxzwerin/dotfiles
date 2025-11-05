return {
    "maxzwerin/todo.nvim",

    require("todo").setup({ target_file = "~/notes/todo.md" }),
    vim.keymap.set("n", "<leader>td", ":Td<CR>", { silent = true })
}
