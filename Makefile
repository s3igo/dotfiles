BREW_DIR := ~/.dotfiles/brew

install:
	sh ./bin/install.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(BREW_DIR)/tool.rb

mac_light:
	[ "$(uname)" = 'Darwin' ] && brew bundle --file $(BREW_DIR)/mac_light.rb

lang:
	sh .bin/lang_z.sh