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

vim.g.netrw_banner = 0
vim.o.scrolloff = 8
vim.o.clipboard = "unnamedplus"
vim.o.winborder = "rounded"

vim.cmd(":colorscheme retrobox")
vim.cmd(":command! -nargs=+ Grep execute 'silent grep! <args>' | copen")

-- vim.treesitter.language.register("cpp", "c")
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "h", "lua" },
    callback = function() vim.treesitter.start() end,
})

vim.lsp.enable { "lua_ls", "clangd" }

local map = vim.keymap.set
-- window split binds (build in)
-- <C-w>s for horiz
-- <C-w>v for vert
-- <C-w>n for new file
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

map({ "n" }, "<C-d>", "<C-d>zz")
map({ "n" }, "<C-u>", "<C-u>zz")

map({ "n" }, "n", "nzzzv")
map({ "n" }, "N", "Nzzzv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<A-h>", ":below term<CR>i")
map("t", "<ESC>", "<C-\\><C-n>")

map({ "n" }, "<leader>w", "<Cmd>:write<CR>")
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>")
map({ "n" }, "<leader>Q", "<Cmd>:quit!<CR>")
map({ "n" }, "<leader>e", ":Ex<CR>")
map({ "n", "v", "x" }, "<leader>v", ":edit $MYVIMRC<CR>")
map({ "n", "v", "x" }, "<leader>z", ":edit ~/.zshrc<CR>")
map({ "n", "v", "x" }, "<leader>o", ":update<CR> :source<CR>")

map("n", "<leader>f", ":find ")
map("n", "<leader>g", ":Grep ")

map("n", "<leader>r", ":make!<CR>")
map("n", "<leader>R", ":set makeprg=")
map("n", "<leader>x", ":copen<CR>")
map("n", "<leader>c", ":!ctags -R .<CR>")
