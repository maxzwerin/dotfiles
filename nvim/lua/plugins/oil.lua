return {
    'stevearc/oil.nvim',
    opts = {},

    config = function()
        require "oil".setup({
            view_options = {
                show_hidden = true, -- show dotfiles by default
            },
            lsp_file_methods = {
                enabled = true,
                timeout_ms = 1000,
                autosave_changes = true,
            },
            float = {
                max_width = 0.7,
                max_height = 0.6,
                border = "rounded",
            },
        })


        -- vim.api.nvim_create_user_command("Oil", function()
        --   require("oil").toggle_float()
        -- end, {})
    end,

    lazy = false,
}
