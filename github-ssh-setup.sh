#!/bin/bash

echo "Setting up GitHub SSH..."

KEY_PATH="$HOME/.ssh/id_ed25519"

# Generate SSH key if it doesn't exist
if [ -f "$KEY_PATH" ]; then
    echo "SSH key already exists at $KEY_PATH"
else
    read -p "Enter your GitHub email: " email
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t ed25519 -C "$email" -f "$KEY_PATH" -N ""
fi

# Start ssh-agent and add key
eval "$(ssh-agent -s)"

# Configure ~/.ssh/config for macOS keychain
SSH_CONFIG="$HOME/.ssh/config"
if ! grep -q "Host github.com" "$SSH_CONFIG" 2>/dev/null; then
    mkdir -p "$HOME/.ssh"
    cat >> "$SSH_CONFIG" <<EOF

Host github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile $KEY_PATH
EOF
    echo "Added GitHub SSH config"
else
    echo "GitHub SSH config already exists"
fi

ssh-add --apple-use-keychain "$KEY_PATH" 2>/dev/null || ssh-add "$KEY_PATH"

# Upload key to GitHub
if command -v gh &> /dev/null; then
    echo "Uploading SSH key to GitHub via gh CLI..."
    gh ssh-key add "${KEY_PATH}.pub" -t "$(hostname)" 2>/dev/null || echo "Key may already be uploaded"
else
    echo "gh CLI not found. Copy your public key and add it to GitHub:"
    cat "${KEY_PATH}.pub"
    if command -v pbcopy &> /dev/null; then
        cat "${KEY_PATH}.pub" | pbcopy
        echo "(Copied to clipboard)"
    fi
fi

# Test connection
echo "Testing GitHub SSH connection..."
ssh -T git@github.com 2>&1 || true

echo "GitHub SSH setup complete!"
