local map = vim.keymap.set

map({ "n", "x" }, "<C-a>", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })

map({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
local POSITIONS = { "right", "left", "top", "bottom", "float" }
local current_position = "right"

local function opencode_toggle()
	require("snacks.terminal").toggle("opencode --port", {
		win = { position = current_position, enter = false },
	})
end

local function opencode_pick_position()
	vim.ui.select(POSITIONS, { prompt = "Opencode terminal position" }, function(choice)
		if not choice then
			return
		end
		current_position = choice
		vim.notify("Opencode terminal position: " .. choice)
	end)
end

map({ "n", "t" }, "<leader>o", opencode_toggle, { desc = "Toggle opencode" })
map("n", "<leader>op", opencode_pick_position, { desc = "Opencode: set terminal position" })

map({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
map("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

map("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
map("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })

-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap).
map("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
map("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
