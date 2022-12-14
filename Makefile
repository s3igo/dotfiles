PKG_DIR := ~/.dotfiles/pkg
MAC_PKG := $(PKG_DIR)/mac
LINUX_PKG := $(PKG_DIR)/linux

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

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
	type zinit > /dev/null 2>&1 \
		&& echo "updating zinit..." \
		&& zinit update --all
else ifeq ($(shell uname),Linux)
	type apt > /dev/null 2>&1 \
		&& echo "Updating apt..." \
		&& sudo apt update \
		&& sudo apt upgrade -y
endif

cli:
ifeq ($(shell uname),Darwin)
	cat $(MAC_PKG)/tap.txt | xargs -I {} brew tap {}
	cat $(MAC_PKG)/brew.txt | xargs brew install
else ifeq ($(shell uname),Linux)
	type apt > /dev/null 2>&1 && cat $(LINUX_PKG)/apt.txt | xargs sudo apt install -y
endif

gui:
ifeq ($(shell uname),Darwin)
	cat $(MAC_PKG)/cask.txt | xargs brew install --cask
	type mas > /dev/null 2>&1 || brew install mas
	cat $(MAC_PKG)/mas.txt | cut -d " " -f 1 | xargs mas install
endif

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

install:
	make init
	make link

sync:
	make update
	make dump
