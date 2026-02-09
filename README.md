# dotfiles

My dotfiles for a clean macOS setup (zsh + Homebrew + Powerlevel10k).

## Installation

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow Homebrew’s instructions and open a **new terminal window** afterward.

### 2. Run the installer

From the repo root:

```bash
./install.sh
```

This will:

- Symlink `.zshrc` and `.p10k.zsh`
- Install core tools via Homebrew (fzf, ripgrep, tmux, emacs, pyenv, etc.)
- Install a Nerd Font for Powerlevel10k

Restart your terminal when it finishes.

### 3. Set your terminal font (one-time)

Set your terminal font to:

**JetBrainsMono Nerd Font**

- Terminal.app: Settings → Profiles → Text → Font
- iTerm2: Settings → Profiles → Text → Font
- VS Code: `terminal.integrated.fontFamily`

If icons look wrong, run:

```bash
p10k configure
```

## Verification (post-install)

Restart your terminal, then run:

```bash
# 1) Confirm shell
echo "$SHELL"
echo "$0"
zsh --version

# 2) Homebrew healthy + on PATH
command -v brew
brew --version
brew doctor

# 3) Packages installed
command -v rg && rg --version
command -v tmux && tmux -V
command -v emacs && emacs --version | head -n 1
command -v fzf && fzf --version

# 4) Powerlevel10k + config present
test -f ~/.p10k.zsh && echo "~/.p10k.zsh OK"
print -P '%F{green}p10k prompt render test%f'

# 5) pyenv working
command -v pyenv && pyenv --version
pyenv root
pyenv versions
python3 --version
```

If all of the above pass and your prompt renders cleanly, you’re done.
