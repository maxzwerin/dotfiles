local utils = require("utils")

vim.g.mapleader = " "

local deprecate = vim.deprecate
vim.deprecate = function() end

require("options")
require("lazynvim")
require("keymaps")

vim.cmd.colorscheme("vague")
vim.o.termguicolors = true

utils.fix_telescope_parens_win()

local statusline = {
  '%t',
  '%r',
  '%m',
  '%=',
  '%{&filetype}',
  ' %2p%%',
  ' %3l:%-2c '
}

vim.o.statusline = table.concat(statusline, '')
vim.cmd(":hi statusline guibg=NONE") -- remove background color from statusline

vim.schedule(function()
  vim.deprecate = deprecate
end)

