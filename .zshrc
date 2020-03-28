export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias fp='ps aux -ww | ag $1'
alias ctags="`brew --prefix`/bin/ctags"
alias gi='git log --all --oneline --color --decorate'
alias gg='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short --decorate'
alias glo='git log --oneline --no-merges master..'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias ls=lsd
alias la="ls -lah"
alias l="la"

alias rails="bundle exec rails"
alias rs="rails s"
alias rc="rails c"

alias gs="git status -s"
alias gd="git diff"
alias wip="git add .; git commit -m 'wip'; git push origin head"

unalias gp
gp() {

  if [ $# -eq 0 ]; then
    echo "Usage: gp MESSAGE"
    return
  fi

  message=$@

  git commit --all --short
  git add .
  git commit -m "$message"
  git push origin head
}

track(){
  git branch --set-upstream-to=origin/$(current_branch)
}
