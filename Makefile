DOT_DIR := ~/.dotfiles

install:
	sh ./bin/install.sh

link:
	sh ./bin/link.sh

tool:
	brew bundle --file $(DOT_DIR)/brew/tool.rb

mac_light:
	[ "$(uname)" = 'Darwin' ] && brew bundle --file $(DOT_DIR)/brew/mac_light.rb

lang:
	sh .bin/lang_z.sh