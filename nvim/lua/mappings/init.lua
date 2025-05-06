require("nvchad.mappings")
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Diffview open" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Diffview close" })
map("i", "jk", "<ESC>")
map("i", "ол", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
require("mappings.dap")
-- require("mappings.codeium")
