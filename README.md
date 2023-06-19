# dotfiles

## Attention

- By default, it contains my (s3igo's) config, so please rewrite it accordingly.
    - git: `./home/.config/git/config`
    - ssh: `./home/.ssh/config` (using ssh agent by 1password)
- During installation, files in the `./home` directory will overwrite files in your home directory.
  Please keep files in a safe place if you do not want them to be overwritten.

## Dependencies

- bash/zsh
- curl
- git
- make (GNU make)

## Installation[^1]

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
