export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/opt/X11/bin"

# oh-my-zsh configuration
source ~/.oh-my-zshrc

# rvm configuration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# perlbrew configuration
source ~/perl5/perlbrew/etc/bashrc

# nvm configuration
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" # This loads nvm

# include Z, yo 
# http://bit.ly/1OFlBq3
. ~/z.sh

export EDITOR=~/dotfiles/bin/mvimf

# Aliases - General
alias t='tree -L 2'

# Aliases - Locations
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias cc='cd ~/codes'

# Aliases - Configurations
alias zshrc='mvim ~/.zshrc'
alias szshrc='source ~/.zshrc'
alias ohmyzshrc='mvim ~/.oh-my-zshrc'
alias ohmyzsh='mvim ~/.oh-my-zsh'
alias vimrc='mvim ~/.vimrc'
