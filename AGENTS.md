# AGENTS.md

## Overview

This is a dotfiles repository containing configuration for:
- **Neovim** (NvChad-based) - `nvim/` directory
- **Shell** - `.zshrc`, `.bashrc`, `.shared_aliases`, `.zsh_functions/`
- **Terminal** - `alacritty.yml`, `kitty.conf`, `.wezterm.lua`
- **Tmux** - `.tmux.conf`
- **Vim** - `.vimrc`
- **Scripts** - `bin/`

## Build/Lint/Test Commands

### Neovim

```bash
# Install plugins - open nvim and run
:Lazy
:Sync

# Update plugins
:Lazy update

# Clean unused plugins
:Lazy clean

# Format file (conform.nvim)
:lua require("conform").format()

# Lint file (nvim-lint)
:lua require("lint").lint()

# Show diagnostics
:lua vim.diagnostic.open_float()

# Check health
:CheckHealth
```

### Python (via nvim-dap + pytest)

```vim
" Run all tests in file
:Pytest

" Run single test (cursor on test function)
:Pytest

" Run tests with arguments
:Pytest args="-k test_name"

" Debug test (use DAP keybindings)
```

### Shell/Config Files

```bash
# Shellcheck (bash/zsh)
shellcheck bin/tmux-session.sh

# TOML validation
taplo check alacritty.toml

# YAML validation
yamllint alacritty.yml
```

## Code Style Guidelines

### General

1. **Use 3 spaces** for indentation in Neovim Lua
2. **Max line length**: ~120 characters
3. **Trailing commas** in tables/arrays
4. **Semicolons** at end of statements when appropriate

### Neovim Lua Conventions

**Naming:**
- Variables/functions: `snake_case` (`local my_function`)
- Constants: `SCREAMING_SNAKE_CASE` (`local MAX_RETRIES = 10`)
- Files/modules: `snake_case.lua`
- Prefix private functions: `local function _private_func()`

**Imports:**
- Use `require("module.path")`
- Group imports at file top
- Use aliases: `local map = vim.keymap.set`

**Types (LuaLS):**
```lua
---@param name string
---@return boolean
local function greet(name)
  return true
end
```

**Keymaps:**
```lua
map("n", "<leader>foo", "<cmd>Foo<CR>", { desc = "Foo command" })
```
- Always include `desc`
- Use `<leader>` for user keymaps

**Plugin Specs:**
```lua
return {
  "author/plugin",
  event = "BufReadPre",
  config = function()
    require("plugin_name").setup({})
  end,
}
```

**Error Handling:**
- Use `pcall` for protected calls
- Use `vim.notify` for notifications

### Shell Scripts

- Use `#!/bin/bash` or `#!/usr/bin/env bash`
- Quote variables: `"$VAR"` not `$VAR`
- Use `set -euo pipefail`
- Use `[[ ]]` for conditionals (not `[ ]`)

### Configuration Files

- **YAML**: 2-space indent, no tabs
- **TOML**: Use valid TOML syntax
- **JSON**: Standard formatting with trailing commas
- **Conf/Ini**: No tabs, use standard formatting

## Common Patterns

```lua
-- Neovim plugin spec with lazy loading
return {
  "author/plugin-name",
  event = "BufReadPre",
  opts = {},
  config = function()
    require("plugin_name").setup({
      option = true,
    })
  end,
}

-- Keymap with description
local map = vim.keymap.set
map("n", "<leader>tc", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Protected require
local ok, mod = pcall(require, "optional_module")
if not ok then return end
```

```bash
#!/usr/bin/env bash
set -euo pipefail

# Use quotes
local_var="${HOME}/path"

# Shellcheck inline ignore if needed
# shellcheck disable=SC2086
```

## File Structure

```
dotfiles/
├── nvim/                    # Neovim config (NvChad)
│   ├── init.lua             # Entry point
│   ├── lua/
│   │   ├── chadrc.lua      # Theme/UI config
│   │   ├── options.lua     # vim.opt
│   │   ├── mappings/       # Keybindings
│   │   ├── configs/        # Plugin configs
│   │   └── plugins/        # Plugin list
├── .zshrc                   # Zsh config
├── .bashrc                  # Bash config
├── .vimrc                   # Vim config
├── .tmux.conf              # Tmux config
├── alacritty.yml/.toml     # Alacritty config
├── kitty.conf              # Kitty config
├── .wezterm.lua            # Wezterm config
└── bin/                    # Scripts
```

## Useful Commands

- `:Lazy` - Neovim plugin manager
- `:Mason` - LSP/DAP installer
- `:ConformInfo` - Show formatters
- `:Pytest` - Run Python tests

## Agent Configuration

See `opencode.json` for OpenCode AI agent permissions and provider settings.
