-- defaults
require("nvchad.configs.lspconfig").defaults()

-- lsps with default config
local on_attach = require("nvchad.configs.lspconfig").on_attach

local servers = { "html", "cssls", "docker_compose_language_service", "yamlls" }

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		on_attach = on_attach,
	})
end

vim.lsp.enable(servers)

require("configs.lsp.vue")
require("configs.lsp.python")
