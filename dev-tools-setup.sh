#!/bin/bash

echo "Installing developer tools..."

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Unsupported operating system"
    exit 1
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# Install tools and personal apps from Brewfile
echo "Installing packages from Brewfile..."
brew bundle --file=Brewfile

# Bootstrap zinit and zsh plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    echo "Installing zinit..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
else
    echo "zinit already installed"
fi
echo "Installing zsh plugins via zinit..."
zsh -i -c 'exit' 2>/dev/null

# Install node via mise
if command -v mise &> /dev/null; then
    echo "Installing node via mise..."
    mise use --global node@24
else
    echo "mise not found, skipping node install"
fi

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed"
fi

# Auto-install tmux plugins
if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    echo "Installing tmux plugins..."
    # TPM reads TMUX_PLUGIN_MANAGER_PATH from the tmux server environment
    started_server=false
    if ! tmux list-sessions &>/dev/null; then
        tmux start-server
        started_server=true
    fi
    tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins"
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
    if $started_server; then
        tmux kill-server 2>/dev/null
    fi
fi

echo "Setup complete!"
