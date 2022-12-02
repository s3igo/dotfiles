# dotfiles specification

## dependencies

- git
- make
- curl
- bash/zsh

macOSについて、これらはデフォルトでインストールされている
Linuxについても多くのパッケージマネージャでビルドなしに十分新しいバイナリを入手可能

## shell

zsh/bashに関して、環境変数`$SHELL`によって処理を分岐する。すなわち、dotfilesの責務にzshの追加インストールを含まない

## note

package, わざわざ別ディレクトリにしなくてもいいかも
あくまでtxtファイルなので容量圧迫しないし、わざわざべつディレクトリからcurlで引っ張ってくる方が冗長かもしれない
