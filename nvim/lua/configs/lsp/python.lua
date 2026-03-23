local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.lsp.config("ruff", {
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	init_options = {
		settings = {
			["ruff.analytics"] = false,
			["ruff.lint"] = {
				run = "onSave",
				select = {
					"E",
					"F",
					"W",
					"I",
					"N",
					"UP",
					"YTT",
					"ASYNC",
					"C4",
					"T20",
					"PT",
					"Q",
					"RSE",
					"RET",
					"SIM",
					"ARG",
					"P",
					"PGH",
					"PL",
					"TRY",
					"RUF",
					"PERF",
					"FLY",
					"NPY",
				},
				ignore = { "E501", "PLR0913", "PLR2004" },
				fixable = { "I", "F", "UP", "SIM", "RET", "ARG", "P", "PL", "TRY", "RUF", "C4", "PT", "Q" },
				exclude = { ".git", "__pycache__", ".venv", "venv", ".ruff_cache" },
				perFileIgnores = {
					["__init__.py"] = { "F401" },
					["tests/*"] = { "S101", "PLR2004" },
				},
			},
		},
	},
})

vim.lsp.enable({ "ruff", "pyright" })

vim.lsp.config("pyright", {
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = true,
			disableTaggedHints = true,
		},
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = false,
				diagnosticSeverityOverrides = {
					reportMissingTypeStubs = "none",
					reportUnknownMemberType = "none",
					reportUnknownVariableType = "none",
					reportUnknownArgumentType = "none",
					reportReturnType = "information",
					reportPropertyType = "information",
				},
				exclude = { "**/__pycache__", "**/.venv", "**/venv", "**/node_modules" },
			},
		},
	},
})
