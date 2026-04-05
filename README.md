# dotfiles

Personal dotfiles for consistent dev environments across machines. Manages shell config, editor settings, tmux, git, terminal themes, and application installation via Homebrew.

## Quick Start

On a new machine, clone and run:

```bash
git clone git@github.com:iambekzod/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh setup.sh
```

`setup.sh` runs everything in order:

1. **link-dotfiles.sh** — Auto-discovers and symlinks all dotfiles (`.zshrc.personal`, `.gitconfig`, `.vimrc`, `.tmux.conf.personal`, etc.) from this repo into `~`, symlinks `nvim/` to `~/.config/nvim`, and ensures `~/.zshrc` and `~/.tmux.conf` source their `.personal` counterparts.

2. **dev-tools-setup.sh** — Installs Homebrew (if needed), runs `brew bundle` for CLI tools and apps, bootstraps zinit and zsh plugins, installs node via mise, and installs TPM with tmux plugins.

3. **github-ssh-setup.sh** — Generates an Ed25519 SSH key, configures macOS keychain integration, and uploads to GitHub via `gh` CLI.

## Scripts

| Script | Purpose | Interactive? |
|--------|---------|--------------|
| `setup.sh` | Full new-machine setup (runs all scripts below) | Yes |
| `link-dotfiles.sh` | Auto-discover and symlink dotfiles into `~` | No |
| `dev-tools-setup.sh` | Install tools/apps via Brewfile, zinit, mise, TPM | Yes |
| `github-ssh-setup.sh` | Generate SSH key and upload to GitHub via `gh` | Yes |

## Config Files

| File | What it configures |
|------|--------------------|
| `.zshrc.personal` | Zsh — zinit plugins, fzf-tab, OMZ snippets, keybindings, history, aliases, shell integrations (fzf, zoxide) |
| `.tmux.conf.personal` | Tmux — prefix `Ctrl-a`, vim navigation, split bindings, session management, TPM plugins |
| `.gitconfig` | Git — aliases (`git s` for short status), editor, user config |
| `.vimrc` | Vim editor settings (fallback when neovim isn't available) |
| `Brewfile` | Homebrew CLI tools (fzf, ripgrep, mise, zoxide, etc.) and personal apps (Firefox, iTerm2, Raycast, Rectangle) |
| `nvim/` | Neovim config with lazy.nvim — catppuccin theme, telescope, treesitter, LSP, gitsigns |
| `terminal-themes/` | Oh-my-posh prompt themes |
| `iterm2/` | iTerm2 profile export |

## How Symlinks Work

`link-dotfiles.sh` auto-discovers all dotfiles at the repo root (excluding `.git`, `.gitignore`, `.claude`, `.DS_Store`) and symlinks them into `~`. Adding a new dotfile to the repo is all you need — no script changes required.

`~/.zshrc` and `~/.tmux.conf` are not symlinked — they're per-machine files for work-specific config. `link-dotfiles.sh` creates them if missing and prepends a line to source their `.personal` counterpart. Work-specific settings go after the source line so they take precedence.

## Tmux Bindings

Prefix is `Ctrl-a` (remapped from `Ctrl-b`).

| Binding | Action |
|---------|--------|
| `Ctrl-a =` | Split pane horizontal |
| `Ctrl-a -` | Split pane vertical |
| `Ctrl-a` + arrows | Navigate panes |
| `Ctrl-a h` / `l` | Previous / next window |
| `Ctrl-a S` | New session (prompts for name) |
| `Ctrl-a K` | Kill session |
| `Ctrl-a r` | Reload tmux config |

Mouse scrolling and vi copy mode are enabled.

## Shell Aliases & Functions

| Command | Description |
|---------|-------------|
| `vim` | Opens neovim |
| `c` | Clear terminal |
| `ls` | Colored output |
| `ts [dir] [name]` | Start a detached tmux session in `dir` (default: `.`) |
| `tk [name]` | Kill a tmux session by name, or pick one with fzf |

## Prompt (Oh My Posh)

Uses [oh-my-posh](https://ohmyposh.dev) with `terminal-themes/simple.json`:

- Full path + git branch with dirty (`*`) and ahead/behind (`⇡⇣`) indicators
- Status-aware `❯` prompt (green on success, red on failure)
- Execution time on right side (only for commands >500ms)
- Transient prompt — collapses previous prompts in scrollback
- Tooltips for AWS and kubectl context (appear when typing relevant commands)

To activate, add to `~/.zshrc`:
```bash
eval "$(oh-my-posh init zsh --config ~/dotfiles/terminal-themes/simple.json)"
```

## Resources

- https://dotfiles.github.io/
