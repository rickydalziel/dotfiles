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
export ANSIBLE_NOCOWS=1
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

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
alias ls='ls -G'
alias ll='ls -lhatr'
alias l='ls -la'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias grep='grep --color=auto'
alias psa='ps uax'
alias v='vim .'

alias 1pc='~/1partCarbon'
alias personal='~/personal'
alias 1pcgo='~/1partCarbon/go/src/github.com/1partCarbon/'

alias g='git'
alias vim='nvim'
alias zrc='vim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias vrc='vim ~/.vimrc'

alias swp='find . | grep .swp$'
alias ctags="`brew --prefix`/bin/ctags"

alias rc='bundle exec rails c'
alias rs='bundle exec rails s'
alias be='bundle exec'

alias ctg='ctags -R -f tags'

alias pw='ansible-vault view ~/.pw.yml'
alias pwedit='ansible-vault edit ~/.pw.yml'

alias fs='foreman start'
alias canary='open -a Google\ Chrome\ Canary --args --disable-web-security --user-data-dir=$HOME/Library/Application\ Support/Google/Chrome\ Canary/'

export GOPATH=$HOME/1partCarbon/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin:$GOBIN

export NVM_DIR="/Users/Ricky/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export ANDROID_HOME="/Users/Ricky/Library/Android/sdk"
export ANDROID_SDK_ROOT="/Users/Ricky/Library/Android/sdk"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

export PATH="$HOME/.rbenv/bin:$PATH:$HOME/Library/Android/sdk/platform-tools"
eval "$(rbenv init -)"
