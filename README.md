# dotfiles

This repository contains shell configurations, a list of tools and applications to be installed, and their settings. It is intended to provide a reproducible environment when migrating machines and to maintain a history of the machine's configuration.

By default it contains my configuration for [git](config/mac/HOME/.config/git/config.op), [ssh](config/mac/HOME/.ssh/config), etc., so please rewrite it accordingly.

## Requirements

- bash
- git
- zsh(Optional)  
Required to use the [configured zsh plugin](config/common/HOME/.config/sheldon/plugins.toml)
- curl(Optional)  
Required to perform a [Quick install](#quick-install) or to install [Homebrew ⎋](https://brew.sh/) on a Mac.
- GNU make(Optional)  
Required to run the [`make` commands](#usage) described below.

## Installation

> **Warning**
> During installation, files in the `config` directory will overwrite files in your home directory. Please keep files in a safe place if you do not want them to be overwritten.

> **Note**
> If you want to customize and manage it with git, I recommend manually install.

### Quick install

```shell
curl -L raw.githubusercontent.com/s3igo/dotfiles/main/install.sh | bash
```

### manually install

```shell
# after forked this repository
# 1. download
$ git clone https://github.com/<username>/dotfiles.git ~/.dotfiles

# 2. install
$ cd ~/.dotfiles
$ make install
```

## Usage

```shell
# install CLI tools based on `./pkg/*`
$ make cli

# install GUI apps based on `./pkg/*`
$ make gui

# re-create symbolic links
$ make link

# update each package/plugin manager and its packages/plugins
$ make update

# reflects current environment in `./pkg/*`
$ make dump

# run `make update` & `make dump`
$ make sync
```

## Commands

### tmux

- `<C-q>r`: reload config
- `<C-q><C-s>`: save tmux environment
- `<C-q><C-r>`: restore tmux environment
- `<C-q>I`: install plugins
- `<C-q>U`: update plugins
- `<C-q><M-u>`: uninstall plugins
- `$ tmux list-keys`: list key bindings


## License

MIT
