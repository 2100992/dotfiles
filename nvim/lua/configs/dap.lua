local dap_python = require("dap-python")
local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
-- local path = "/usr/local/bin/python"
-- local path = "python"
dap_python.setup(path)

local dap = require("dap")

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Python: Flask",
	module = "flask",
	-- env = { FLASK_APP = "server.py" },
	args = {
		"run",
		-- "--no-debugger",
		-- "--no-reload",
		"--host",
		"0.0.0.0",
		"--port",
		"5000",
	},
	justMyCode = true,
})

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Python: Flask shell",
	module = "flask",
	args = { "shell" },
	-- env = {},
	justMyCode = true,
	-- console = "internalConsole",
	-- console = "integratedTerminal",
	console = "externalTerminal",
})
