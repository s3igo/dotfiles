# dotfiles

> **Warning**
> 動作確認してないのでちゃんと動くかわかりません

*ご利用は自己責任で!!*

多分バグまみれです...

## インストール

このリポジトリを自分のGitHubアカウントでフォークしてから

```shell
$ git clone https://github.com/<username>/dotfiles.git ~/.dotfiles

$ cd ~/.dotfiles

# brewとgitのインストールとバージョンアップ
$ make init

# 各シンボリックリンクを適切な場所に貼る
$ make link

# ---------------------------------- 以下オプション --------------------------------- #

# CLIツールをインストール
$ make tool

# nodenvをインストール
$ mv .env.example .env # グローバルに導入したいnodeのバージョンに応じて.envの内容を変更
$ make node

# 最低限のGUIアプリをインストール(macのみ可能)
$ make base

# 追加のGUIアプリをインストール(macのみ可能)
$ make full
```

## その他コマンド

```shell
# dotfilesをアップデート
$ make update

# make tool, make node, make baseを一括で実行できるやつ(macのみ可能)
$ make mac

# make tool, make node, make base, make fullを一括で実行できるやつ(macのみ可能)
$ make max
```

## 補足

- 実は`$ make update`は`$ git pull origin main`してるだけなので, 直接cloneせずにForkしてからお使いください
- フォントを`brew install --cask`を使って落としてきている都合上, `$ make base`を実行しない or 実行できない環境の場合, 手動で落とす必要がある(HackGenNerdとFiraCode)
- 一応自分用にclone, init, linkまでワンライナーでできるようにしてある

    ```shell
    $ bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/install.sh)"
    ```

    リモートにpushしない場合や, 自分で新しいリモート設定する場合はこれ使ってもらっても全然構いません
