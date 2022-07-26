# dotfiles

> **Warning**
> 動作確認してないのでちゃんと動くかわかりません

*ご利用は自己責任で!!*

## 対応環境

- mac
- Linux
- WSL2(Linux)

## 導入方法

このディレクトリをカスタマイズしてgitで管理したい場合、手動で導入(gitがある場合)をおすすめします

### TL;DR

```shell
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/install.sh)"
```

これをターミナルにコピペしてエンター押すだけ。

### 手動で導入

#### 1. ダウンロード

- gitがない場合

    このリポジトリをzipでダウンロード -> 解凍 -> 解凍したディレクトリ(おそらく`dotfiles-main`という名前)を`.dotfiles`という名前に変更してホームディレクトリに配置
- gitがある場合

    このリポジトリを自分のGitHubアカウントでフォークしてからクローン(\<username\>に自分のGitHubのユーザ名を当てはめる)

    ```shell
    git clone https://github.com/<username>/dotfiles.git ~/.dotfiles
    ```

#### 2. インストール

dotfilesに移動

```shell
cd ~/.dotfiles
```

`.env.example`を`.env`に名前を変更

```shell
mv .env.example .env
```

`.env`をよしなに編集して設定を変更

```shell
vi .env # お好きな方法で.envを編集
```

brewとgitのインストールとバージョンアップ

```shell
make init
```

各シンボリックリンクを適切な場所に貼る

```shell
make link
```

<hr>

以下オプション

```shell
# CLIツールをインストール
$ make tool

# nodenvをインストール
$ make node

# 最低限のGUIアプリをインストール(macのみ可能)
$ make base

# 追加のGUIアプリをインストール(macのみ可能)
$ make full
```

## その他コマンド

```shell
# make tool, make node, make baseを一括で実行できるやつ(macのみ可能)
$ make mac

# make tool, make node, make base, make fullを一括で実行できるやつ(macのみ可能)
$ make max
```

## 補足

- フォントを`brew install --cask`を使って落としてきている都合上, `$ make base`を実行しない or 実行できない環境の場合, 手動で落とす必要がある(HackGenNerdとFiraCode)
- TL;DRのワンライナーはinit.shを実行, dotfilesをクローン, link.shを実行の3つが実行される
