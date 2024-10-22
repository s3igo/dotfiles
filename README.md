# Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository contains my personal dotfiles - a collection of shell configurations, tools, applications, and their settings. It's designed to provide a reproducible environment when migrating between machines and to maintain a history of my machine's configuration.

## 🌟 Features

- Shell configurations (Fish, Zsh)
- Nix-based package management
- Reproducible environment setup
- MacOS and Linux support
- SKK (Simple Kana to Kanji conversion) dictionary management

## 🎯 Design Principles

- **Simplicity**: The codebase is kept small to ensure effective management and maintainability, reducing maintenance costs.
- **Portability**: The configuration is portable and can be used across different machines, with special attention given to ease of use in Docker containers.
- **Minimalism**: Dependencies are kept to a minimum, using only carefully selected packages.

## 🔧 Requirements

- [Nix](https://nixos.org/download.html)
- [MacSKK](https://github.com/mtgto/macSKK) (MacOS only)

## 🚀 Quick Start

> [!Warning]
> When deploying, files in the `$HOME` and `~/.config` directories will be overwritten. Make sure to back up any important files to avoid data loss.

### Deploy Without Installation (MacOS)

```shell
nix run github:lnl7/nix-darwin -- switch --flake github:s3igo/dotfiles#<host_name>
```

### Full Installation

1. Clone the repository:
   ```shell
   nix run github:s3igo/dotfiles#clone
   ```

2. Navigate to the dotfiles directory:
   ```shell
   cd ~/.dotfiles
   ```

3. Deploy the configuration:
   ```shell
   nix run .#deploy
   ```

## 🛠 Usage

Here are some common commands you can use:

```shell
# Update flake inputs and commit the lock file
nix flake update --commit-lock-file

# Delete previous configurations
nix run .#wipe-history

# Show differences from the previous version
nix run .#versions

# Install SKK dictionaries
nix run .#install-skk-dicts

# Clean up SKK dictionaries
nix run .#cleanup-skk-dicts
```

## 📁 Repository Structure

- `home/`: Contains configuration files for various tools and applications
- `modules/`: Nix modules for system configuration
- `packages/`: Custom Nix packages
- `neovim-config/`: Neovim configuration files

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
