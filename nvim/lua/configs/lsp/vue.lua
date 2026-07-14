local on_attach = require("nvchad.configs.lspconfig").on_attach

local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

vim.lsp.config("vtsls", {
	on_attach = on_attach,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
})

vim.lsp.config("volar", {
	on_attach = on_attach,
	filetypes = { "vue" },
	settings = {
		vue = {
			hybridMode = true,
		},
	},
})

vim.lsp.enable({ "vtsls", "volar" })
