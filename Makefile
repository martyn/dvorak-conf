all:update

install:
	@git submodule update --init
	@(cd vim && make install)
	@cp ~/.zshrc ~/.zshrc.bak || echo "There was no existing .zshrc, so no need to backup"
	@cp ~/.tmux.conf ~/.tmux.conf.bak || echo "There was no existing .tmux.conf, so no need to backup"
	@ln -s tmux/tmux.conf ~/.tmux.conf

update:
	@git submodule foreach git pull
	@git pull
