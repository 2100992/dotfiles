local map = vim.keymap.set

map({ "n", "x" }, "<C-a>", function()
	require("opencode").ask("@this: ")
end, { desc = "Ask opencode…" })

map({ "n", "x" }, "<C-x>", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
local POSITIONS = { "right", "left", "top", "bottom", "float" }
local current_position = "right"

local function opencode_toggle()
	require("snacks.terminal").toggle("opencode", {
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

map({ "n", "t" }, "<C-^>", opencode_toggle, { desc = "Toggle opencode" })
map("n", "<leader>op", opencode_pick_position, { desc = "Opencode: set terminal position" })

-- Pseudo-context for local rendering: only `buf`, `cursor`, `range` and the `Context`
-- methods are needed. No server — none of the context builders touch it.
local function render_prompt(prompt, range)
	local Context = require("opencode.context")
	local context = setmetatable({
		buf = vim.api.nvim_get_current_buf(),
		cursor = vim.api.nvim_win_get_cursor(0),
		range = range,
	}, { __index = Context })

	return context:render(prompt).output:plaintext()
end

-- opencode.nvim always targets the most recently updated session, so sending from Neovim
-- can land in a tab you are not looking at. Copy the reference instead and paste it into
-- the TUI yourself, so you can edit it and add a comment before submitting.
_G.opencode_copy_operator = function(kind) ---@param kind "char" | "line" | "block"
	local from = vim.api.nvim_buf_get_mark(0, "[")
	local to = vim.api.nvim_buf_get_mark(0, "]")
	if from[1] > to[1] or (from[1] == to[1] and from[2] > to[2]) then
		from, to = to, from
	end

	local text = render_prompt("@this ", {
		from = { from[1], from[2] },
		to = { to[1], to[2] },
		kind = kind,
	})
	vim.fn.setreg("+", text)

	local terminal = require("snacks.terminal").get("opencode", { create = false })
	if terminal then
		terminal:show():focus()
	end

	vim.notify(text .. "  Ctrl+V in TUI", vim.log.levels.INFO)
end

map({ "n", "x" }, "go", function()
	vim.o.operatorfunc = "v:lua.opencode_copy_operator"
	return "g@"
end, { desc = "Copy opencode range reference", expr = true })
map("n", "goo", function()
	vim.o.operatorfunc = "v:lua.opencode_copy_operator"
	return "g@_"
end, { desc = "Copy opencode line reference", expr = true })
