# Install p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

ln -sf ${BASEDIR}/.p10k.zsh.sh ${HOME}/.p10k.zsh
ln -sf ${BASEDIR}/.zshrc.sh ${HOME}/.zshrc

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git --branch 0.29.0 ~/.fzf
~/.fzf/install --all --no-bash

chsh --shell /usr/bin/zsh

# git config
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"