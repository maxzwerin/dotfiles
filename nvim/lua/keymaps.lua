local map = vim.keymap.set
local MiniPick = require("mini.pick")

map('n', '<leader>o', ':update<CR> :source<CR>')         -- update & source file
map('n', '<leader>w', ':write<CR>')                      -- write
map('n', '<leader>q', ':quit<CR>')                       -- quit
map('n', '<leader>v', ':e $MYVIMRC<CR>')                 -- goto vim init.lua file
map('n', '<leader>z', ':e ~/.config/zsh/.zshrc<CR>')     -- go to zshrc file
map('n', '<leader>t', ':ToggleTerm direction=float<CR>') -- open terminal

map('n', '<C-d>', '<C-d>zz')                             -- scroll down and center
map("n", "<C-f>", "<C-f>zz")                             -- scroll down and center
map('n', '<C-u>', '<C-u>zz')                             -- scroll up and center
map("n", "<C-b>", "<C-b>zz")                             -- scroll up and center
map('n', 'n', 'nzzzv')                                   -- centered search
map('n', 'N', 'Nzzzv')                                   -- centered search

map({ 'n', 'v' }, '<leader>c', '1z=')                    -- correct spelling error under cursor

map('n', '<leader>g', MiniPick.builtin.grep_live)        -- fuzzy file picker
map('n', '<leader>f', MiniPick.builtin.files)            -- fuzzy file picker
map('n', '<leader>e', ":Oil<CR>")                        -- open Oil file explorer

-- map("n", "<leader>E", "<CMD>lua require('oil').open_float('.')<CR>", { noremap = true, silent = true })

map("n", "<leader>ll", ":setlocal spell spelllang=en_us<CR>") -- spellcheck
map("n", "<leader>lf", function()                             -- formatting
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })

map("n", "Y", "yy")

-- what do all these mean:
-- move selections
map("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
map("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up
map("n", "<leader>t", "bv~")

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- see error
map("n", "<leader>d", vim.diagnostic.open_float)

-- lsp setup
map("n", "K", vim.lsp.buf.hover)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gr", function()
    -- Trigger the LSP references function and populate the quickfix list
    vim.lsp.buf.references()

    vim.defer_fn(function()
        -- Set up an autocmd to remap keys in the quickfix window
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "qf", -- Only apply this mapping in quickfix windows
            callback = function()
                -- Remap <Enter> to jump to the location and close the quickfix window
                vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>:cclose<CR>", { noremap = true, silent = true })
                vim.api.nvim_buf_set_keymap(0, "n", "q", ":cclose<CR>", { noremap = true, silent = true })

                -- Set up <Tab> to cycle through quickfix list entries
                map("n", "<Tab>", function()
                    local current_idx = vim.fn.getqflist({ idx = 0 }).idx
                    local qflist = vim.fn.getqflist() -- Get the current quickfix list
                    if current_idx >= #qflist then
                        vim.cmd("cfirst")
                        vim.cmd("wincmd p")
                    else
                        vim.cmd("cnext")
                        vim.cmd("wincmd p")
                    end
                end, { noremap = true, silent = true, buffer = 0 })

                map("n", "<S-Tab>", function()
                    local current_idx = vim.fn.getqflist({ idx = 0 }).idx
                    if current_idx < 2 then
                        vim.cmd("clast")
                        vim.cmd("wincmd p")
                    else
                        vim.cmd("cprev")
                        vim.cmd("wincmd p")
                    end
                end, { noremap = true, silent = true, buffer = 0 })
            end,
        })
    end, 0)
end)


