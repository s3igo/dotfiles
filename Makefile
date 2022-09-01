include ~/.dotfiles/var.sh

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

update:
	bash -c './bin/update.sh'

brew:
	cat $(PKG_DIR)/brew/tap.txt | xargs -I {} brew tap {}
	cat $(PKG_DIR)/brew/brew.txt | xargs brew install

cask:
ifeq ($(shell uname),Darwin)
	cat $(PKG_DIR)/brew/cask.txt | xargs brew install --cask
endif

mas:
ifeq ($(shell uname),Darwin)
	cat $(PKG_DIR)/mas.txt | cut -d " " -f 1 | xargs mas install
endif

code:
	cat $(PKG_DIR)/code.txt | xargs -I {} code --install-extension {}

dump:
	brew tap > $(PKG_DIR)/tap.txt
	brew leaves > $(PKG_DIR)/brew.txt
	brew list --cask > $(PKG_DIR)/cask.txt
	mas list > $(PKG_DIR)/mas.txt
	code --list-extensions > $(PKG_DIR)/code.txt

gui:
	make cask
	make mas
