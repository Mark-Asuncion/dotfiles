export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
if [ -f "$HOME/.usr_conf" ] ; then
    source "$HOME/.usr_conf"
fi
