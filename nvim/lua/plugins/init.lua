return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		config = function()
			require("configs.conform")
		end,
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"html-lsp",
				"css-lsp",
				"prettier",
				"debugpy",
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"python",
				"vue",
				"typescript",
				"javascript",
			},
			auto_install = true,
		},
	},

	{
		"sindrets/diffview.nvim",
	},

	{
		"numToStr/Comment.nvim",
		opts = {},
	},

	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("configs.lint")
		end,
	},

	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function(_, opts)
			-- require("core.utils").load_mappings("dap")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function(_, opts)
			require("configs.dap")
		end,
	},
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	event = "BufEnter",
	-- },
	{
		"Exafunction/codeium.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
		event = "BufEnter",
	},
}
