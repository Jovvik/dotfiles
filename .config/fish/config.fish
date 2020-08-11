alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
function dotcode
	GIT_WORK_TREE=$HOME GIT_DIR=$HOME/.dotfiles code $HOME
end
cat ~/.cache/wal/sequences &
