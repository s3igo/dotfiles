BREW_DIR := ~/.dotfiles/brew

install:
	sh ./bin/install.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(BREW_DIR)/tool.rb
	git config --global ghq.root '~/src'

mac_light:
	[ "$(uname)" = 'Darwin' ] && brew bundle --file $(BREW_DIR)/mac_light.rb

lang:
	sh ./bin/anyenv.sh
