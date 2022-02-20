export PATH=/usr/local/bin/python3:$PATH
#export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/Users/jeremystanley/src/jsonnet-mode/
export PATH=$PATH:/Users/jeremystanley/src/diff-so-fancy/


# Prompt formatting from https://github.com/jimeh/git-aware-prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\u@\[\$txtgrn\]\h\[\$txtrst\] \W \[\$txtcyn\]\$git_branch\[\$txtred\]\$git_dirty\[\$txtrst\]\$ "

# For emacs version brew installed
alias emacs="/usr/local/Cellar/emacs/27.1/bin/emacs"

# Quality DB Schema & Demo DB
export DG_DEMO_DB=postgres

# Easy way to run jsonnet with all the environmental variables set as extVars
# (like Data|Gravity does)
function jsonnet {
    ENV_VARS=`env | sed -e"s/^/ --ext-str /" | cut -d"=" -f1 | xargs`

    /usr/local/bin/jsonnet ${ENV_VARS} $@
}

# For PSQL
export PSQL_EDITOR="/usr/local/Cellar/emacs/26.1_1/bin/emacs"

# Git aliases
alias gbr="git branch | grep -v "master" | xargs git branch -D"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias gsha="git rev-parse HEAD | tr -d '\n' | pbcopy"

# Functions for running unit tests
function pt() { python -m unittest tests.unit.$1; }
function ptw() { python manage.py test tests.unit.$1; }

function pt_db() {
    CURR=$DG_DEMO_DB
    echo "Testing on: $1"    
    export DG_DEMO_DB=$1
    python -m unittest tests.unit.$2
    echo "resetting backend to $CURR"    
    export DG_DEMO_DB=$CURR
    }

function pt_all() {
    CURR=$DG_DEMO_DB
    for BACKEND in postgres redshift bigquery snowflake presto athena databricks
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Applications/google-cloud-sdk/path.bash.inc' ]; then . '/Applications/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Applications/google-cloud-sdk/completion.bash.inc' ]; then . '/Applications/google-cloud-sdk/completion.bash.inc'; fi
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="/usr/local/opt/node@12/bin:$PATH"

# For cmdstan
export STAN_BACKEND=CMDSTANPY
