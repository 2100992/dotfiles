-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "onenord",
	theme_toggle = { "onenord", "onenord" },

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
	statusline = {
		theme = "vscode_colored",
		-- theme = "minimal",
		-- theme = "default",
		-- modules = {
		-- 	-- The default cursor module is override
		-- 	cursor = function()
		-- 		return "%#BruhHl#" .. " bruh " -- the highlight group here is BruhHl,
		-- 	end,
		-- },
		-- separator_style = "arrow",
	},
}

return M
