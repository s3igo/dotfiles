SHELL := /bin/bash

PKG_DIR := ~/.dotfiles/packages
MAC_PKG := $(PKG_DIR)/mac
# MAC_PKG := $(PKG_DIR)/mac/minimum
LINUX_PKG := $(PKG_DIR)/linux

.PHONY: init
init:
	. ./bin/init.sh

.PHONY: link
link:
	bash ./bin/link.sh

.PHONY: update
update:
ifeq ($(shell uname),Darwin)
	type brew > /dev/null 2>&1 \
		&& echo "Updating Homebrew..." \
		&& brew update \
		&& brew upgrade \
		&& brew cleanup \
		&& brew doctor
	type mas > /dev/null 2>&1 \
		&& echo "Updating Mac App Store apps..." \
		&& mas upgrade 2> /dev/null
	type zsh > /dev/null 2>&1 \
		&& [ -f ~/.config/zsh/.zshrc ] \
		&& echo "updating zinit..." \
		&& zsh -c "source ~/.config/zsh/.zshrc && zinit update --all"
else ifeq ($(shell uname),Linux)
	type apt > /dev/null 2>&1 \
		&& echo "Updating apt..." \
		&& sudo apt update \
		&& sudo apt upgrade -y
endif

.PHONY: cli
cli:
ifeq ($(shell uname),Darwin)
	cat $(MAC_PKG)/tap.txt | xargs -I {} brew tap {}
	cat $(MAC_PKG)/brew.txt | xargs brew install
else ifeq ($(shell uname),Linux)
	type apt > /dev/null 2>&1 && cat $(LINUX_PKG)/apt.txt | xargs sudo apt install -y
endif

.PHONY: gui
gui:
ifeq ($(shell uname),Darwin)
	cat $(MAC_PKG)/cask.txt | xargs brew install --cask
	type mas > /dev/null 2>&1 || brew install mas
	cat $(MAC_PKG)/mas.txt | cut -d " " -f 1 | xargs mas install
endif

.PHONY: dump
dump:
ifeq ($(shell uname),Darwin)
	type brew > /dev/null 2>&1 \
		&& brew tap > $(MAC_PKG)/tap.txt \
		&& brew leaves | sed '/mas/d' > $(MAC_PKG)/brew.txt \
		&& brew list --cask > $(MAC_PKG)/cask.txt
	type mas > /dev/null 2>&1 \
		&& mas list | cut -d '(' -f 1 | sed -e 's/ *$$//' > $(MAC_PKG)/mas.txt
else ifeq ($(shell uname),Linux)
	type apt > /dev/null 2>&1 && apt list --installed | cut -d '/' -f 1 > $(LINUX_PKG)/apt.txt
endif

.PHONY: install
install:
	@make init
	@make link

.PHONY: sync
sync:
	@make update
	@make dump
