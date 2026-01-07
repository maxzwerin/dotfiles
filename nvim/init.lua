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

vim.g.mapleader = " "

local utils = require "utils"

local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
    { src = gh("vague2k/vague.nvim") },
    { src = gh("stevearc/oil.nvim") },
    { src = gh("nvim-tree/nvim-web-devicons") },
    { src = gh("nvim-treesitter/nvim-treesitter"),        version = "main" },
    { src = gh("nvim-telescope/telescope.nvim") },
    { src = gh("nvim-telescope/telescope-ui-select.nvim") },
    { src = gh("nvim-lua/plenary.nvim") },
    { src = gh("neovim/nvim-lspconfig") },
    { src = gh("LinArcX/telescope-env.nvim") },
    { src = gh("iamcco/markdown-preview.nvim") },
    { src = gh("L3MON4D3/LuaSnip") },
    { src = gh("windwp/nvim-autopairs") },
    { src = gh("brenoprata10/nvim-highlight-colors") },
    { src = gh("christoomey/vim-tmux-navigator") },
    { src = gh("maxzwerin/mash.nvim") },
})


--- TREESITTER ---
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'markdown', 'c', 'python' },
    callback = function()
        local ok, _ = pcall(vim.treesitter.start)
        if not ok then
            print("treesitter parser missing for this filetype")
        end
    end,
})


--- REQUIRE ALL ---
require "nvim-autopairs".setup()
require "nvim-highlight-colors".setup()

require "luasnip".setup({ enable_autosnippets = true })
require "luasnip.loaders.from_lua".load({ paths = "~/.config/nvim/snippets/" })

local ls = require "luasnip"

require "nvim-treesitter.config".setup({
    ensure_installed = { 'lua_ls', 'c', 'bash', 'json', 'markdown', 'python' },
    auto_install = true,
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


--- LSP FUNCTIONS ---
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function() end,
})

local lspignore = { "oil", "zshrc", "json", "python" }

vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("lsp-missing", { clear = true }),
    callback = function(args)
        vim.defer_fn(function()
            print("")
            local clients = vim.lsp.get_clients({ bufnr = args.buf })
            if #clients > 0 then return end

            local ft = vim.bo[args.buf].filetype
            for _, v in ipairs(lspignore) do
                if (ft == v) then return end
            end

            local name = vim.api.nvim_buf_get_name(args.buf)
            if name == "" then return end

            print(("missing lsp: [ %s ] %s"):format(ft, name))
        end, 150)
    end,
})


vim.lsp.enable({ "lua_ls", "clangd", "pyright" })


vim.cmd [[set completeopt+=menuone,noselect,popup]] -- completion menu behavior


require "oil".setup({
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

local mash = require("mash")
mash.setup()
map({ "n" }, "<leader>/", mash.jump)

vim.diagnostic.config({ virtual_text = true })


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


--- KEYBINDS ---
map({ "n", "t" }, "<leader>t", "<Cmd>tabnew<CR>")
map({ "n", "t" }, "<leader>x", "<Cmd>tabclose<CR>")

map({ "n", "v", "x" }, "<leader>v", "<Cmd>edit $MYVIMRC<CR>")          -- nvim config
map({ "n", "v", "x" }, "<leader>z", "<Cmd>e ~/.config/zsh/.zshrc<CR>") -- .zshrc
map({ "n", "v", "x" }, "<leader>n", ":norm ")                          -- norm command
map({ "n", "v", "x" }, "<leader>o", "<Cmd>source %<CR>")               -- source init.lua
map({ "n", "v", "x" }, "<leader>O", "<Cmd>restart<CR>")                -- restart nvim
map({ "n", "v", "x" }, "<leader>R", ":lua vim.pack.update()<CR>")      -- update packages
map({ "n", "v", "x" }, "<C-s>", [[:%s]])                               -- enter substitution mode in selection
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format)               -- format current buffer

map({ "n" }, "<leader>e", "<cmd>Oil<CR>")
map({ "n" }, "<leader>c", "1z=", { desc = "Autocorrect word under cursor" })
map({ "n" }, "<leader>md", ":MarkdownPreview<CR>")

map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer" })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })

map({ "i", "s" }, "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

map("n", "<leader>mc", utils.pack_clean)

map("n", "<leader>d", vim.diagnostic.open_float)

map({ "n" }, "<C-d>", "<C-d>zz")
map({ "n" }, "<C-u>", "<C-u>zz")
map({ "n" }, "n", "nzzzv")
map({ "n" }, "N", "Nzzzv")

-- !!! macOS only !!!
-- map({ "n" }, "<C-f>", "<Cmd>Open .<CR>", { desc = "Open current directory in Finder." })


--- TELESCOPE FUNCTIONS ---
local function git_files() builtin.find_files({ no_ignore = true }) end
local function grep() builtin.live_grep() end

map({ "n" }, "<leader>f", builtin.find_files, { desc = "Telescope find files" })
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


--- TMUX ---
map({ "n" }, "<c-h>", ":wincmd h<CR>")
map({ "n" }, "<c-j>", ":wincmd j<CR>")
map({ "n" }, "<c-k>", ":wincmd k<CR>")
map({ "n" }, "<c-l>", ":wincmd l<CR>")

map({ "n" }, "<C-h>", ":TmuxNavigateLeft<CR>")
map({ "n" }, "<C-j>", ":TmuxNavigateDown<CR>")
map({ "n" }, "<C-k>", ":TmuxNavigateUp<CR>")
map({ "n" }, "<C-l>", ":TmuxNavigateRight<CR>")


--- EXTUI - EXPERIMENTAL ---
require "vim._extui".enable({
    enable = true,
    msg = {
        target = 'cmd',
        timeout = 4000,
    },
})


--- SIMPLE STATUS LINE ---
local statusline = { '%t', '%r', '%m', '%=', '%{&filetype}', ' %2p%%', ' %3l:%-2c ' }
vim.o.statusline = table.concat(statusline, '')


