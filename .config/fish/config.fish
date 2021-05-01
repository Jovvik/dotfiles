alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

starship init fish | source

set fish_greeting

cat ~/.cache/wal/sequences &
