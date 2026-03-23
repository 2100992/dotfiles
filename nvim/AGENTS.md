# AGENTS.md

## Overview

This is a Neovim configuration repository using **NvChad**. For UI theming options, see the [NvChad documentation](https://nvchad.com).

## Directory Structure

```
nvim/
├── init.lua                 # Main entry point - bootstraps lazy.nvim
├── lua/
│   ├── chadrc.lua           # NvChad configuration (theme, UI)
│   ├── options.lua          # Neovim options (vim.opt)
│   ├── mappings/
│   │   ├── init.lua         # Global key mappings
│   │   ├── dap.lua          # Debug adapter key mappings
│   │   └── opencode.lua     # OpenCode AI key mappings
│   ├── configs/
│   │   ├── lazy.lua         # Lazy.nvim configuration
│   │   ├── lspconfig.lua    # LSP servers configuration
│   │   ├── conform.lua      # Formatter configuration
│   │   ├── lint.lua         # Linter configuration
│   │   ├── dap.lua          # DAP configuration
│   │   └── lsp/             # Language-specific LSP configs
│   └── plugins/
│       └── init.lua         # Plugin list and configuration
```

## Build/Lint/Test Commands

### Plugin Management

- **Install plugins**: Open Neovim and run `:Lazy` then `:Sync`
- **Update plugins**: `:Lazy update`
- **Clean unused plugins**: `:Lazy clean`

### Formatting (conform.nvim)

- **Format file**: `:lua require("conform").format()`
- **Format on save**: Enabled by default in `lua/configs/conform.lua`
- **List formatters**: `:ConformInfo`

Formatters: Lua (`stylua`), Python (`isort`, `autopep8`), JS/TS/Vue/HTML/CSS/YAML/JSON (`prettierd`), TOML (`taplo`), Bash (`beautysh`)

### Linting (nvim-lint)

- **Lint file**: `:lua require("lint").lint()`
- **Lint on save**: Enabled by default

### Testing (Python pytest)

- **Run all tests in file**: `:Pytest`
- **Run single test**: Place cursor on test function and run `:Pytest` (uses nvim-dap under the hood)
- **Debug test**: Use DAP keybindings - see `lua/mappings/dap.lua`
- **Run tests with arguments**: `:Pytest args="-k test_name"`

### Code Quality

- **Show diagnostics**: `:lua vim.diagnostic.open_float()`
- **Check health**: `:CheckHealth`

## Code Style Guidelines

### General Principles

1. **Use 3 spaces** for indentation (not tabs)
2. **Max line length**: ~120 characters
3. **Use semicolons** at the end of statements when appropriate
4. **Trailing commas** for tables/arrays

### Naming Conventions

- **Variables/functions**: `snake_case` (e.g., `local my_function`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `local MAX_RETRIES = 10`)
- **Modules/files**: `snake_case.lua`
- **Table keys**: Use descriptive names, prefer snake_case
- **Prefix private functions with underscore**: `local function _private_func()`

### Imports

- Use `require("module.path")` for importing modules
- Group imports at the top of files
- Use aliases for long module names: `local map = vim.keymap.set`

### Types

- Use LuaLS type annotations:
  ```lua
  ---@param name string
  ---@return boolean
  local function greet(name)
    return true
  end
  ```

### Tables/Structures

- Use trailing commas in tables
- Prefer multiline tables over single-line

### Functions

- Use `function()` syntax over `local function()` when defining methods
- Use `vim.fn.` prefix for vimscript functions

### Keymaps

- Always include `desc` option:
  ```lua
  map("n", "<leader>foo", "<cmd>Foo<CR>", { desc = "Foo command" })
  ```
- Use `<leader>` for user keymaps
- Use `noremap = true` (or just `n`) for non-recursive maps

### Plugin Configuration

- Use `opts = {}` for simple configs
- Use `config = function() ... end` for complex configs
- Specify `event`, `ft`, or `keys` for lazy-loading

### Error Handling

- Use `pcall` for protected calls: `local ok, result = pcall(require, "module")`
- Use `vim.notify` for notifications

### Best Practices

1. **Lazy loading**: Load plugins on specific events/filetypes
2. **Use vim.schedule**: For startup tasks that need to wait for UI
3. **Check plugin availability**: Use `pcall` when requiring optional plugins

### Common Patterns

```lua
-- Plugin spec
return {
  "author/plugin",
  event = "BufReadPre",
  config = function()
    require("plugin_name").setup({})
  end,
}

-- Keymap
local map = vim.keymap.set
map("n", "<leader>key", "<cmd>Command<CR>", { desc = "Description" })
```

## Useful Commands

- `:Lazy` - Plugin manager UI
- `:Mason` - LSP/DAP installer
- `:Checkhealth` - Neovim health check
