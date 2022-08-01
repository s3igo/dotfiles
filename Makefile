BREW_DIR := ~/.dotfiles/brew

init:
	. ./bin/init.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(BREW_DIR)/tool.rb

lang:
	which asdf > /dev/null 2>&1 \
		&& asdf plugin-add nodejs \
		&& asdf install \
		&& corepack enable yarn \
		&& asdf reshim nodejs

base:
	ifeq ($(shell uname), Darwin)
		brew bundle --file $(BREW_DIR)/base.rb
	endif

full:
	ifeq ($(shell uname), Darwin)
		brew bundle --file $(BREW_DIR)/full.rb
	endif

mac:
	lang base

max:
	lang base full
