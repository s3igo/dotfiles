# dotfiles

> **Warning**
> 動作確認してないのでちゃんと動くかわかりません

*ご利用は自己責任で!!*

## 注意

- デフォルトでは私（s3igo）のgitconfigが含まれているため、適宜`./others/.gitconfig`を書き換えてご使用ください
- このリポジトリをインストールすると、以下のファイルを書き換えます。書き換えられて困る場合は、安全な場所に退避させておいてください。
    - `~/.bash_profile`
    - `~/.bashrc`
    - `~/.zshenv`
    - `~/.vimrc`
    - `~/.tool-versions`
    - `~/.config/zsh/.zshrc`
    - `~/.config/zsh/.zshenv`
    - `~/.config/git/config`
    - `~/.config/git/ignore`
    - `~/.config/alacritty/alacritty.yml`
    - `~/.config/npm/npmrc`
    - `~/.config/tmux/tmux.conf`
    - vscodeの`settings.json, keybindings.json`の実体ファイル[^1]

## 対応環境

- mac
- Linux
- WSL2(Linux)

## 導入方法

このディレクトリをカスタマイズしてgitで管理したい場合、手動で導入（gitがある場合）をオススメします

### TL;DR

```shell
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/install.sh)"
```

これをターミナルにコピペしてエンター押すだけ。

### 手動で導入

#### 1. ダウンロード

- gitがない場合

    このリポジトリをzipでダウンロード -> 解凍 -> 解凍したディレクトリ（おそらく`dotfiles-main`という名前）を`.dotfiles`という名前に変更してホームディレクトリに配置
- gitがある場合

    このリポジトリを自分のGitHubアカウントでフォークしてからクローン（\<username\>に自分のGitHubのユーザ名を当てはめる）

    ```shell
    git clone https://github.com/<username>/dotfiles.git ~/.dotfiles
    ```

#### 2. インストール

dotfilesに移動

```shell
cd ~/.dotfiles
```

brewとgitのインストールとバージョンアップ

```shell
make init
```

CLIツールをインストール

```shell
make tool
```

各シンボリックリンクを適切な場所に貼る

```shell
make link
```

以下オプション

```shell
# ~/.tool-versionsに記載の言語・CLIツールをインストール
$ make lang

# 最低限のGUIアプリをインストール（macのみ可能）
$ make base

# 追加のGUIアプリをインストール（macのみ可能）
$ make full
```

## その他コマンド

```shell
# make tool, make node, make baseを一括で実行できるやつ（macのみ可能）
$ make mac

# make tool, make node, make base, make fullを一括で実行できるやつ（macのみ可能）
$ make max

# zinitとプラグインのアップデート
$ zinit update

# zinit.shに書かれていないプラグインの削除
$ zinit delete --clean

# asdfのプラグインのアップデート
$ asdf plugin-update --all
```

## 補足

- フォントを`brew install --cask`を使って落としてきている都合上、`$ make base`を実行しないor実行できない環境の場合、手動で落とす必要がある（HackGenNerd）
- TL;DRのワンライナーはmake initを実行、dotfilesをクローン、make toolを実行、make linkを実行の4つが実行される

[^1]: 実体ファイルのパスは、Macの場合`~/Library/Application\ Support/Code/User/`、Linuxの場合`~/.config/Code/User/`にある
