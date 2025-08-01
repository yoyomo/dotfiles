# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
export PATH=/opt/homebrew/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.deno/bin:$PATH
export GOPATH=$HOME/.go
export HOMEBREW_AUTO_UPDATE_SECS=86400

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(rbenv init - zsh)"

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

export PATH="$(brew --prefix)/opt/python3/libexec/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="mrtazz" # set by `omz`

plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.iterm2_shell_integration.zsh

alias fp='ps aux -ww | ag $1'
alias ctags="`brew --prefix`/bin/ctags"
alias gi='git log --all --oneline --color --decorate'
alias gg='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short --decorate'
alias glo='git log --oneline --no-merges master..'

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
alias webstorm='open -na "WebStorm.app" --args "$@"'
alias pycharm='open -na "PyCharm Professional Edition.app" --args "$@"'
alias datagrip='open -na "DataGrip.app" --args "$@"'
alias rubymine='open -na "RubyMine.app" --args "$@"'
alias goland='open -na "GoLand.app" --args "$@"'
alias rustrover='open -na "RustRover.app" --args "$@"'

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
alias gup="gu pre-production"
alias gum="gu master"
alias gbc="git branch --merged master --no-color | grep -v 'master\|pre-production' | xargs git branch -d"

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
alias yt="time yt-dlp \
  --download-archive ../../downloaded.txt \
  -f bestaudio[ext=m4a] \
  --embed-thumbnail \
  --add-metadata \
  --compat-options embed-thumbnail-atomicparsley \
  -x --audio-format m4a"
alias create_venv="python3 -m venv ~/.venv"
alias enter_venv="source ~/.venv/bin/activate"
alias exit_venv="deactivate"
alias update_playlists="enter_venv; caffeinate -dims python3 ~/.scripts/update_playlists.py; exit_venv"
alias download_playlists="enter_venv; caffeinate -dims python3 ~/.scripts/download_playlists.py; exit_venv"
# Count the number of files
alias count="ls -1 | wc -l"

ln -sfn ~/Library/Mobile\ Documents/com~apple~CloudDocs/ ~/iCloudDrive


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"



# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

eval "$(pkgx --quiet dev --shellcode)"  # https://github.com/pkgxdev/dev
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
