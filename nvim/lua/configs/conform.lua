local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		python = { "isort", "autopep8" },
		javascript = {
			"prettierd",
			-- { "prettierd", "prettier" }
		},
		typescript = {
			"prettierd",
			-- { "prettierd", "prettier" }
		},
		vue = {
			"prettierd",
			-- { "prettierd", "prettier" }
		},
		yaml = {
			"prettierd",
			-- { "prettierd", "prettier" },
		},
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
		async = false,
	},

	formatters = {
		autopep8 = {
			command = "autopep8",
			range_args = function(self, ctx)
				return { "-", "--line-range", tostring(ctx.range.start[1]), tostring(ctx.range["end"][1]) }
			end,
			args = {
				"-",
				"--ignore=E402",
			},
		},
	},
}

require("conform").setup(options)
