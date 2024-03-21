require("marcelo.remap")
require("marcelo.set")
-- prevents status code 0 on terminal close
-- See: https://github.com/neovim/neovim/issues/14986#issuecomment-902705190
vim.cmd("autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')")
vim.o.splitright = true
vim.o.splitbelow = true
