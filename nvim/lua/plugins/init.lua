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
			require("configs.lspconfig")
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"autopep8",
				"isort",
				"beautysh",
				"taplo",
				"flake8",
				"eslint_d",
				"cspell",
				"codespell",
				"debugpy",
				"ruff",
				"vue-language-server",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"html",
					"cssls",
					"pyright",
					"docker_compose_language_service",
					"vtsls",
					"yamlls",
				},
				automatic_enable = true,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
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
				"json",
				"yaml",
				"bash",
				"toml",
				"xml",
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
	{ "mfussenegger/nvim-dap" },
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
	{
		"2100992/nvim.ai",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			-- provider = "gigachat", -- You can configure your provider, model or keymaps here.
			-- debug = true,
			insecure = true,
			-- ..
			-- Keymaps
			keymaps = {
				toggle = "<leader>ai", -- Toggle chat dialog
				send = "<CR>", -- Send message in normal mode
				close = "q", -- Close chat dialog
				clear = "<C-l>", -- Clear chat history
				stop_generate = "<C-c>", -- Stop generating
				previous_chat = "<leader>[", -- Open previous chat from history
				next_chat = "<leader>]", -- Open next chat from history
				inline_assist = "<leader>i", -- Run InlineAssist command with prompt
			},
		},
	},

	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1, -- High priority is needed if you will use `autoremap()`
		config = function()
			require("langmapper").setup({--[[ your config ]]
			})
		end,
	},
	{
		"nickjvandyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{
				"folke/snacks.nvim",
				opts = { input = { enabled = true }, picker = { enabled = true }, terminal = { enabled = true } },
			},
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				events = {
					permissions = {
						enabled = true,
						idle_delay_ms = 1000,
						edits = {
							enabled = false,
						},
					},
				},
			}

			-- Required for `opts.events.reload`.
			vim.o.autoread = true
		end,
	},
}
