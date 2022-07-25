BREW_DIR := ~/.dotfiles/brew

init:
	sh ./bin/init.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(BREW_DIR)/tool.rb
	git config --global ghq.root '~/src'

lang:
	sh ./bin/anyenv.sh

update:
	git pull origin main

base:
	ifeq ($(shell uname), Darwin)
		brew bundle --file $(BREW_DIR)/base.rb
	endif

full:
	ifeq ($(shell uname), Darwin)
		brew bundle --file $(BREW_DIR)/full.rb
	endif

mac:
	tool base lang

max:
	tool base full lang
