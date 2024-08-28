require("nvchad.mappings")

-- disable default codeium bindings
vim.g.codeium_disable_bindings = 1

local map = vim.keymap.set

-- map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")

map("i", "<C-enter>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

map("i", "<D-[>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

map("i", "<M-]>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })

map("i", "<M-[>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })

map("i", "<M-l>", function()
	return vim.fn["codeium#AcceptNextWord"]
end, { expr = true, silent = true })

map("i", "<M-k>", function()
	return vim.fn["codeium#AcceptNextLine"]
end, { expr = true, silent = true })
