local on_attach = require("nvchad.configs.lspconfig").on_attach

local mason_pkgs = vim.fn.stdpath("data") .. "/mason/packages"

local vue_language_server_path = mason_pkgs .. "/vue-language-server/node_modules/@vue/language-server"

local typescript_path = mason_pkgs .. "/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"

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
		typescript = {
			tsdk = typescript_path,
		},
	},
})

vim.lsp.config("vue_ls", {
	on_attach = on_attach,
	cmd = { "vue-language-server", "--stdio", "--tsdk=" .. typescript_path },
	filetypes = { "vue" },
	settings = {
		vue = {
			hybridMode = true,
		},
	},
})

vim.lsp.enable({ "vtsls", "vue_ls" })
