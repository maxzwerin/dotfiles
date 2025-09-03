-- SETTINGS --
vim.cmd([[set mouse=]])           -- disable mouse support entirely
vim.cmd([[set noswapfile]])       -- disable .swp files from fucking shit up
vim.opt.winborder = "rounded"     -- rounded borders for floating windows
vim.opt.hlsearch = false          -- dont highlight search matches by default
vim.opt.tabstop = 4               -- number of spaces that <Tab> counts for
vim.opt.cursorcolumn = false      -- disable highlighting of cursor column
vim.opt.ignorecase = true         -- case-insensitive search unless capital letter is used
vim.opt.shiftwidth = 4            -- number of spaces for each level of indentation
vim.opt.smartindent = true        -- "smart" auto indentation
vim.opt.expandtab = true          -- convert <Tab> into spaces
vim.opt.number = true             -- show absolute line number
vim.opt.relativenumber = true     -- show relative line numbers (from cursor line)
vim.opt.termguicolors = true      -- enable true colors in terminal
vim.opt.undofile = true           -- persistent undo
vim.opt.signcolumn = "yes"        -- always show sign column
vim.opt.clipboard = "unnamedplus" -- allows clipboard sync between clipboard & nvim env


-- KEYMAPS --
local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>o', ':update<CR> :source<CR>')         -- update & source file
map('n', '<leader>w', ':write<CR>')                      -- write
map('n', '<leader>q', ':quit<CR>')                       -- quit
map('n', '<leader>v', ':e $MYVIMRC<CR>')                 -- goto vim init.lua file
map('n', '<leader>z', ':e ~/.config/zsh/.zshrc<CR>')     -- go to .zshrc file
map('n', '<leader>t', ':ToggleTerm direction=float<CR>') -- open terminal

map('n', '<C-d>', '<C-d>zz')                             -- scroll down and center
map('n', '<C-u>', '<C-u>zz')                             -- scroll up and center
map('n', 'n', 'nzzzv')                                   -- centered search
map('n', 'N', 'Nzzzv')                                   -- centered search

map({ 'n', 'v' }, '<leader>c', '1z=')                    -- correct spelling error under cursor


-- PLUGINS --
vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim", tag = "*", config = true }, -- replace with FTerm?
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

-- PLUGIN SETUP --
require "mason".setup()
require("nvim-autopairs").setup {}
require "mini.pick".setup({
    mappings = {
        choose_marked = "<C-G>"
    }
})
require "oil".setup({
    view_options = {
        show_hidden = true, -- show dotfiles by default
    },
})
require "toggleterm".setup()
require "todo-comments".setup()


-- PLUGIN SPECIFIC KEYMAPS --
map('n', '<leader>f', ":Pick files<CR>")                            -- fuzzy file picker
map('n', '<leader>h', ":Pick help<CR>")                             -- fuzzy help search
map('n', '<leader>e', ":Oil<CR>")                                   -- open Oil file explorer

map('n', '<leader>lf', vim.lsp.buf.format)                          -- format buffer with LSP

map('t', '<C-o>', [[<C-\><C-n>:ToggleTerm<CR>]], { silent = true }) -- exit terminal

map("n", "]t", function() require("todo-comments").jump_next() end) -- jump to next TODO commment
map("n", "]t", function() require("todo-comments").jump_prev() end) -- jump to prev TODO commment

-- LSP AUTOCOMPLETE --
vim.lsp.enable({ "lua_ls", "clangd", "markdown" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- LSP DIAGNOSTICS --
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    float = { border = "rounded", focusable = false },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})


-- COLORS --
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE") -- remove background color from statusline


-- SNIPPETS --
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")
map("i", "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })


require "render-markdown".setup({
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    render_modes = { 'n', 'c', 't', },
})
