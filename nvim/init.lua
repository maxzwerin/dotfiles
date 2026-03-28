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
vim.opt.scrolloff = 8             -- scroll down before cursor gets to the bottom
vim.g.netrw_banner = 0            -- remove ugly netrw banner

vim.g.mapleader = " "

vim.pack.add {
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/junegunn/fzf" },
    { src = "https://github.com/junegunn/fzf.vim" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/maxzwerin/vim-mash" },
}

local map = vim.keymap.set
local utils = require "utils"

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

----------------------------------------------------
--> AUTOCOMPLETION
----------------------------------------------------
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

----------------------------------------------------
--> QOL
----------------------------------------------------
require "nvim-autopairs".setup()
require "gitsigns".setup()

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

vim.cmd [[set completeopt+=menuone,noselect,popup]]

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
map({ "n" }, "<leader>e", ":Ex<CR>")                              -- file explorer
map({ "n" }, "<leader>c", "1z=")                                  -- autocorrect word under cursor
map({ "n" }, "<leader>md", ":MarkdownPreview<CR>")                -- markdown preview
map("n", "<leader>mc", utils.pack_clean)                          -- remove unused plugins
map("n", "<leader>d", vim.diagnostic.open_float)                  -- open diagnostics float
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")                   -- switch to current dir

vim.diagnostic.config { virtual_text = true }

map({ "n" }, "<leader>w", "<Cmd>:write<CR>")
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>")
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>")

map({ "n" }, "<C-d>", "<C-d>zz")
map({ "n" }, "<C-u>", "<C-u>zz")
map({ "n" }, "n", "nzzzv")
map({ "n" }, "N", "Nzzzv")

----------------------------------------------------
--> FZF
----------------------------------------------------
map({ "n" }, "<leader>f", ":Files<CR>")
map({ "n" }, "<leader>F", ":Files<Space>")
map({ "n" }, "<leader>h", ":History<CR>")
map({ "n" }, "<leader>b", ":Buffers<CR>")
map({ "n" }, "<leader>g", ":Rg<Space>")
map({ "n" }, "<leader>lg", ":RG<CR>")

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
