include ~/.dotfiles/var.sh

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

update:
	bash -c './bin/update.sh'

brew:
	cat $(PKG_DIR)/brew.txt | xargs brew install

asdf:
	cat $(PKG_DIR)/asdf.txt | xargs -I {} asdf plugin-add {} || true && asdf install

cask:
ifeq ($(shell uname),Darwin)
	cat $(PKG_DIR)/cask.txt | xargs brew install --cask
endif

mas:
ifeq ($(shell uname),Darwin)
	cat $(PKG_DIR)/mas.txt | xargs mas install
endif

code:
	cat $(PKG_DIR)/code.txt | xargs code --install-extension

dump:
	brew leaves > $(PKG_DIR)/brew.txt
	brew list --cask > $(PKG_DIR)/cask.txt
	mas list > $(PKG_DIR)/mas.txt
	asdf plugin-list > $(PKG_DIR)/asdf.txt
	code --list-extensions > $(PKG_DIR)/code.txt

CLI:
	brew asdf

GUI:
	cask mas
