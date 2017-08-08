# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="cobalt2"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="/usr/local/Cellar/vim/8.0.0134_2/bin/vim"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github gitignore rake ruby rvm brew sudo sublime sudo ssh-agent node nvm npm osx rails)

#source $ZSH/oh-my-zsh.sh

# User configuration

#export PATH="/Users/pradeep/.rbenv/shims:/Users/pradeep/.rbenv/bin:/Users/pradeep/.bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="rbates"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

export PATH="$HOME/.bin:$PATH"
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init - --no-rehash)"
#
# Adding git functions https://github.com/Prelang/g
#source $HOME/.g/g.zsh
# Personal stuff
setup() {
  vim ~/setup/
}

bank() {
  less ~/.random.css
}

# Function to change directory and display the current rvm gemset group
chp() {
  cd "$*";
  echo "Project name: `basename "$PWD"`";
  echo "git branch: `git branch | sed -n -e 's/^\* \(.*\)/\1/p'`";
  echo "ruby gemset: `rvm current`";
}

# Function to reload rvmrc
renv() { rvm use `cat .ruby-version`; echo "ruby gemset:"; echo `rvm current`; }

# Function to reload zshrc
rzsh() {
  source ~/.zshrc;
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

lolcat() {
  /Users/deepu/.rvm/gems/ruby-2.1.2/bin/lolcat
}

# Show a random word with meaning using cowsay whenever you open a new tab
nword() {
  gshuf -n 1 ~/.words | cowsay
}

nword

gs() {
  git status
}

gpl() {
  git pull | lolcat
}

dict() {
  python ~/.dict $1 | cowsay | lolcat
}

vv() {
  fortune | cowsay | lolcat
}

export NVM_DIR="/Users/deepu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# See which folder is being the storage hog!
alias fat='/usr/bin/du -s * .* | sort -n'

# OpenSSL issue work around
#export SSL_CERT_FILE=/Users/deepu/.rvm/cacert.pem

dk () {
 docker $argv
}

dklean() {
  dk rmi -f $(dk images | grep "<none>" | awk '{ print $3 }')
}

dkenv() {
  eval "$(docker-machine env default)"
}

minidkenv() {
	eval "$(minikube docker-env)"
}

HISTIGNORE='ignorespace:* random:setup:bank'

kgp () {
  kubectl get pods $argv
}

kdp () {
  kubectl describe pods $argv
}

kdr () {
  kubectl describe rc $argv
}

kds () {
  kubectl describe services $argv
}

kdsec() {
  kubectl describe secrets $argv
}

kgs () {
  kubectl get services $argv
}

kgr () {
  kubectl get rc -o wide $argv
}

gcil () {
  gcloud compute instances list $argv
}

gccl () {
  gcloud container clusters list $argv
}

gdp () {
  gcloud docker push $argv
}

kgsec () {
  kubectl get secrets $argv
}

kdesc () {
  kubectl describe $argv
}

k () {
  kubectl $argv
}

envtokuber() {
  ruby ~/setup/kuberenv.rb $argv
}

vgrep() {
  grep $argv | grep -v $argv
}

kbash() {
  POD_NAME=$(kubectl get pods | grep $1 | awk '{ print $1 }')
  CONTAINERS=$(kubectl get rs -o wide | awk '{ print $5 }' | sed '1d')

  if [[ -z "$CONTAINERS" ]]; then
    CONTAINERS=$(kubectl get rc -o wide | awk '{ print $5 }' | sed '1d')
  fi

  CONTAINERS=("${(@s/,/)CONTAINERS}")

  for i in $CONTAINERS; do
    if [[ $i =~ $2 ]]; then; CONT_NAME=$i; fi
  done

  echo "Logging on to /bin/bash shell of the container ${CONT_NAME} which belongs to the pod ${POD_NAME} ...."

  kubectl exec -it $POD_NAME -c $CONT_NAME /bin/bash
}

export GOPATH=$HOME/go-space
#. $HOME/.asdf/asdf.sh
#

# Phoenix shortcuts
mpr() {
  mix phoenix.routes $argv
}

mps() {
  mix phoenix.server $argv
}

mpc() {
  iex -S mix phoenix.server $argv
}

# added by travis gem
[ -f /Users/deepu/.travis/travis.sh ] && source /Users/deepu/.travis/travis.sh

gloud() {
  /Users/deepu/google-cloud-sdk/bin/gcloud $argv
}

export PATH=$PATH:/usr/local/m-cli

dsite() {
  wget --recursive --html-extension --page-requisites --convert-links $argv
}

pip() {
 /Users/deepu/Library/Python/2.7/bin/pip $argv
}

spotify-ripper() {
 /Users/deepu/Library/Python/2.7/lib/python/site-packages/spotify_ripper/main.py $argv
}

export PATH=$PATH:~/go-space/bin
export PATH=$PATH:/Users/deepu/go_appengine/

mygo() {
  cd $GOPATH/src/github.com/itsprdp
}

killspec() {
  kill -9 `ps aux | grep rspec | awk '{ print $2 }' | tail -n 1`
}

krescale() {
  kubectl scale deployment $1 --replicas=0 && kubectl scale deployment $1 --replicas=$2
}

# The next line updates PATH for the Google Cloud SDK.
source '/Users/deepu/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/deepu/google-cloud-sdk/completion.zsh.inc'

#export NVM_DIR="$HOME/.nvm"
  #. "/usr/local/opt/nvm/nvm.sh"

csqldumpklean() {
  SRC_FILE=$1
  echo 'Extracting the gzip file ...'
  gunzip $SRC_FILE
  I_FILE_NAME=`basename $SRC_FILE .gz`
  echo $FILE_NAME
  echo 'Removing the DB Headers from sql file ...'
  sed '22d' $I_FILE_NAME | sed '23d' > clean_file
  TMP_FILE=clean_file
  echo 'Removing the user info from sql file ...'
  perl -pi -e 's/\bDEFINER=.*?@.*?(?=[\*\s])//g' "${TMP_FILE}"
  gzip $TMP_FILE
  rm -f $I_FILE_NAME
  echo 'cleaning up ...'
  mv $TMP_FILE.gz ${I_FILE_NAME}_stripped.gz
}
