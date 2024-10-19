# dotfiles

This repository contains shell configurations, a list of tools and applications to be installed, and their settings.
It is designed to provide a reproducible environment when migrating machines and to maintain a history of the machine's configuration.

## Design Principles

- **Simplicity**\
    The code base is kept small to ensure effective management and maintainability. This helps to reduce maintenance costs.
- **Portability**\
    The configuration is portable and can be used across different machines. Special attention is given to ease of use in Docker containers.
- **Minimalism**\
    Dependencies are kept to a minimum, using only carefully selected packages.

## Requirements

- Nix
- [MacSKK](https://github.com/mtgto/macSKK) (MacOS only)

> [!Warning]
> When deploying, files in the `$HOME` and `~/.config` directories will be overwritten. Make sure to back up any important files to avoid data loss.

## Deploy Without Installation

```shell
# MacOS
nix run github:lnl7/nix-darwin -- switch --flake github:s3igo/dotfiles#<host_name>
```

## Usage

```shell
# Clone the repository
$ nix run github:s3igo/dotfiles#clone

# After cloning, navigate to the directory
$ cd ~/.dotfiles

# Deploy configuration
$ nix run .#deploy

# Delete previous configurations
$ nix run .#wipe-history

# Show differences from the previous version
$ nix run .#versions

# Install SKK dictionaries
$ nix run .#install-dicts

# Clean up SKK dictionaries
$ nix run .#cleanup-skk-dicts
```

## License

[MIT](LICENSE)
