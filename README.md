# Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository contains my personal dotfiles - a collection of shell configurations, tools, applications, and their settings. It's designed to provide a reproducible environment when moving between machines and to maintain a history of my machine's configuration.

## 🌟 Features

- Shell configurations (Fish, Zsh)
- Nix-based package management
- Reproducible environment setup
- macOS and Linux support
- SKK (Simple Kana to Kanji conversion) dictionary management

## 🎯 Design Principles

- **Simplicity**: The codebase is kept small to ensure effective management and maintainability, reducing maintenance costs.
- **Portability**: The configuration is portable and can be used across different machines, with special attention given to ease of use in Docker containers.
- **Minimalism**: Only carefully selected packages are used to minimize dependencies.

## 🔧 Requirements

- [Nix](https://nixos.org) (requires `extra-experimental-features = nix-command flakes` to be enabled)
- [MacSKK](https://github.com/mtgto/macSKK) (macOS only)

## 🚀 Quick Start

> [!Warning]
> When deploying, files in the `$HOME` and `~/.config` directories will be overwritten. Please back up your important files before proceeding to prevent data loss.

### Quick Deploy for macOS

```shell
nix run github:s3igo/dotfiles <host_name> <user_name>
```

### Standard Installation

1. Clone the repository:
   ```shell
   nix run github:s3igo/dotfiles#clone
   ```

2. Deploy the configuration:
   ```shell
   nix run ~/.dotfiles#deploy
   ```

## 🛠 Usage

To update and upgrade flake inputs, run:

```shell
nix flake update --commit-lock-file
```

### Available Commands

The following commands are provided in the default devShell to help manage your environment:

```shell
Available commands:

## Development

  , fmt             : Format code with treefmt
  , preview:rio     : Preview rio config
  , preview:zellij  : Preview zellij config

## IME

  , cleanup-skk-dicts  : Remove installed SKK dictionaries
  , install-skk-dicts  : Install SKK dictionaries

## System

  , deploy        : Deploy system configuration
  , versions      : Show system profile version differences
  , wipe-history  : Clear profile history for system and home-manager
```

## 📁 Repository Structure

- `home/`: Houses configuration files for various tools and applications
- `modules/`: Contains Nix modules that define system-wide configurations
- `packages/`: Hosts custom Nix packages specific to this setup
- `neovim-config/`: Standalone Neovim configuration (available as a separate flake at `github:s3igo/dotfiles?dir=neovim-config`)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) for details.
