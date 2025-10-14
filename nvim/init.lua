local utils = require("utils")

require("options")
require("keymaps")
require("lazynvim")

vim.cmd.colorscheme("vague")
vim.cmd(":hi statusline guibg=NONE") -- remove background color from statusline
vim.o.termguicolors = true

utils.fix_telescope_parens_win()

vim.o.statusline = [[%<%f %h%m%r %y%=%{v:register} %-14.(%l,%c%V%) %p]]
