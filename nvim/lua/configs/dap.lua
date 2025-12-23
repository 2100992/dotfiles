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
	console = "integratedTerminal",
	-- console = "externalTerminal",
})

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Python: pytest",
	module = "pytest",
	args = {},
	justMyCode = true,
	breakpoints = {
		exception_breakpoints = { "raised" },
	},
})

-- table.insert(dap.configurations.typescript, {
--     name = "TypeScript: Launch",
--     type = "typescript",
--     request = "launch",
--     program = "${file}",  -- Replace with your main TypeScript file
--     args = {"--inspect"},  -- Enable inspection in the debugger (optional)
--     justMyCode = false,  -- Allow debugging of third-party libraries
--     cwd = "${workspaceRoot}",  -- Set working directory to the root folder of your project
--     runtimeArgs = ["--max-old-space-size=4096"],  -- Optional: Adjust memory usage
--     sourceMaps = true,  -- Enable source maps for better debugging experience
--     console = "integratedTerminal",  -- Choose where to display output (e.g., integrated terminal)
-- })
