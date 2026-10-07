# AGENTS.md

## Overview

This is a dotfiles repository containing configuration for:
- **Neovim** (NvChad-based) - `nvim/` directory
- **Shell** - `.zshrc`, `.bashrc`, `config.fish`, `.shared_aliases`, `.zsh_functions/`
- **Terminal** - `alacritty.yml`, `alacritty.toml`, `kitty.conf`, `.wezterm.lua`
- **Tmux** - `.tmux.conf`
- **Vim** - `.vimrc`
- **OpenCode** - `opencode.json`, `cli.json`
- **Scripts** - `bin/`

Neovim configuration is NvChad-based. For theming options, see the
[NvChad documentation](https://nvchad.com). All Neovim conventions live in this
file, under "Neovim".

## Build/Lint/Test Commands

### Neovim

Plugin management (lazy.nvim):

```vim
:Lazy          " plugin manager UI
:Sync          " install missing plugins
:Lazy update   " update plugins
:Lazy clean    " remove unused plugins
```

Formatting (conform.nvim) — format on save is enabled by default in
`nvim/lua/configs/conform.lua`:

```vim
:lua require("conform").format()   " format current file
:ConformInfo                     " show available formatters
```

Formatters by filetype: Lua (`stylua`), Python (`isort`, `autopep8`),
JS/TS/Vue/HTML/CSS/YAML/JSON (`prettierd`), TOML (`taplo`), Bash (`beautysh`).

Linting (nvim-lint) — lint on save is enabled:

```vim
:lua require("lint").lint()
```

Diagnostics and health:

```vim
:lua vim.diagnostic.open_float()
:CheckHealth
```

Testing (pytest via nvim-dap):

```vim
:Pytest                        " run all tests in file
:Pytest                        " run single test (cursor on the test function)
:Pytest args="-k test_name"    " run matching tests
```

Debug with the DAP keybindings in `nvim/lua/mappings/dap.lua`.

### Shell/Config Files

Formatters live in Mason's `bin/` (already on PATH via the nvim environment):

```bash
# TOML
taplo check alacritty.toml

# JSON
python3 -m json.tool opencode.json > /dev/null

# YAML / Markdown
prettierd --check kitty.conf
prettier --check README.md
```

`shellcheck` and `yamllint` are documented below but not installed on this machine.

```bash
shellcheck bin/tmux-session.sh
yamllint alacritty.yml
```

### OpenCode

```bash
# Both configs are symlinked from ~/.config/opencode/
ln -sfn ~/dotfiles/opencode.json ~/.config/opencode/opencode.json
ln -sfn ~/dotfiles/cli.json     ~/.config/opencode/cli.json

# Check what opencode actually reads
opencode --version
```

Edit the repo files, never the ones in `~/.config/opencode/`. `cli.json` is TUI
settings for v2; `tui.json` is pre-v2 and ignored. See `README.md` for details.

## Code Style Guidelines

### General

1. **Tabs** for indentation in Neovim Lua. Every `.lua` file under `nvim/lua/` uses tabs, except `lazy.lua` and `options.lua`, which came from NvChad upstream and use spaces. Match the file you are editing.
2. **Max line length**: ~120 characters
3. **Trailing commas** in tables/arrays when appropriate
4. **No semicolons.** The codebase has zero trailing semicolons; stylua and the existing files do not use them.

Verify with `stylua --check <file>` before committing Lua changes.

### Neovim Lua Conventions

**Naming:**
- Variables/functions: `snake_case` (`local my_function`)
- Module-level constant tables: `SCREAMING_SNAKE_CASE` (e.g. `local POSITIONS = { ... }` in `mappings/opencode.lua`)
- Files/modules: `snake_case.lua`
- Table keys: descriptive, prefer `snake_case`
- Module locals are plain `local`, not underscore-prefixed. The `_private_func()` convention is not used in this codebase.

**Imports:**
- Use `require("module.path")`
- Group imports at file top
- Use aliases: `local map = vim.keymap.set`

**Tables:**
- Use trailing commas in tables
- Prefer multiline tables over single-line ones

**Functions:**
- Use the `vim.fn.` prefix for vimscript functions

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
- Use `<leader>` for user keymaps, but not for mappings that also apply in terminal mode. A `<leader>` mapping in term mode adds input delay while nvim waits to see whether the sequence continues; use `<C-^>` or similar instead.
- Use `"n"` for non-recursive maps
- `vim.keymap.set` defaults to `{ remap = false }`, i.e. `:noremap` semantics. A string RHS is **not** scanned for further mappings, so `map("n", "+", "<C-a>")` runs the built-in `CTRL-A`, not your `<C-a>` mapping. Passing `noremap = true` is not a valid option here; use `remap = false` if you need the opposite.

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

- Use `opts = {}` for simple configs, `config = function() ... end` for complex ones
- Specify `event`, `ft`, or `keys` for lazy loading
- Prefer lazy loading; use `vim.schedule` for startup tasks that must wait for the UI
- Check plugin availability with `pcall` when requiring optional modules

**Error Handling:**
- Use `pcall` for protected calls
- Use `vim.notify` for notifications

**LSP names:**

Config names must match a file in nvim-lspconfig's `lsp/` directory, resolved via
`vim.api.nvim_get_runtime_file('lsp/<name>.lua')`. A wrong name does not error:
`vim.lsp.config` silently stores a config with no `cmd` and no `filetypes`, and
`vim.lsp.enable` accepts anything, so the client simply never starts. Check names
against `nvim-lspconfig/doc/configs.txt`. Mason package names differ from config
names — config `groovyls`, mason package `groovy-language-server`.

**Plugin internals:**

`require("opencode.context")`, `Context:render`, and `Rendered:plaintext()` are
internal API without stability guarantees. `nvim/lua/mappings/opencode.lua` uses
them to render `@this` locally without a server. Re-check them on plugin updates.

**opencode.nvim session targeting:**

The plugin targets the most recently updated session, so a prompt sent from
Neovim can land in a tab you are not looking at. That is why `go`/`goo` copy the
rendered reference to the clipboard instead of sending it. Keep that behaviour
unless the session targeting changes upstream.

### Shell Scripts

- Use `#!/bin/bash` or `#!/usr/bin/env bash`
- Quote variables: `"$VAR"` not `$VAR`
- Use `set -euo pipefail`
- Use `[[ ]]` for conditionals (not `[ ]`)

### Configuration Files

- **YAML**: 2-space indent, no tabs
- **TOML**: valid TOML, checked with `taplo check`
- **JSON**: strict JSON, no comments and no trailing commas. `opencode.json` and `cli.json` carry a `$schema` field; validate against `https://opencode.ai/config.json` and `https://opencode.ai/v2/cli.json` respectively
- **Conf/Ini**: no tabs, standard formatting

## Common Patterns

```lua
-- Neovim plugin spec with lazy loading (tabs, matching the surrounding files)
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
if not ok then
	return
end
```

```bash
#!/usr/bin/env bash
set -euo pipefail

# Use quotes
local_var="${HOME}/path"
another_var="$HOME/path"

# Shellcheck inline ignore if needed
# shellcheck disable=SC2086
```

## File Structure

```
dotfiles/
├── nvim/                    # Neovim config (NvChad)
│   ├── init.lua             # Entry point — bootstraps lazy.nvim
│   ├── lua/
│   │   ├── chadrc.lua       # Theme/UI config
│   │   ├── options.lua      # vim.opt
│   │   ├── mappings/        # Keybindings (init.lua, dap.lua, opencode.lua)
│   │   ├── configs/         # Plugin configs (lazy, lspconfig, conform, lint, dap, lsp/)
│   │   └── plugins/init.lua # Plugin list and lazy.nvim specs
├── .zshrc                   # Zsh config
├── .bashrc                  # Bash config
├── config.fish              # Fish config
├── .vimrc                   # Vim config
├── .tmux.conf               # Tmux config
├── alacritty.yml/.toml      # Alacritty config
├── kitty.conf               # Kitty config
├── .wezterm.lua             # Wezterm config
├── opencode.json            # OpenCode agent config
├── cli.json                 # OpenCode TUI config (v2)
└── bin/                     # Scripts
```

## Useful Commands

- `:Lazy` - Neovim plugin manager
- `:Mason` - LSP/DAP installer
- `:ConformInfo` - Show formatters
- `:Pytest` - Run Python tests

## Agent Configuration

- `opencode.json` — OpenCode agent config: model, default agent, permissions, providers, commands. Schema: `https://opencode.ai/config.json`.
- `cli.json` — OpenCode TUI settings: sidebar, scrollbar, thinking blocks, animations, tabs. Schema: `https://opencode.ai/v2/cli.json`. Pre-v2 setups used `tui.json`; opencode v2 migrates it once and then ignores it.

Both are symlinked into `~/.config/opencode/`. Edit the repo copies.

Permission rules use a wildcard matcher, not globs: `*` matches any character
including `/`, `?` matches exactly one, `~`/`$HOME` expand at the start of a
pattern, and the **last** matching rule wins — put the catch-all `"*"` first.
`external_directory` guards paths outside the working directory and defaults to
`ask`.

## Git

- Conventional Commit prefixes (`fix:`, `refactor:`, `update:`, `docs:`, `chore:`)
- No `git config` changes without an explicit request
- No `--force`, no `-i`, never skip hooks
- Review `git status` and `git diff` before committing; do not commit unrequested
