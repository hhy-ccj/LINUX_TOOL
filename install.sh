# 为原来文件备份
mv $HOME/.vim						$HOME/.vim_backup
mv $HOME/.vimrc						$HOME/.vimrc_backup
mv $HOME/.oh-my-zsh					$HOME/.oh-my-zsh_backup
mv $HOME/.zshrc						$HOME/.zshrc_backup
mv $HOME/.tmux.conf					$HOME/.tmux.conf_backup
# 在$HOME下创建快捷方式
tool_path=$(cd "$(dirname "$0")"; pwd)
ln -s $tool_path/vim/.vim			$HOME/
ln -s $tool_path/vim/.vimrc			$HOME/
ln -s $tool_path/zsh/.oh-my-zsh		$HOME/
ln -s $tool_path/zsh/.zshrc			$HOME/
ln -s $tool_path/zsh/.tmux.conf		$HOME/
