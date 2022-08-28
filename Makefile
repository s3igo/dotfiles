include ~/.dotfiles/var.sh

init:
	. ./bin/init.sh

link:
	bash ./bin/link.sh

update:
	bash -c './bin/update.sh'

brew:
	type brew > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/brew.txt | xargs brew install

asdf:
	type asdf > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/asdf.txt | xargs asdf plugin-add \
		&& asdf install

# TODO: caskとmasの処理まとめてもいいかも
# appstoreへログインする処理とOSの確認の実装が必要
cask:
	type brew > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/cask.txt | xargs brew install --cask

mas:
	type mas > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/mas.txt | xargs mas install


code:
	type code > /dev/null 2>&1 \
		&& cat $(PKG_DIR)/code.txt | xargs code --install-extension

dump:
	type brew > /dev/null 2>&1 \
		&& brew leaves > $(PKG_DIR)/brew.txt \
		&& brew list --cask > $(PKG_DIR)/cask.txt
	type mas > /dev/null 2>&1 \
		&& mas list > $(PKG_DIR)/mas.txt
	type asdf > /dev/null 2>&1 \
		&& asdf plugin-list > $(PKG_DIR)/asdf.txt
	type code > /dev/null 2>&1 \
		&& code --list-extensions > $(PKG_DIR)/code.txt

CLI:
	brew asdf

GUI:
	cask mas
