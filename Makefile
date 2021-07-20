install:
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	brew install rbenv
	brew install nodenv
	brew install lsd
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font

configure:
	mv -v ./* ~/

