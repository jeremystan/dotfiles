# dotfiles

My . files

## Installation

First, install Homebrew:

``` bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow their instructions. Then, run this install:

``` bash
./install.sh
```

Then restart your terminal and it should work!

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