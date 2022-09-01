include ~/.dotfiles/var.sh

CLI_PKG := $(PKG_DIR)/cli
APP_PKG := $(PKG_DIR)/app

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

update:
	bash -c './bin/update.sh'

cli:
	cat $(CLI_PKG)/tap.txt | xargs -I {} brew tap {}
	cat $(CLI_PKG)/brew.txt | xargs brew install
	cat $(CLI_PKG)/asdf.txt | xargs -I {} asdf plugin-add {}
	cat $(CLI_PKG)/asdf.txt | xargs -I {} asdf install {} latest

app:
ifeq ($(shell uname),Darwin)
	cat $(APP_PKG)/cask.txt | xargs brew install --cask
	cat $(APP_PKG)/mas.txt | cut -d " " -f 1 | xargs mas install
endif

code:
	cat $(PKG_DIR)/code.txt | xargs -I {} code --install-extension {}

dump:
	brew tap > $(CLI_PKG)/tap.txt
	brew leaves > $(CLI_PKG)/brew.txt
	asdf plugin-list > $(CLI_PKG)/asdf.txt
	brew list --cask > $(APP_PKG)/cask.txt
	mas list > $(APP_PKG)/mas.txt
	code --list-extensions > $(PKG_DIR)/code.txt
