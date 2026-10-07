# Dotfiles

Personal configurations for Neovim, Zsh, Tmux, Vim, and terminal emulators.

## Quick Install

```bash
git clone https://github.com/shvetsov/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh  # or manually symlink
```

## Structure

```
.dotfiles/
├── nvim/              # Neovim (NvChad-based)
├── .zshrc             # Zsh config
├── .bashrc            # Bash config
├── .tmux.conf         # Tmux config
├── .vimrc             # Vim config
├── alacritty.yml      # Alacritty terminal
├── kitty.conf         # Kitty terminal
├── .wezterm.lua       # Wezterm terminal
├── .shared_aliases    # Shared shell aliases
├── .zsh_functions/    # Zsh functions
└── bin/               # Scripts
```

## Neovim

**Install plugins**: Open Neovim and run `:Lazy` then `:Sync`

### Keybindings

Leader key: `<Space>`

| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>/` | Clear search highlights |
| `<Space>fp` | Copy file path |
| `<Space>b` | Telescope buffers |
| `<Space>o` | Telescope find files |
| `<Space>sb` | Telescope current buffer fuzzy |
| `<Space>sp` | Telescope live grep |
| `<Space>f` | Telescope file browser |
| `<Space>i` | Telescope git status |
| `<Space><Space>w` | Hop hint words |
| `<Space><Space>l` | Hop hint lines |
| `<C-b>` | NvimTree toggle |
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover documentation |
| `[d` / `]d` | Prev/next diagnostic |
| `<Space>q` | LSP diagnostics list |
| `<Space>rn` | LSP rename |
| `<Space>ca` | LSP code action |
| `<Space>so` | LSP symbols |
| `<Space>S` | Spectre search |
| `<Space>SW` | Spectre search current word |

### Gitsigns

| Key | Action |
|-----|--------|
| `<leader>gnh` | Next hunk |
| `<leader>gph` | Prev hunk |
| `<leader>gh` | Preview hunk inline |

### Testing (pytest)

```vim
:Pytest           " Run all tests in file
:Pytest args="-k test_name"  " Run specific tests
```

## OpenCode

Config lives in the repo and is exposed to OpenCode through symlinks in `~/.config/opencode/`.

| Repo file | Symlink target | Purpose |
|-----------|----------------|---------|
| `opencode.json` | `~/.config/opencode/opencode.json` | Agent config: model, default agent, permissions, providers, commands |
| `cli.json` | `~/.config/opencode/cli.json` | TUI settings: sidebar, scrollbar, thinking blocks, animations, tabs |

### Setup

```bash
mkdir -p ~/.config/opencode
ln -sfn ~/dotfiles/opencode.json ~/.config/opencode/opencode.json
ln -sfn ~/dotfiles/cli.json     ~/.config/opencode/cli.json
```

`ln -sfn` overwrites an existing symlink in place. Use the real repo path if your clone is not at `~/dotfiles`.

### Notes

- OpenCode v2 reads TUI settings from `cli.json`, **not** `tui.json`. Older setups used `tui.json`; v2 migrates it into `cli.json` and `~/.local/state/opencode/kv.json` on first run, then ignores it. If a stale `~/.config/opencode/tui.json` symlink exists, remove it.
- Edit the repo files, never the ones in `~/.config/opencode/`. Writes through a symlink land in the repo, which is the point.
- `service.json` (mode `600`) is generated state and is intentionally not symlinked or committed.
- Permission rules in `opencode.json` use a wildcard matcher, not globs: `*` matches any character including `/`, `?` matches exactly one. There is no distinct `**` — it is just two `*`. `~` and `$HOME` expand at the start of a pattern, and **last matching rule wins**, so a catch-all `"*"` goes first and specific rules follow.
- `external_directory` guards paths outside the working directory and defaults to `ask`. It is what stops the agent from wandering into `~/.ssh`, `~/.gnupg`, or any other path outside the project.
- Verify a rule actually fires rather than assuming: ask the agent to touch a denied path and watch for the prompt or the block.

### Neovim integration

`nvim/lua/mappings/opencode.lua` wires the plugin (`nickjvandyke/opencode.nvim`) to this setup:

| Key | Mode | Action |
|-----|------|--------|
| `<C-a>` | normal, visual | Ask OpenCode with `@this:` pre-filled |
| `<C-x>` | normal, visual | Open the action picker |
| `<C-^>` | normal, terminal | Toggle the OpenCode terminal |
| `<Space>op` | normal | Pick terminal position (right/left/top/bottom/float) |
| `go` | normal, visual | Copy `@this` range reference to the clipboard, then paste into the TUI |
| `goo` | normal | Same, linewise |

`go`/`goo` copy instead of sending on purpose. The plugin targets the most recently updated session, so a prompt sent from Neovim can land in a tab you are not looking at. Copying lets you review and comment before submitting.

## Zsh Aliases

### Git

| Alias | Command |
|-------|---------|
| `gs` | `git status --short` |
| `ga` | `git add` |
| `gb` | `git branch` |
| `gc` | `git checkout` |
| `gme` | `git merge` |
| `gd` | `git diff` |
| `gcp` | `git cherry-pick` |
| `gl` | `git log` |
| `glp` | `git log -p` |
| `gln` | `git log --name-only` |
| `gcv` | `git commit -v` |
| `gcm` | `git commit -m` |
| `gca` | `git commit --amend` |
| `gplo` | `git pull origin` |
| `gpso` | `git push origin` |
| `gpsof` | `git push --force origin` |
| `gda/gdm/gdd` | Diff added/modified/deleted |

### Navigation

| Alias | Command |
|-------|---------|
| `cdd` | `cd ~/Downloads` |
| `cdw` | `cd ~/Work` |
| `z` | zoxide integration |

### Other

| Alias | Command |
|-------|---------|
| `dps` | `docker ps` |
| `rgl` | `rg -l` |

## Tmux

| Key | Action |
|-----|--------|
| `Ctrl+b v` | Split horizontal |
| `Ctrl+b s` | Split vertical |
| `Ctrl+b C` | New window |
| `Ctrl+b j/k/h/l` | Navigate panes |
| `v` / `y` | Copy mode selection |

## Vim

Plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug).

**Install plugins**:
```
:PlugInstall
```

## Terminals

- **Alacritty**: `alacritty.yml` / `alacritty.toml`
- **Kitty**: `kitty.conf`
- **Wezterm**: `.wezterm.lua`

Font: JetBrains Mono