# dotfiles

This repository contains shell configurations, a list of tools and applications to be installed, and their settings. It is intended to provide a reproducible environment when migrating machines and to maintain a history of the machine's configuration.

By default it contains my (s3igo's) configuration for [git](config/mac/HOME/.config/git/config.op), [ssh](config/mac/HOME/.ssh/config), etc., so please rewrite it accordingly.


> **Note**
> The `@` symbol indicates the project root directory

## Dependencies

- bash/zsh
- curl
- git
- make (GNU make)

## Installation[^1]

> **Warning**
> During installation, files in the `@/config` directory will overwrite files in your home directory. Please keep files in a safe place if you do not want them to be overwritten.

[^1]: If you want to customize and manage it with git, I recommend manually install.


```shell
curl -L raw.githubusercontent.com/s3igo/dotfiles/main/install.sh | bash
```

or manually

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
