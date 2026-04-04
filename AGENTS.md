# Dotfiles Repository

Personal development environment configuration for macOS.

## Structure

- **`.personal` suffix pattern**: Shell and tmux configs (`.zshrc.personal`, `.tmux.conf.personal`) get symlinked to `$HOME` and sourced by system configs via `prepend_source()`. This layers personal settings on top without overwriting work or system configs.
- **`setup.sh`** orchestrates: `link-dotfiles.sh` → `dev-tools-setup.sh` → `github-ssh-setup.sh`
- **`link-dotfiles.sh`** auto-discovers `.*` files in the repo root and symlinks them to `$HOME`. Excludes `.git`, `.gitignore`, `.claude`, `.DS_Store`. Also symlinks `nvim/` to `~/.config/nvim`.
- **`dev-tools-setup.sh`** installs Homebrew, Brewfile packages, node via mise, and TPM. macOS only. Zinit auto-manages zsh plugin downloads on first shell launch.
- **`github-ssh-setup.sh`** sets up Ed25519 SSH key for GitHub with macOS keychain integration.

## Key Files

| File | Purpose |
|------|---------|
| `.zshrc.personal` | Zinit plugin manager, plugins (syntax-highlighting, autosuggestions, completions), prompt, editor config, tmux helper functions (`ts`, `tk`) |
| `.tmux.conf.personal` | Prefix `Ctrl-a`, vim-style navigation, split bindings (`=`/`-`), session management (`S`/`K`), TPM plugins |
| `.gitconfig` | Git user config, `git s` alias for short status |
| `Brewfile` | Homebrew CLI tools and cask apps |
| `nvim/` | Neovim config with lazy.nvim (symlinked to `~/.config/nvim`) |
| `terminal-themes/` | Oh-my-posh prompt themes (`simple.json`) |
| `iterm2/` | iTerm2 profile export (`Default.json`) |

## Rules

- All scripts must be idempotent (safe to re-run)
- Do not hardcode user paths — use `$HOME` instead
- Do not add submodules — use plugin managers (zinit, TPM, lazy.nvim, etc.)
- The `.gitignore` uses a whitelist pattern (`*` then `!file`) — new files must be explicitly whitelisted to be tracked
