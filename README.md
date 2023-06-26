# dotfiles

This repository contains shell configurations, a list of tools and applications to be installed, and their settings. It is designed to provide a reproducible environment when migrating machines and to maintain a history of the machine's configuration.

> **Note**
> By default it contains my configuration for [git](config/mac/HOME/.config/git/config.op), [ssh](config/mac/HOME/.ssh/config), etc., so please rewrite it accordingly.

## Requirements

Intended for installation on Mac or Linux.

- bash
- git
- zsh(Optional)  
Required to use [configured zsh plugins](config/common/HOME/.config/sheldon/plugins.toml)
- curl(Optional)  
Required to perform a [Quick install](#quick-installation) or to install [Homebrew ⎋](https://brew.sh/) on a Mac.
- GNU make(Optional)  
Required to run the [`make` commands](#usage) described below.

## Installation

Follow the [Quick install](#quick-installation) or [Manual install](#manual-installation) instructions.

> **Warning**
> During installation, files in the `config` directory will overwrite files in your home directory. Please keep files in a safe place if you do not want them to be overwritten.

> **Note**
> [Manual installation](#manual-installation) is recommended if you want to customize and manage using git.

### Quick installation

```shell
curl -L sh.s3igo.me | bash
```

### Manual installation

```shell
# after forking this repository
# 1. download
$ git clone https://github.com/<username>/dotfiles.git ~/.dotfiles

# 2. install
$ cd ~/.dotfiles
$ make install
```

## Usage

### Major commands


```shell
# run `make init` and `make link`
$ make install

# run `make cli` and `make gui`
$ make tools

# run `make update` and `make dump`
$ make sync

```
### Minor commands


```shell
# run `scripts/init.sh`
$ make init

# run `scripts/link.sh`
# re-create symbolic links
$ make link

# install CLI tools based on `package` directory
$ make cli

# install apps with GUI based on `package` directory
$ make gui

# update every package/plugin manager and its packages/plugins
$ make update

# reflects the current state of packages/plugins in the `package` directory
$ make dump

```

### Internal command

```shell
# set current profile to `PROFILE` variable
$ make profile
```

## MEMO: Commands

### tmux

- `<C-q>r`: reload config
- `<C-q><C-s>`: save tmux environment
- `<C-q><C-r>`: restore tmux environment
- `<C-q>I`: install plugins
- `<C-q>U`: update plugins
- `<C-q><M-u>`: uninstall plugins
- `$ tmux list-keys`: list key bindings


## License

[MIT](LICENSE)
