BREW_DIR := ~/.dotfiles/brew

init:
	sh ./bin/init.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(BREW_DIR)/tool.rb
	git config --global ghq.root '~/src'

base:
	[ "$(uname)" = 'Darwin' ] && brew bundle --file $(BREW_DIR)/base.rb

lang:
	sh ./bin/anyenv.sh

