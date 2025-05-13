-- DEFAULTS
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local servers = { "html", "cssls" }

-- lsps with default config
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
end

-- typescript
lspconfig["ts_ls"].setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
})

lspconfig.volar.setup({
	-- add filetypes for typescript, javascript and vue
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	init_options = {
		vue = {
			-- disable hybrid mode
			hybridMode = false,
		},
	},
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
})

lspconfig.docker_compose_language_service.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,
})

lspconfig.dockerls.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,

	settings = {
		docker = {
			languageserver = {
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
})
