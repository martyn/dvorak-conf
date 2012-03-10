all:update

install:
	@git submodule update --init
	@rm ~/.vim.backup.2 || true
	@mv ~/.vim.backup.1 ~/.vim.backup.2 || true
	@mv ~/.vim.backup ~/.vim.backup.1 || true
	@mv ~/.vim ~/.vim.backup || true
	@cp -R ./vim ~/.vim
	@(cd vim && make install)
	@cp ~/.zshrc ~/.zshrc.bak || echo "There was no existing .zshrc, so no need to backup"
	@cp ~/.tmux.conf ~/.tmux.conf.bak || echo "There was no existing .tmux.conf, so no need to backup"
	@cp tmux/tmux.conf ~/.tmux.conf

update:
	@git submodule foreach git pull
	@git pull
