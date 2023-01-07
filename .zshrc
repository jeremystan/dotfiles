# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Begin from Leo

# Snappy escape
export KEYTIMEOUT=1

# History
setopt INC_APPEND_HISTORY        # Share history between all sessions.

HISTSIZE=50000                   # The maximum number of events to save in the internal history.
SAVEHIST=50000                   # The maximum number of events to save in the history file.

# This is for fzf fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## End from Leo

# Run emacs in "no window" mode
alias emacs='emacs -nw'

# Git configuration
git config pull.rebase false

# Git aliases
alias gbr="git branch | grep -v "master" | xargs git branch -D"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias gsha="git rev-parse HEAD | tr -d '\n' | pbcopy"

# Testing aliases
alias pturl="tac logs/test.log | grep \"'exec_summary_url':\" --max-count 1"


# Postgres is the fastest default DB
export DG_DEMO_DB=postgres

# Run dquality unit tests using pt <test>
function pt() { python -m unittest tests.unit.$1; }

# Run www tests in www directory using ptw <test>
function ptw() { python manage.py test tests.unit.$1; }

# Run a test on a specific DB and then switch back using pt_db <DB> <test>
function pt_db() {
    CURR=$DG_DEMO_DB
    echo "Testing on: $1"
    export DG_DEMO_DB=$1
    python -m unittest tests.unit.$2
    echo "resetting backend to $CURR"
    export DG_DEMO_DB=$CURR
}

# Run a test across _all_ DBs using pt_all <DB> <test>
function pt_all() {
    CURR=$DG_DEMO_DB
    for BACKEND in postgres redshift bigquery snowflake presto athena databricks synapse
    do
	echo "Testing on: $BACKEND"
	export DG_DEMO_DB=$BACKEND
	python -m unittest tests.unit.$1
    done
    echo "resetting backend to $CURR"
    export DG_DEMO_DB=$CURR
}

function dg_query() {
    ./dg query exec --config demos/tickit/db.jsonnet "$@";
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/powerlevel10k/powerlevel10k.zsh-theme ] && . ~/powerlevel10k/powerlevel10k.zsh-theme

export ANOMALO_DISABLE_MULTIPROCESSING=true
