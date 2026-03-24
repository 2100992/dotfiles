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

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "docker-compose.*.yaml",
    "docker-compose.*.yml",
    "compose.yaml",
    "compose.yml",
    "compose.*.yaml",
    "compose.*.yml",
  },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})
