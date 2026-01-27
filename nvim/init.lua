----------------------------------------------------
--> ESSENTIALS
----------------------------------------------------
vim.cmd [[set mouse=]]            -- disable mouse support entirely
vim.cmd [[set noswapfile]]        -- disable .swp files from fucking shit up
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
vim.opt.wrap = false              -- no wrapping please and thank you

vim.g.mapleader = " "

vim.pack.add {
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/LinArcX/telescope-env.nvim" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/maxzwerin/mash.nvim" },
}

local map = vim.keymap.set
local utils = require "utils"

local mash = require "mash"
mash.setup()
map({ "n" }, "<leader>jk", mash.jump)

----------------------------------------------------
--> LSP / TREESITTER / COLORS
----------------------------------------------------
require "nvim-highlight-colors".setup()

-- check with :checkhealth nvim-treesitter
require "nvim-treesitter".install { "c", "lua", "vim" }

require "mason".setup()

-- check with :checkhealth vim.lsp
vim.lsp.enable { "lua_ls", "clangd", "rust_analyzer", "pyright" }

require "vague".setup { transparent = true }
vim.cmd "colorscheme vague"
vim.cmd [[set completeopt+=menuone,noselect,popup]]

----------------------------------------------------
--> OTHER
----------------------------------------------------
require "nvim-autopairs".setup()
require "gitsigns".setup()

require "oil".setup {
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-r>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    use_default_keymaps = false,
    view_options = { show_hidden = true, },
    columns = { "icon", },
    float = {
        max_width = 0.7,
        max_height = 0.6,
        border = "rounded",
    },
}

vim.cmd [[
	nnoremap g= g+| " g=g=g= is less awkward than g+g+g+
	nnoremap gK @='ddkPJ'<cr>| " join lines but reversed. `@=` so [count] works
	xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
	noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
	noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
	noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
	noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
	xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
]]

----------------------------------------------------
--> KEYBINDS
----------------------------------------------------
map({ "n", "t" }, "<leader>t", "<Cmd>tabnew<CR>")
map({ "n", "t" }, "<leader>x", "<Cmd>tabclose<CR>")

map({ "n", "v", "x" }, "<leader>v", "<Cmd>edit $MYVIMRC<CR>")     -- nvim config
map({ "n", "v", "x" }, "<leader>z", "<Cmd>edit ~/.zshrc<CR>")     -- zshrc config
map({ "n", "v", "x" }, "<leader>n", ":norm ")                     -- norm command
map({ "n", "v", "x" }, "<leader>o", ":update<CR> :source<CR>")    -- source
map({ "n", "v", "x" }, "<leader>O", "<Cmd>restart<CR>")           -- restart
map({ "n", "v", "x" }, "<leader>R", ":lua vim.pack.update()<CR>") -- update packages
map({ "n", "v", "x" }, "<C-s>", [[:%s]])                          -- enter substitution mode in selection
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format)          -- format current buffer
map({ "n" }, "<leader>e", "<cmd>Oil<CR>")                         -- file explorer
map({ "n" }, "<leader>c", "1z=")                                  -- autocorrect word under cursor
map({ "n" }, "<leader>md", ":MarkdownPreview<CR>")                -- markdown preview
map("n", "<leader>mc", utils.pack_clean)                          -- remove unused plugins
map("n", "<leader>d", vim.diagnostic.open_float)                  -- open diagnostics float

vim.diagnostic.config { virtual_text = true }

map({ "n" }, "<leader>w", "<Cmd>:write<CR>")
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>")
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>")

map({ "n" }, "<C-d>", "<C-d>zz")
map({ "n" }, "<C-u>", "<C-u>zz")
map({ "n" }, "n", "nzzzv")
map({ "n" }, "N", "Nzzzv")

----------------------------------------------------
--> TELESCOPE
----------------------------------------------------
local telescope = require "telescope"
local builtin = require "telescope.builtin"
telescope.setup {
    defaults = {
        preview = { treesitter = false },
        color_devicons = false,
        sorting_strategy = "ascending",
        borderchars = { "", "", "", "", "", "", "", "", },
        path_displays = { "smart" },
        layout_config = {
            height = 100,
            width = 300,
            prompt_position = "top",
            preview_cutoff = 40,
        }
    }
}

telescope.load_extension "ui-select"

local function git_files() builtin.find_files({ no_ignore = true }) end
local function grep() builtin.live_grep() end

map({ "n" }, "<leader>ff", builtin.find_files)
map({ "n" }, "<leader>fg", grep)
map({ "n" }, "<leader>sg", git_files)
map({ "n" }, "<leader>sb", builtin.buffers)
map({ "n" }, "<leader>so", builtin.oldfiles)
map({ "n" }, "<leader>sr", builtin.lsp_references)
map({ "n" }, "<leader>sd", builtin.diagnostics)
map({ "n" }, "<leader>sc", builtin.git_bcommits)
map({ "n" }, "<leader>sk", builtin.keymaps)

----------------------------------------------------
--> TMUX INTEGRATION
----------------------------------------------------
map({ "n" }, "<c-h>", ":wincmd h<CR>")
map({ "n" }, "<c-j>", ":wincmd j<CR>")
map({ "n" }, "<c-k>", ":wincmd k<CR>")
map({ "n" }, "<c-l>", ":wincmd l<CR>")

map({ "n" }, "<C-h>", ":TmuxNavigateLeft<CR>")
map({ "n" }, "<C-j>", ":TmuxNavigateDown<CR>")
map({ "n" }, "<C-k>", ":TmuxNavigateUp<CR>")
map({ "n" }, "<C-l>", ":TmuxNavigateRight<CR>")

----------------------------------------------------
--> SIMPLE STATUS LINE
----------------------------------------------------
local statusline = { '%t', '%r', '%m', '%=', '%{&filetype}', ' %2p%%', ' %3l:%-2c ' }
vim.o.statusline = table.concat(statusline, '')
