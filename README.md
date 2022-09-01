# dotfiles

> **Warning**
> 動作確認してないのでちゃんと動くかわかりません

*ご利用は自己責任で!!*

## 注意

- デフォルトでは私（s3igo）のgitconfigが含まれているため、適宜`./home/.config/git/config`を書き換えてご使用ください
- このリポジトリをインストールすると、`./home`以下のファイルが、インストール先の`$HOME`以下のファイルを上書きします。
    書き換えられて困るファイルが存在する場合は、安全な場所に退避させておいてください。
    - ./home/_vscode以下の`settings.json, keybindings.json`は、これらの実体ファイル[^1]を指します

## 対応環境

- mac(X86_64)
- mac(arm64)
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

    このリポジトリをzipでダウンロード -> 解凍 -> `.dotfiles`という名前に変更してホームディレクトリに配置

- gitがある場合

    このリポジトリを自分のGitHubアカウントでフォークしてからクローン

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

言語のランタイムとCLIツールをインストール

```shell
make cli
```

各シンボリックリンクを適切な場所に貼る

```shell
make link
```

以下オプション（macのみ可能）

GUIツールをインストール

```shell
make gui
```

VS Codeに拡張機能をインストール

```shell
make code
```

## その他コマンド

```shell
# 各種パッケージ/プラグインマネージャのアップデート
$ make update

# 現環境を`~/.dotfiles/pkg/*`に反映
$ make dump
```

## 補足

- フォントを`brew install --cask`を使って落としてきている都合上、Linuxの場合、手動で入手する必要があるかも（udev-gothic-nf）
- TL;DRのワンライナーは`make init`を実行、dotfilesをクローン、`make cli`を実行、`make link`を実行の4つが実行される（`./bin/install.sh`を参照）

[^1]: 実体ファイルのパスは、Macの場合`~/Library/Application\ Support/Code/User/`、Linuxの場合`~/.config/Code/User/`にある
