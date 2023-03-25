# dotfiles

## Attention

- By default, it contains my (s3igo's) config, so please rewrite accordingly.
    - git: `./home/.config/git/config`
    - ssh: `./home/.ssh/config` (using ssh agent by 1password)
    - zk: `declare -x ZK_NOTEBOOK_DIR="${HOME}/src/github.com/s3igo/notes"` in `./shell/config.sh` 
- When you install it, files under `./home` will overwrite files under your home directory.
  If there are files that you do not want to be overwritten, please stash them in a safe place.

## Dependencies

- bash/zsh
- curl
- git
- make (GNU make)

## Installation[^1]

```shell
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/install.sh)"
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

[^1]: If you want to customize and manage it with git, I recommend manually install.
