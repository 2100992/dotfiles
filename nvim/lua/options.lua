require("nvchad.options")

-- add yours here!

local o = vim.o
o.cursorlineopt = "both"
o.foldmethod = "indent"
o.foldlevelstart = 20
o.autoread = true

require("diffview").setup()
require("gitsigns").setup()

vim.g.python3_host_prog = "./.venv/bin/python"
