vim.g.mapleader = " "
vim.g.termguicolors = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.wrap = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.o.list = true
vim.o.path = "**"

vim.o.clipboard = "unnamedplus"
vim.o.signcolumn = "yes"
vim.o.scrolloff = 8
vim.g.netrw_banner = 0

vim.o.autocomplete = true
vim.o.winborder = "rounded"

vim.cmd(":colorscheme retrobox")
vim.cmd(":command! -nargs=+ Grep execute 'silent grep! <args>' | copen")

local map = vim.keymap.set
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>t", ":below term<CR>i")
map("t", "<ESC>", "<C-\\><C-n>")

map("n", "<leader>w", "<Cmd>:write<CR>")
map("n", "<leader>q", "<Cmd>:quit<CR>")
map("n", "<leader>Q", "<Cmd>:quit!<CR>")
map("n", "<leader>e", ":Ex<CR>")
map("n", "<leader>v", ":edit $MYVIMRC<CR>")
map("n", "<leader>O", ":update<CR> :source<CR>")

map("n", "<leader>f", ":find ")
map("n", "<leader>g", ":Grep ")

map("n", "<leader>r", ":make!<CR>")
map("n", "<leader>R", ":set makeprg=")
map("n", "<leader>o", ":copen<CR>")
map("n", "<leader>x", ":cclose<CR>")
map("n", "<leader>c", ":!ctags -R .<CR>")

map("n", "<leader>d", vim.diagnostic.open_float)

vim.treesitter.language.register("c", "h")
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "h", "lua" },
    callback = function() vim.treesitter.start() end,
})

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' }
})

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    settings = { Lua = { diagnostics = {globals = {'vim'}}}}
})

vim.lsp.enable { "lua_ls", "clangd" }
vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect' }


