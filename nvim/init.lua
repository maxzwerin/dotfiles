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
vim.opt.wrap = false              -- no wrapping please and thank you

vim.diagnostic.config({ virtual_text = true })

vim.g.mapleader = " "

local utils = require "utils"

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",        version = "main" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/LinArcX/telescope-env.nvim" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    -- { src = "https://github.com/hrsh7th/nvim-cmp" },
    -- { src = "https://github.com/hrsh7th/nvim-cmp-lsp" },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'markdown', 'c' },
    callback = function() vim.treesitter.start() end,
})

require "mason".setup()          -- i dislike mason but sometimes its useful
require "nvim-autopairs".setup() -- this will always be useful
require "nvim-highlight-colors".setup()

require "luasnip".setup({ enable_autosnippets = true })
require "luasnip.loaders.from_lua".load({ paths = "~/.config/nvim/snippets/" })

local ls = require "luasnip"

require "nvim-treesitter.config".setup({
    ensure_installed = {
        'lua_ls'
    },
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})

local telescope = require "telescope"
telescope.setup({
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
})
telescope.load_extension("ui-select")

-- get that juicy lsp up and running
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.lsp.enable({ "lua_ls", "clangd", "marksman" })

require "oil".setup({
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },
    view_options = {
        show_hidden = true,
    },
    columns = {
        "icon",
    },
    float = {
        max_width = 0.7,
        max_height = 0.6,
        border = "rounded",
    },
})

require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")

local builtin = require "telescope.builtin"
local map = vim.keymap.set

map({ "n", "t" }, "<Leader>x", "<Cmd>tabclose<CR>")

vim.cmd([[
	nnoremap g= g+| " g=g=g= is less awkward than g+g+g+
	nnoremap gK @='ddkPJ'<cr>| " join lines but reversed. `@=` so [count] works
	xnoremap gK <esc><cmd>keeppatterns '<,'>-global/$/normal! ddpkJ<cr>
	noremap! <c-r><c-d> <c-r>=strftime('%F')<cr>
	noremap! <c-r><c-t> <c-r>=strftime('%T')<cr>
	noremap! <c-r><c-f> <c-r>=expand('%:t')<cr>
	noremap! <c-r><c-p> <c-r>=expand('%:p')<cr>
	xnoremap <expr> . "<esc><cmd>'<,'>normal! ".v:count1.'.<cr>'
]])

map({ "n", "v", "x" }, "<leader>v", "<Cmd>edit $MYVIMRC<CR>", { desc = "Edit " .. vim.fn.expand("$MYVIMRC") })
map({ "n", "v", "x" }, "<leader>z", "<Cmd>e ~/.config/zsh/.zshrc<CR>", { desc = "Edit .zshrc" })
map({ "n", "v", "x" }, "<leader>n", ":norm ", { desc = "ENTER NORM COMMAND." })
map({ "n", "v", "x" }, "<leader>o", "<Cmd>source %<CR>", { desc = "Source " .. vim.fn.expand("$MYVIMRC") })
map({ "n", "v", "x" }, "<leader>O", "<Cmd>restart<CR>", { desc = "Restart vim." })
map({ "n", "v", "x" }, "<C-s>", [[:%s]], { desc = "Enter substitue mode in selection" })
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })
map({ "n" }, "<leader>f", builtin.find_files, { desc = "Telescope find files" })
-- luasnip binds
map({ "i", "s" }, "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

local function git_files() builtin.find_files({ no_ignore = true }) end
local function grep() builtin.live_grep() end

map("n", "<leader>mc", utils.pack_clean)

-- diagnostics float view
map("n", "<leader>d", vim.diagnostic.open_float)

-- hella telescope functions
map({ "n" }, "<leader>g", grep)
map({ "n" }, "<leader>sg", git_files)
map({ "n" }, "<leader>sb", builtin.buffers)
map({ "n" }, "<leader>si", builtin.grep_string)
map({ "n" }, "<leader>so", builtin.oldfiles)
map({ "n" }, "<leader>sh", builtin.help_tags)
map({ "n" }, "<leader>sm", builtin.man_pages)
map({ "n" }, "<leader>sr", builtin.lsp_references)
map({ "n" }, "<leader>sd", builtin.diagnostics)
map({ "n" }, "<leader>st", builtin.builtin)
map({ "n" }, "<leader>sc", builtin.git_bcommits)
map({ "n" }, "<leader>sk", builtin.keymaps)
map({ "n" }, "<leader>se", "<cmd>Telescope env<cr>")

map({ "n" }, "<leader>e", "<cmd>Oil<CR>")
map({ "n" }, "<leader>c", "1z=", { desc = "Autocorrect word under cursor" })

map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer" })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })

map({ "n" }, "<leader>md", ":MarkdownPreview<CR>")

--- TMUX ---
map({ "n" }, "<c-h>", ":wincmd h<CR>")
map({ "n" }, "<c-j>", ":wincmd j<CR>")
map({ "n" }, "<c-k>", ":wincmd k<CR>")
map({ "n" }, "<c-l>", ":wincmd l<CR>")

map({ "n" }, "<C-h>", ":TmuxNavigateLeft<CR>")
map({ "n" }, "<C-j>", ":TmuxNavigateDown<CR>")
map({ "n" }, "<C-k>", ":TmuxNavigateUp<CR>")
map({ "n" }, "<C-l>", ":TmuxNavigateRight<CR>")

-- !!! macOS only !!!
-- map({ "n" }, "<C-f>", "<Cmd>Open .<CR>", { desc = "Open current directory in Finder." })

--- MOVEMENT COMMANDS ---
map({ "n" }, "<C-d>", "<C-d>zz")
map({ "n" }, "<C-u>", "<C-u>zz")
map({ "n" }, "n", "nzzzv")
map({ "n" }, "N", "Nzzzv")

--- EXTUI - EXPERIMENTAL ---
require "vim._extui".enable({
    enable = true, -- Whether to enable or disable the UI
    msg = {        -- Options related to the message module
        ---@type 'cmd'|'msg' Where to place regular messages, either in the
        ---cmdline or in a separate ephemeral message window
        target = 'cmd',
        timeout = 4000, -- Time a message is visible in the message window.
    },
})

--- SIMPLE STATUS LINE ---
local statusline = { '%t', '%r', '%m', '%=', '%{&filetype}', ' %2p%%', ' %3l:%-2c ' }
vim.o.statusline = table.concat(statusline, '')

local mash = require("mash")
map({ "n" }, "<leader>m", mash.jump)
