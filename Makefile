PKG_DIR := ~/.dotfiles/lib/pkg

.PHONY: link

init:
	. ./bin/init.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(PKG_DIR)/tool.rb

lang:
	which asdf > /dev/null 2>&1 \
		&& asdf plugin-add nodejs \
		&& asdf install \
		&& corepack enable yarn \
		&& asdf reshim nodejs

base:
ifeq ($(shell uname), Darwin)
	brew bundle --file $(PKG_DIR)/base.rb
endif

full:
ifeq ($(shell uname), Darwin)
	brew bundle --file $(PKG_DIR)/full.rb
	which mas > /dev/null 2>&1 || brew install mas
	cat $(PKG_DIR)/app.txt \
		| cut -d ' ' -f 1 \
		| xargs -I % mas install %
endif

mac:
	lang base

max:
	lang base full
