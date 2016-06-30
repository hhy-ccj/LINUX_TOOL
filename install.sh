mv $HOME/.vim 		$HOME/.vim_backup
mv $HOME/.vimrc 	$HOME/.vimrc_backup
mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh_backup
mv $HOME/.zshrc 	$HOME/.zshrc_backup
mv $HOME/.tmux.conf $HOME/.tmux.conf_backup
ln -s LINUX_TOOL/vim/.vim		$HOME/
ln -s LINUX_TOOL/vim/.vimrc		$HOME/
ln -s LINUX_TOOL/zsh/.oh-my-zsh	$HOME/
ln -s LINUX_TOOL/zsh/.zshrc		$HOME/
ln -s LINUX_TOOL/zsh/.tmux.conf	$HOME/
