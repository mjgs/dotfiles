export PATH="/bin:/usr/bin:/sbin:/usr/sbin:/opt/X11/bin"

# Local configuration
source $HOME/.zshrc_local

# oh-my-zsh configuration
source ~/.oh-my-zshrc

# rvm configuration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# perlbrew configuration
source ~/perl5/perlbrew/etc/bashrc

# nvm configuration
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" # This loads nvm

# Z
. `brew --prefix`/etc/profile.d/z.sh

export EDITOR=$CONFIGS_DIR/dotfiles/bin/nvimf

# Tmuxinator
export DISABLE_AUTO_TITLE=true

# Aliases - General
alias ag='alias | grep'

# Aliases - Locations
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'

# Aliases - Configurations
alias zshrc='nvim ~/.zshrc'
alias zshrcl='nvim ~/.zshrc_local'
alias szshrc='source ~/.zshrc'
alias ohmyzshrc='nvim ~/.oh-my-zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias vimrc='nvim ~/.vimrc'
alias tmuxc='nvim ~/.tmux.conf'
alias npmrc='nvim ~/.npmrc'
alias brewc='cd /usr/local/etc; echo "Homebrew installed apps config directory:"; pwd; ll'

