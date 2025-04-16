-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
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
M.base46 = {
	theme = "ayu_dark",
	theme_toggle = { "ayu_dark", "ayu_light" },

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
