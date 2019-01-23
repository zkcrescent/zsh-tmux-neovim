## If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/root/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
ZSH_DISABLE_COMPFIX="true"
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
plugins=(yum git autojump zsh-syntax-highlighting brew  zsh-autosuggestions  docker)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# export SSH_KEY_PATH="~/.ssh/rsa_id"
ZSH_HIGHLIGHT_STYLES[comment]=fg=yellow
export TERM="xterm-256color"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"

# alias ohmyzsh="mate ~/.oh-my-zsh"
fpath=( "$HOME/.zfunctions" $fpath )
HOMEBREW_NO_AUTO_UPDATE=1
export PYENV_ROOT=/root/.pyenv
export ETCDCTL_API=3
export EDITOR=nvim
export GO111MODULE=off
export GIT_EDITOR="nvim"
alias ls="ls -al --color"
alias pc="export http_proxy=http://127.0.0.1:1081;export https_proxy=http://127.0.0.1:1081;"
alias upc="unset http_proxy;unset https_proxy;"
alias torun="cd ~/go/src/git.elenet.me/codedeploy/ice-runtime"
alias des="cd ~/Desktop"
alias code="code ."
alias vendor="GO111MODULE=on go mod vendor"
alias tidy="GO111MODULE=on go mod tidy"
alias mod="export GO111MODULE=on"
alias umod="export GO111MODULE=off"
alias goget="GO111MODULE=on go get"
alias vim="nvim"
alias togo="cd ~/go/src"
alias tomesos="cd ~/go/src/git.elenet.me/mesosmisc"
alias tokpi="cd ~/go/src/git.elenet.me/tools-kpi"
alias ls="ls -al --color=auto"
export GOPATH="/root/go"
export PATH=$PATH:$GOPATH"/bin:/usr/local/go/bin/"
alias rabc="rabbitmqctl"
alias clearlog="rm -f surge-info* surge-error*"
alias toci="cd ~/go/src/git.elenet.me/codedeploy/ice"
alias gobuild="go build -i -v"
alias totest="cd ~/go/src/test"
alias toyaml="cd ~/go/src/git.elenet.me/codedeploy/ice-yaml"
alias toagent="cd ~/go/src/git.elenet.me/codedeploy/ice-agent"
alias toekube="cd ~/go/src/git.elenet.me/appos/eprockube"
alias toplugin="cd ~/go/src/git.elenet.me/codedeploy"
alias dockerCleanC="docker ps --filter "status=exited" | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm"
export PATH="/root/.pyenv/bin:$PATH"
# alias docker cmd
alias dnc="docker network create"
alias dnr="docker network rm"
alias dnl="docker network ls"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)" pyenv no more virtualenv-init
autoload -U promptinit; promptinit
# optionally define some options
#PURE_CMD_MAX_EXEC_TIME=5
prompt pure

# disable software flow control
stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
