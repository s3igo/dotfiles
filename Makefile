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

full:
	[ "$(uname)" = 'Darwin' ] && brew bundle --file $(BREW_DIR)/full.rb

lang:
	sh ./bin/anyenv.sh

mac:
	tool base lang

max:
	tool base full lang
