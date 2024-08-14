require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")

map("i", "<D-]>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })

map("i", "<D-[>", function()
	return vim.fn["codium#Clear"]()
end, { expr = true, silent = true })

map("i", "<D-'>", function()
	return vim.fn["codium#CycleCompletions"](1)
end, { expr = true, silent = true })

map("i", "<D-;>", function()
	return vim.fn["codium#CycleCompletions"](-1)
end, { expr = true, silent = true })
