require("nvchad.mappings")
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>do", "<cmd>DiffviewOpen<CR>", { desc = "Diffview open" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Diffview close" })
map("i", "jk", "<ESC>")
map("i", "олол", "<ESC>")

map("n", "K", function()
	vim.lsp.buf.hover({ border = "single", max_height = 25, max_width = 120 })
end, { desc = "Hover documentation" })

map("n", "<leader>gnh", "<cmd>Gitsigns next_hunk<CR>", { desc = "next_hunk" })
map("n", "<leader>gph", "<cmd>Gitsigns prev_hunk<CR>", { desc = "prev_hunk" })
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<CR>", { desc = "prev_hunk" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
require("mappings.dap")
-- require("mappings.codeium")
