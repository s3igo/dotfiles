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

min:
	init link

cli:
	init link tool

cli_lang:
	init link tool lang

mac:
	init link tool base

mac_lang:
	init link tool base lang
