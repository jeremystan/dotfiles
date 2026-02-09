#!/usr/bin/env bash
set -euo pipefail

# Resolve script dir (works on macOS + Linux)
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Symlink dotfiles
ln -sf "${BASEDIR}/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -sf "${BASEDIR}/.zshrc"    "${HOME}/.zshrc"

# macOS setup
if [[ "$(uname -s)" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install it first: https://brew.sh/"
    exit 1
  fi

  brew update
  brew install powerlevel10k fzf ripgrep tmux emacs pyenv pyenv-virtualenv
  brew install --cask font-jetbrains-mono-nerd-font

  # Enable fzf keybindings/completion
  "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish || true

  # Ensure login shell is zsh (usually already)
  if [[ "${SHELL:-}" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh || true
  fi

else
  # Debian/Ubuntu setup (Codespaces, etc.)
  sudo apt -o DPkg::Lock::Timeout=120 update
  sudo apt -o DPkg::Lock::Timeout=10 install -y \
    silversearcher-ag tmux emacs ripgrep

  # fzf from git (or apt, if you prefer)
  if [[ ! -d "${HOME}/.fzf" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
    "${HOME}/.fzf/install" --all --no-bash --no-fish
  fi
fi

# Git config (set once)
git config --global --get alias.lg >/dev/null 2>&1 || \
  git config --global alias.lg \
    "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

echo "Done."
