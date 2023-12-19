SHELL := /usr/bin/env bash

include .env.example
-include .env

PKG_DIR := $(HOME)/.dotfiles/packages
MAC_PKG = $(PKG_DIR)/mac/$(PROFILE)
LINUX_PKG := $(PKG_DIR)/linux

.PHONY: profile
profile:
ifeq ("$(wildcard $(HOME)/.dotfiles/.env)","")
ifeq ($(shell uname),Darwin)
	@# `.env` does not exist && uname == Darwin
	$(eval PROFILES = $(notdir $(wildcard $(PKG_DIR)/mac/*)))
	$(eval HOSTNAME = $(shell hostname -s))
	$(if $(filter $(HOSTNAME),$(PROFILES)),$(eval PROFILE = $(HOSTNAME)))
endif
endif

.PHONY: init
init:
	source ./scripts/init.sh

.PHONY: link
link:
	./scripts/link.sh

.PHONY: update
update:
ifeq ($(shell uname),Darwin)
ifeq ($(shell type brew > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && brew is installed
	brew autoremove
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
	sheldon lock --update
endif
endif
endif

.PHONY: cli
cli: profile
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
gui: profile
ifeq ($(shell uname),Darwin)
	@# uname == Darwin
	cat $(MAC_PKG)/cask.txt | xargs brew install --cask
ifeq ($(shell type mas > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && mas is installed
	cat $(MAC_PKG)/mas.txt | cut -d " " -f 1 | xargs mas install
endif
endif

.PHONY: dump
dump: profile
ifeq ($(shell uname),Darwin)
ifeq ($(shell type brew > /dev/null 2>&1 && echo $$?),0)
	@# uname == Darwin && brew is installed
	brew tap > $(MAC_PKG)/tap.txt
	brew leaves > $(MAC_PKG)/brew.txt
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

.PHONY: deploy
deploy:
	darwin-rebuild switch --flake .#$(PROFILE)
	mkdir -p ${XDG_DATA_HOME}/zsh/site-functions
	gh completion -s zsh > ${XDG_DATA_HOME}/zsh/site-functions/_gh

.PHONY: deploy-without-cache
deploy-without-cache:
	darwin-rebuild switch --option eval-cache false --flake .#$(PROFILE)

.PHONY: update-nix
update-nix:
	nix flake update
	$(MAKE) deploy

.PHONY: history
history:
	darwin-rebuild --list-generations

.PHONY: gc
gc:
	nix store gc --max 5G

.PHONY: install
install:
	@$(MAKE) init
	@$(MAKE) link

.PHONY: tools
tools:
	@$(MAKE) cli
	@$(MAKE) gui

.PHONY: sync
sync:
	@$(MAKE) update
	@$(MAKE) dump
