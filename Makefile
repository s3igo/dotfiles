include ~/.dotfiles/var.sh

CLI_DIR := $(PKG_DIR)/cli
GUI_DIR := $(PKG_DIR)/gui

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

update:
	bash -c './bin/update.sh'

cli:
	cat $(CLI_DIR)/tap.txt | xargs -I {} brew tap {}
	cat $(CLI_DIR)/brew.txt | xargs brew install
	cat $(CLI_DIR)/asdf.txt | xargs -I {} asdf plugin-add {}
	cat $(CLI_DIR)/asdf.txt | xargs -I {} asdf install {} latest

gui:
ifeq ($(shell uname),Darwin)
	cat $(GUI_DIR)/cask.txt | xargs brew install --cask
	cat $(GUI_DIR)/mas.txt | cut -d " " -f 1 | xargs mas install
endif

code:
	cat $(PKG_DIR)/code.txt | xargs -I {} code --install-extension {}

dump:
	brew tap > $(CLI_DIR)/tap.txt
	brew leaves > $(CLI_DIR)/brew.txt
	asdf plugin-list > $(CLI_DIR)/asdf.txt
	brew list --cask > $(GUI_DIR)/cask.txt
	mas list > $(GUI_DIR)/mas.txt
	code --list-extensions > $(PKG_DIR)/code.txt
