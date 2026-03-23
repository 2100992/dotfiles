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