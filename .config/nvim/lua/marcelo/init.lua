require("marcelo.remap")
require("marcelo.set")
-- prevents status code 0 on terminal close
-- expand('<abuf>') avoids from sending a bdelete to an unrelated buffer currently 
-- focused at the moment of the TermClose and instead target the actual buffer that triggered the TermClose.
-- See: https://github.com/neovim/neovim/issues/14986#issuecomment-902705190
vim.cmd("autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')")
