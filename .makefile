install:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	brew install lsd
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font
  
	if [ ${USE_NODE} ]; then brew install nodenv; fi
	if [ ${USE_RUBY} ]; then brew install rbenv; fi

configure:
	mv -v ./* ~/

