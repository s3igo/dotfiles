SHELL := /bin/bash

PKG_DIR := ~/.dotfiles/packages
MAC_PKG := $(PKG_DIR)/mac
# MAC_PKG := $(PKG_DIR)/mac/minimum
LINUX_PKG := $(PKG_DIR)/linux

TPM_PATH := $${XDG_DATA_HOME}/tmux/plugins/tpm

.PHONY: init
init:
	. ./bin/init.sh

.PHONY: link
link:
	bash ./bin/link.sh

.PHONY: update
update:
ifeq ($(shell uname),Darwin)
ifeq ($(shell type brew > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && brew is installed
	brew update
	-brew upgrade
	brew cleanup
	brew doctor
endif
ifeq ($(shell type mas > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && mas is installed
	-mas upgrade
endif
else ifeq ($(shell uname),Linux)
ifeq ($(shell type apt > /dev/null 2>&1 && echo $$?),0)
	@# uname == Linux && apt is installed
	sudo apt update
	sudo apt upgrade -y
endif
endif
ifeq ($(shell type zsh > /dev/null 2>&1 && echo $$?),0)
ifneq ("$(wildcard $(HOME)/.config/zsh/.zshrc)","")
ifeq ($(shell type sheldon > /dev/null 2>&1 && echo $$?),0)
	@# zsh is installed && .zshrc exists && sheldon is installed
	zsh -c "source ~/.config/zsh/.zshrc && sheldon lock --update"
endif
endif
endif
ifeq ($(shell type tmux > /dev/null 2>&1 && echo $$?),0)
	@# tmux is installed
	tmux run "$(TPM_PATH)/bin/update_plugins all"
	# also run this command to remove unloaded plugins:
	# `$ tmux run "${XDG_DATA_HOME}/tmux/plugins/tpm/bin/clean_plugins"`
	# or `<C-q><M-u>` in tmux
endif

.PHONY: cli
cli:
ifeq ($(shell uname),Darwin)
	@# uname == Darwin
	cat $(MAC_PKG)/tap.txt | xargs -I {} brew tap {}
	cat $(MAC_PKG)/brew.txt | xargs brew install
else ifeq ($(shell uname),Linux)
ifeq ($(shell type apt > /dev/null 2>&1 && echo $$?),0)
	@# uname == Linux && apt is installed
	cat $(LINUX_PKG)/apt.txt | xargs sudo apt install -y
endif
endif

.PHONY: gui
gui:
ifeq ($(shell uname),Darwin)
	@# uname == Darwin
	cat $(MAC_PKG)/cask.txt | xargs brew install --cask
ifeq ($(shell type mas > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && mas is installed
	cat $(MAC_PKG)/mas.txt | cut -d " " -f 1 | xargs mas install
endif
endif

.PHONY: dump
dump:
ifeq ($(shell uname),Darwin)
ifeq ($(shell type brew > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && brew is installed
	brew tap > $(MAC_PKG)/tap.txt
	brew leaves | sed '/mas/d' > $(MAC_PKG)/brew.txt
	brew list --cask > $(MAC_PKG)/cask.txt
endif
ifeq ($(shell type mas > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && mas is installed
	mas list | cut -d '(' -f 1 | sed -e 's/ *$$//' > $(MAC_PKG)/mas.txt
endif
else ifeq ($(shell uname),Linux)
ifeq ($(shell type apt > /dev/null 2>&1 && echo $$?),0)
	@# uname == Linux && apt is installed
	apt list --installed | cut -d '/' -f 1 > $(LINUX_PKG)/apt.txt
endif
endif

.PHONY: install
install:
	@$(MAKE) init
	@$(MAKE) link

.PHONY: sync
sync:
	@$(MAKE) update
	@$(MAKE) dump
