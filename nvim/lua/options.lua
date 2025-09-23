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
