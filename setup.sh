#!/bin/bash
set -e

# Detect distro and install deps accordingly
if command -v pacman &> /dev/null; then
    sudo pacman -S --needed --noconfirm \
        neovim \
        stow \
        npm \
        bat \
        nodejs \
        python \
        python-pip \
        python-pynvim \
        rustup \
        wget \
        jq \
        fzf \
        curl \
        ttf-firacode-nerd \
        htop \
        lazygit \
        python-black \
        yaml-language-server \
        mosquitto \
        tree-sitter-cli \
        zathura \
        zathura-pdf-mupdf \
        texlab \
        texlive \
        ripgrep
    sudo npm install -g neovim
    rustup default stable
elif command -v apt &> /dev/null; then
    sudo apt install -y \
        stow \
        fzf \
        wget \
        curl \
        jq \
        bat \
        htop \
        nodejs \
        npm \
        python3 \
        python3-pip \
        python3-neovim \
        ripgrep \
        lazygit \
        tree-sitter-cli \
        zathura \
        zathura-pdf-poppler \
        texlive \
        texlive-latex-extra
    sudo npm install -g neovim
    echo "Install Neovim 0.11 manually from your mirror or app-image!"
fi

# Symlink config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
stow .

echo "Done! Mason will handle LSP servers on first Neovim launch."
