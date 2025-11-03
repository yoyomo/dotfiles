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

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

export PATH="$(brew --prefix)/opt/python3/libexec/bin:$PATH"

# Function to install Hack Nerd Font if not present
install_hack_nerd_font() {
  local font_name="Hack Nerd Font"
  local font_dir="$HOME/Library/Fonts"
  local temp_dir="/tmp/hack-nerd-font"
  
  # Check if Hack Nerd Font is already installed
  if ls "$font_dir"/*Hack*Nerd*Font*.ttf >/dev/null 2>&1 || ls "$font_dir"/*HackNerdFont*.ttf >/dev/null 2>&1; then
    return 0  # Font already installed
  fi
  
  echo "Hack Nerd Font not found. Installing..."
  
  # Create temporary directory
  mkdir -p "$temp_dir"
  cd "$temp_dir"
  
  # Get the latest release version from GitHub API
  echo "Fetching latest Hack Nerd Font version..."
  local latest_version=""
  nerd_font_url="https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest"
  if command -v curl >/dev/null 2>&1; then
    latest_version=$(curl -s "$nerd_font_url" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  elif command -v wget >/dev/null 2>&1; then
    latest_version=$(wget -qO- "$nerd_font_url" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  else
    echo "Error: Neither curl nor wget found. Cannot download Hack Nerd Font."
    return 1
  fi
  
  if [[ -z "$latest_version" ]]; then
    echo "Error: Could not fetch latest version. Using fallback version v3.1.1"
    latest_version="v3.1.1"
  else
    echo "Latest version found: $latest_version"
  fi
  
  # Download latest Hack Nerd Font release
  local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${latest_version}/Hack.zip"
  
  echo "Downloading Hack Nerd Font ${latest_version}..."
  if command -v curl >/dev/null 2>&1; then
    curl -L -o hack-nerd-font.zip "$download_url"
  elif command -v wget >/dev/null 2>&1; then
    wget -O hack-nerd-font.zip "$download_url"
  else
    echo "Error: Neither curl nor wget found. Cannot download Hack Nerd Font."
    return 1
  fi
  
  # Extract and install fonts
  if command -v unzip >/dev/null 2>&1; then
    unzip -q hack-nerd-font.zip
    # Install all TTF files (Hack Nerd Font files)
    cp *.ttf "$font_dir/" 2>/dev/null || true
    echo "Hack Nerd Font installed successfully!"
    echo "Available variants: Regular, Bold, Italic, Bold Italic"
    echo "Font name in applications: 'Hack Nerd Font' or 'HackNerdFont'"
  else
    echo "Error: unzip command not found. Cannot extract font files."
    return 1
  fi
  
  # Cleanup
  cd - >/dev/null
  rm -rf "$temp_dir"
}

# Install Hack Nerd Font if not present
install_hack_nerd_font

# Function to install Pathogen for Vim if not present
install_pathogen() {
  local vim_autoload_dir="$HOME/.vim/autoload"
  local vim_bundle_dir="$HOME/.vim/bundle"
  local pathogen_file="$vim_autoload_dir/pathogen.vim"
  
  # Check if Pathogen is already installed
  if [[ -f "$pathogen_file" ]]; then
    return 0  # Pathogen already installed
  fi
  
  echo "Pathogen not found. Installing Vim Pathogen..."
  
  # Create necessary directories
  mkdir -p "$vim_autoload_dir" "$vim_bundle_dir"
  
  # Download Pathogen
  if command -v curl >/dev/null 2>&1; then
    curl -LSso "$pathogen_file" https://tpo.pe/pathogen.vim
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$pathogen_file" https://tpo.pe/pathogen.vim
  else
    echo "Error: Neither curl nor wget found. Cannot download Pathogen."
    return 1
  fi
  
  if [[ -f "$pathogen_file" ]]; then
    echo "Pathogen installed successfully!"
    echo "Your .vimrc should now work without errors."
  else
    echo "Error: Failed to download Pathogen."
    return 1
  fi
}

# Install Pathogen if not present
install_pathogen

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
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"



# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

eval "$(pkgx --quiet dev --shellcode)"  # https://github.com/pkgxdev/dev
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/mandomac/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
