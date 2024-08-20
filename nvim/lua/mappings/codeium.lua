require("nvchad.mappings")

-- disable default codeium bindings
vim.g.codeium_disable_bindings = 1

local map = vim.keymap.set

-- map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")

map("i", "<D-]>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

map("i", "<D-right>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

map("i", "<M-right>", function()
	return vim.fn["codeium#Complete"]()
end, { expr = true, silent = true })

map("i", "<D-[>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

map("i", "<D-left>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

map("i", "<D-'>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })

map("i", "<D-Up>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })
map("i", "<D-;>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })

map("i", "<D-Down>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })
