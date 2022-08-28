include ~/.dotfiles/var.sh

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

tool:
	brew bundle --file $(PKG_DIR)/tool.rb

lang:
	type asdf > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/asdf.txt | xargs asdf plugin-add \
		&& asdf install

code:
	type code > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/code.txt | xargs code --install-extension


base:
ifeq ($(shell uname), Darwin)
	brew bundle --file $(PKG_DIR)/base.rb
endif

full:
ifeq ($(shell uname), Darwin)
	brew bundle --file $(PKG_DIR)/full.rb
	type mas > /dev/null 2>&1 || brew install mas
	cat $(PKG_DIR)/app.txt | cut -d ' ' -f 1 | xargs mas install
endif

update:
	bash -c './bin/update.sh'

mac:
	lang base

max:
	lang base full
