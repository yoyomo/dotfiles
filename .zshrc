# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export GOPATH=$HOME/.go

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="mrtazz" # set by `omz`

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias fp='ps aux -ww | ag $1'
alias ctags="`brew --prefix`/bin/ctags"
alias gi='git log --all --oneline --color --decorate'
alias gg='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short --decorate'
alias glo='git log --oneline --no-merges master..'

if [ $USE_NODE ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  export PATH="$HOME/.nodeenv/bin:$PATH"
fi

if [ $USE_RUBY ]; then  
  if [[ -s $HOME/.rvm/scripts/rvm ]]; then
    source $HOME/.rvm/scripts/rvm;
  fi

  export PATH="$HOME/.rbenv/bin:$PATH"

  # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
  export PATH="$PATH:$HOME/.rvm/bin"
fi


alias ls=lsd
alias la="ls -lah"
alias l="la"

alias rails="bundle exec rails"
alias rs="rails s"
alias rc="rails c"

alias gs="git status -s"
alias gd="git diff"
alias gds="git --no-pager diff --stat"
alias gsd="gds"
alias wip="git add .; git commit -m 'wip'; git push origin head"

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Copies the first file of a Git Merge Conflict
alias gmc="gs | grep UU | head -n 1 | cut -c 4- | pbcopy; pbpaste"

unalias gp
gp() {

  if [ $# -eq 0 ]; then
    echo "Usage: gp MESSAGE"
    return
  fi

  message=$@

  git --no-pager diff --stat
  git commit --all --short
  git add .
  git commit -m "$message"
  git push origin head
}

track(){
  git branch --set-upstream-to=origin/$(current_branch)
}

gu() {

  if [ $# -eq 0 ]; then
    echo "Usage: gu BRANCH"
    return
  fi

  current_branch=$(current_branch)

  parent=$@

  git checkout $parent
  git pull
  git checkout $current_branch
  git merge $parent
}

pkg_v() {
  echo $(cat package.json \
    | grep version \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g')
}

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# To download playlist call `yt -i PLAYLIST_ID`
# To download video call `yt VIDEO_ID`
alias yt="time yt-dlp --download-archive ../../downloaded.txt --merge-output-format mp4 -f \"bestvideo+bestaudio[ext=m4a]/best\" --embed-thumbnail --add-metadata --compat-options embed-thumbnail-atomicparsley -x --audio-format m4a"
alias update_dj_sets="python3 ~/.scripts/update_dj_sets.py"
# Count the number of files
alias count="ls -1 | wc -l"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
