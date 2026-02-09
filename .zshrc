# ---- Powerlevel10k instant prompt (keep near the top) ----
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- Homebrew ----
eval "$(/opt/homebrew/bin/brew shellenv)"
alias brew86='arch --x86_64 /usr/local/bin/brew'

# ---- Python / pyenv ----
export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"

command -v pyenv >/dev/null 2>&1 && {
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

# ---- Shell behavior ----
export KEYTIMEOUT=1
setopt INC_APPEND_HISTORY
HISTSIZE=50000
SAVEHIST=50000

# ---- Tools ----
alias emacs='emacs -nw'

# fzf (Homebrew)
if command -v brew >/dev/null 2>&1; then
  [[ -r "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]] && source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  [[ -r "$(brew --prefix)/opt/fzf/shell/completion.zsh"   ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi

# ---- Git helpers ----
# Delete all local branches except master/main/current branch
gbr() {
  local keep
  keep="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || return
  git branch \
    | sed 's/^[* ]*//' \
    | grep -vE "^(master|main|${keep})$" \
    | xargs -r git branch -D
}

# Pretty git log alias (only set if missing)
git config --global --get alias.lg >/dev/null 2>&1 || \
  git config --global alias.lg \
    "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias gsha="git rev-parse HEAD | tr -d '\n' | pbcopy"

# ---- Prompt (Powerlevel10k) ----
if command -v brew >/dev/null 2>&1; then
  P10K_THEME="$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -r "$P10K_THEME" ]] && source "$P10K_THEME"
else
  # Fallback if brew isn't available for some reason
  [[ -r /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme ]] && source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
fi

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
