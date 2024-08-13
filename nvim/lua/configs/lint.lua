local lint = require("lint")

lint.linters_by_ft = {
	javascript = {
		"eslint_d",
	},
	typescript = {
		"eslint_d",
	},
	vue = {
		"eslint_d",
	},
	-- javascriptreact = { { "eslint_d", "eslint" } },
	-- typescriptreact = { { "eslint_d", "eslint" } },
	-- svelte = { "eslint_d" },
	python = { "flake8" },
	["*"] = { "codespell" },
}
local pattern = "[^:]+:(%d+):(%d+):(%w+):(.+)"
local groups = { "lnum", "col", "code", "message" }
local binary_name = "eslint_d"

lint.linters = {
	flake8 = {
		cmd = "flake8",
		stdin = true,
		args = {
			"--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
			"--no-show-source",
			"--stdin-display-name",
			"--max-line-length=120",
			"--ignore=E402,F401",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
			"-",
		},
		ignore_exitcode = true,
		parser = require("lint.parser").from_pattern(pattern, groups, nil, {
			["source"] = "flake8",
			["severity"] = vim.diagnostic.severity.WARN,
		}),
	},
	eslint_d = {
		cmd = function()
			local local_binary = vim.fn.fnamemodify("./node_modules/.bin/" .. binary_name, ":p")
			return vim.loop.fs_stat(local_binary) and local_binary or binary_name
		end,
		args = {
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		},
		stdin = true,
		stream = "stdout",
		ignore_exitcode = true,
		parser = function(output, bufnr)
			local result = require("lint.linters.eslint").parser(output, bufnr)
			for _, d in ipairs(result) do
				d.source = binary_name
			end
			return result
		end,
	},
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>l", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
