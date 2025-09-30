require("nvchad.options")

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.foldmethod = "indent"
o.foldlevelstart = 20

require("diffview").setup()
require("gitsigns").setup()

local ai = require("ai")
ai.setup({
	--provider = "snova",
	--provider = "hyperbolic",
	--provider = "cerebras",
	--provider = "gemini",
	--provider = "mistral",
	-- provider = "anthropic",
	provider = "gigachat",
	--provider = "groq",
	--provider = "cohere",
})

vim.g.python3_host_prog = "./.venv/bin/python"

local enable_providers = {
	"python3_provider",
	-- "node_provider",
	-- and so on
}

for _, plugin in pairs(enable_providers) do
	vim.g["loaded_" .. plugin] = nil
	vim.cmd("runtime " .. plugin)
end

require("pytest").setup()
