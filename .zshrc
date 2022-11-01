# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="rickys"
# ZSH_THEME="jbergantine"
# ZSH_THEME="robbyrussell"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
DEFAULT_USER="Ricky"
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bundler)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=/usr/local/bin:$HOME/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
export PATH=/Users/rickydalziel/Library/Python/2.7/bin:$PATH

setup_keyboard () {
  # Get current value of keyboard accessibility (enabled = true , disabled = false)
  gsettings get org.gnome.desktop.a11y.keyboard enable
  # Get current value of slowkeys-enable
  gsettings get org.gnome.desktop.a11y.keyboard slowkeys-enable
  # Turn it off!
  gsettings set org.gnome.desktop.a11y.keyboard slowkeys-enable false

  # Get current value of stickykey-enable
  gsettings get org.gnome.desktop.a11y.keyboard stickykeys-enable
  # Turn it off!
  gsettings set org.gnome.desktop.a11y.keyboard stickykeys-enable false
  # Finally, turn the entire keyboard accessibility options off (this should disable the SHIFT key shortcuts)
  gsettings get org.gnome.desktop.a11y.keyboard enable false
}

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='exa'
alias ll='ls -lhatr'
alias l='ls -la'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias grep='grep --color=auto'
alias psa='ps uax'
alias vim='nvim'
alias v='vim .'

alias g='git'
alias zrc='vim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias vrc='vim ~/.vimrc'

alias swp='find . | grep .swp$'

alias rc='bundle exec rails c'
alias rs='bundle exec rails s'
alias be='bundle exec'
alias flt='cd ~/code/Float'

export NVM_DIR="/home/ricky/.nvm"

alias ag='ag --path-to-ignore ~/.ignore'

# export PATH="$HOME/.rbenv/bin:$PATH:$HOME/Library/Android/sdk/platform-tools"

eval "$(rbenv init -)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export PATH="/usr/lib/postgresql/12/bin:/home/ricky/bin/:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ricky/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ricky/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ricky/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ricky/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

setup_keyboard > /dev/null 2>&1
