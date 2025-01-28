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
	-- 	"Exafunction/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({
	-- 			enable_cmp_source = false,
	-- 			virtual_text = {
	-- 				enabled = true,
	--
	-- 				-- These are the defaults
	--
	-- 				-- Set to true if you never want completions to be shown automatically.
	-- 				manual = false,
	-- 				-- A mapping of filetype to true or false, to enable virtual text.
	-- 				filetypes = {},
	-- 				-- Whether to enable virtual text of not for filetypes not specifically listed above.
	-- 				default_filetype_enabled = true,
	-- 				-- How long to wait (in ms) before requesting completions after typing stops.
	-- 				idle_delay = 75,
	-- 				-- Priority of the virtual text. This usually ensures that the completions appear on top of
	-- 				-- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
	-- 				-- desired.
	-- 				virtual_text_priority = 65535,
	-- 				-- Set to false to disable all key bindings for managing completions.
	-- 				map_keys = true,
	-- 				-- The key to press when hitting the accept keybinding but no completion is showing.
	-- 				-- Defaults to \t normally or <c-n> when a popup is showing.
	-- 				accept_fallback = nil,
	-- 				-- Key bindings for managing completions in virtual text mode.
	-- 				key_bindings = {
	-- 					-- Accept the current completion.
	-- 					accept = "<M-enter>",
	-- 					-- Accept the next word.
	-- 					accept_word = "<M-l>",
	-- 					-- Accept the next line.
	-- 					accept_line = "<M-k>",
	-- 					-- Clear the virtual text.
	-- 					clear = false,
	-- 					-- Cycle to the next completion.
	-- 					next = "<M-]>",
	-- 					-- Cycle to the previous completion.
	-- 					prev = "<M-[>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	event = "BufEnter",
	-- },
	{
		"magicalne/nvim.ai",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			provider = "deepseek", -- You can configure your provider, model or keymaps here.

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
}
